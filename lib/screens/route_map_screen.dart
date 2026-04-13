import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:hackfusion/widgets/widgets.dart';
import 'package:latlong2/latlong.dart';
import '../routing/graph.dart';
import '../routing/dijkstra.dart';
import '../services/app_theme.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/ml_provider.dart';

class RouteMapScreen extends ConsumerStatefulWidget {
  const RouteMapScreen({super.key});

  @override
  ConsumerState<RouteMapScreen> createState() => _RouteMapScreenState();
}

class _RouteMapScreenState extends ConsumerState<RouteMapScreen> {
  RouteGraph? _graph;
  RouteResult? _result;
  String? _selectedStart;
  String? _selectedEnd;
  bool _loading = true;
  bool _floodMode = false; // flood toggle

  @override
  void initState() {
    super.initState();
    _loadGraph();
  }

  Future<void> _loadGraph() async {
    final graph = await RouteGraph.loadFromAssets();
    setState(() {
      _graph = graph;
      _loading = false;
    });
  }

  void _calculate() {
    if (_selectedStart == null || _selectedEnd == null) return;

    // Pass ML risk scores into Dijkstra (M7.3 integration)
    final mlState = ref.read(mlProvider);
    final mlRiskScores = mlState.hasRun
        ? {for (var r in mlState.riskResults) r.edgeId: r.impassabilityProbability}
        : null;

    final result = dijkstra(
      _graph!,
      _selectedStart!,
      _selectedEnd!,
      mlRiskScores: mlRiskScores,
    );
    setState(() => _result = result);
  }

  // Toggle all edges connected to this node as flooded/unfooded
  void _onNodeTapped(String nodeId) {
    if (!_floodMode || _graph == null) return;

    final edges = _graph!.adjacency[nodeId] ?? [];
    if (edges.isEmpty) return;

    // Check if majority are flooded — if so, unfood; else flood
    final floodedCount = edges.where((e) => e.isFlooded).length;
    final shouldFlood = floodedCount < edges.length / 2;

    setState(() {
      // Update in allEdges list (what the map renders)
      for (final edge in _graph!.allEdges) {
        if (edge.source == nodeId || edge.target == nodeId) {
          edge.isFlooded = shouldFlood;
        }
      }
      // Update in adjacency (what Dijkstra uses)
      for (final adjList in _graph!.adjacency.values) {
        for (final edge in adjList) {
          if (edge.source == nodeId || edge.target == nodeId) {
            edge.isFlooded = shouldFlood;
          }
        }
      }
      // Recalculate route immediately
      if (_selectedStart != null && _selectedEnd != null) {
        _result = dijkstra(_graph!, _selectedStart!, _selectedEnd!);
      }
    });
  }

  List<LatLng> _buildPolyline() {
    if (_result == null || _graph == null) return [];
    return _result!.path.map((id) {
      final node = _graph!.nodes[id]!;
      return LatLng(node.lat, node.lng);
    }).toList();
  }

  IconData _nodeIcon(String type) {
    switch (type) {
      case 'central_command':
        return Icons.account_balance_rounded;
      case 'supply_drop':
        return Icons.flight_rounded;
      case 'relief_camp':
        return Icons.home_rounded;
      case 'hospital':
        return Icons.local_hospital_rounded;
      default:
        return Icons.circle_rounded;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: AppBackground(
        child: SafeArea(
          child: Column(
            children: [
              _buildTopBar(context),
              _buildMLBanner(),   
              if (_floodMode) _buildFloodBanner(),
              _buildSelectors(),
              Expanded(child: _loading ? _buildLoader() : _buildMap()),
              if (_result != null) _buildResultCard(),
              if (_result == null &&
                  _selectedStart != null &&
                  _selectedEnd != null &&
                  !_loading)
                _buildNoPathBanner(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTopBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
      child: Row(
        children: [
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back_rounded,
                color: AppColors.text, size: 22),
          ),
          const SizedBox(width: 4),
          const Text(
            'Route Planner',
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w800,
              color: AppColors.text,
            ),
          ),
          const Spacer(),
          // Legend
          _LegendDot(color: AppColors.success, label: 'Road'),
          const SizedBox(width: 10),
          _LegendDot(color: AppColors.blue, label: 'River'),
          const SizedBox(width: 10),
          // Flood mode toggle
          GestureDetector(
            onTap: () => setState(() => _floodMode = !_floodMode),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: _floodMode
                    ? AppColors.error.withOpacity(0.15)
                    : AppColors.surface,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: _floodMode
                      ? AppColors.error.withOpacity(0.5)
                      : AppColors.border,
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.water_rounded,
                    size: 14,
                    color:
                        _floodMode ? AppColors.error : AppColors.textMuted,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    'Flood',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      color: _floodMode
                          ? AppColors.error
                          : AppColors.textMuted,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Banner shown when flood mode is active
  Widget _buildFloodBanner() {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 8, 16, 0),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.error.withOpacity(0.08),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.error.withOpacity(0.3)),
      ),
      child: const Row(
        children: [
          Icon(Icons.touch_app_rounded, size: 14, color: AppColors.error),
          SizedBox(width: 8),
          Expanded(
            child: Text(
              'Tap any node to flood/unflood its routes. Route recalculates instantly.',
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: AppColors.error,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSelectors() {
    if (_graph == null) return const SizedBox.shrink();
    final nodeList = _graph!.nodes.values.toList();

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
      child: Row(
        children: [
          Expanded(
            child: _NodeDropdown(
              label: 'From',
              nodes: nodeList,
              value: _selectedStart,
              onChanged: (v) => setState(() {
                _selectedStart = v;
                _result = null;
              }),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: _NodeDropdown(
              label: 'To',
              nodes: nodeList,
              value: _selectedEnd,
              onChanged: (v) => setState(() {
                _selectedEnd = v;
                _result = null;
              }),
            ),
          ),
          const SizedBox(width: 10),
          GestureDetector(
            onTap: _calculate,
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.blueDark,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(Icons.alt_route_rounded,
                  color: Colors.white, size: 22),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMap() {
    final polyline = _buildPolyline();
    final nodes = _graph!.nodes.values.toList();

    return ClipRRect(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
      child: FlutterMap(
        options: const MapOptions(
          initialCenter: LatLng(24.8949, 91.8687),
          initialZoom: 9,
        ),
        children: [
          TileLayer(
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            userAgentPackageName: 'com.hackfusion.app',
          ),

        // All edges
        PolylineLayer(
          polylines: _graph!.allEdges.map((e) {
            final from = _graph!.nodes[e.source]!;
            final to = _graph!.nodes[e.target]!;

            // M7.4 — color edges by ML predicted risk
            final mlState = ref.watch(mlProvider);
            final risk = mlState.riskFor(e.id);
            Color edgeColor;
            double width;

            if (e.isFlooded) {
              edgeColor = Colors.red.withOpacity(0.8);
              width = 4.0;
            } else if (mlState.hasRun && risk >= 0.75) {
              edgeColor = AppColors.error.withOpacity(0.7);  // critical
              width = 3.5;
            } else if (mlState.hasRun && risk >= 0.50) {
              edgeColor = AppColors.warning.withOpacity(0.7); // high
              width = 3.0;
            } else if (mlState.hasRun && risk >= 0.25) {
              edgeColor = AppColors.blue.withOpacity(0.6);   // medium
              width = 2.5;
            } else {
              edgeColor = Colors.grey.withOpacity(0.35);      // low/unknown
              width = 2.0;
            }

            return Polyline(
              points: [LatLng(from.lat, from.lng), LatLng(to.lat, to.lng)],
              color: edgeColor,
              strokeWidth: width,
            );
          }).toList(),
        ),

          // Active route
          if (polyline.isNotEmpty)
            PolylineLayer(
              polylines: [
                Polyline(
                  points: polyline,
                  color: AppColors.success,
                  strokeWidth: 5,
                ),
              ],
            ),

          // Node markers — tappable in flood mode
          MarkerLayer(
            markers: nodes.map((node) {
              final isOnPath = _result?.path.contains(node.id) ?? false;
              final connectedEdges = _graph!.adjacency[node.id] ?? [];
              final isFlooded =
                  connectedEdges.isNotEmpty &&
                  connectedEdges.every((e) => e.isFlooded);

              return Marker(
                point: LatLng(node.lat, node.lng),
                width: 44,
                height: 44,
                child: GestureDetector(
                  onTap: () => _onNodeTapped(node.id),
                  child: Tooltip(
                    message: _floodMode
                        ? 'Tap to flood/unflood'
                        : node.name,
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 250),
                      decoration: BoxDecoration(
                        color: isFlooded
                            ? AppColors.error.withOpacity(0.15)
                            : isOnPath
                                ? AppColors.blueDark
                                : AppColors.card,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: isFlooded
                              ? AppColors.error
                              : isOnPath
                                  ? AppColors.blue
                                  : AppColors.border,
                          width: isOnPath || isFlooded ? 3 : 1.5,
                        ),
                        boxShadow: isOnPath
                            ? [
                                BoxShadow(
                                  color: AppColors.blue.withOpacity(0.4),
                                  blurRadius: 8,
                                )
                              ]
                            : [],
                      ),
                      child: Icon(
                        isFlooded
                            ? Icons.water_rounded
                            : _nodeIcon(node.type),
                        size: 20,
                        color: isFlooded
                            ? AppColors.error
                            : isOnPath
                                ? Colors.white
                                : AppColors.textMuted,
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildResultCard() {
    final modeSet = _result!.modes.toSet();
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          const Icon(Icons.check_circle_rounded,
              color: AppColors.success, size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _result!.path
                      .map((id) =>
                          _graph!.nodes[id]!.name.split(' ').first)
                      .join(' → '),
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: AppColors.text,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  'via ${modeSet.join(' + ')}',
                  style: const TextStyle(
                    fontSize: 11,
                    color: AppColors.textMuted,
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '${_result!.totalMins.toInt()} min',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                  color: AppColors.blueDark,
                ),
              ),
              const Text(
                'optimal',
                style:
                    TextStyle(fontSize: 10, color: AppColors.textMuted),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildNoPathBanner() {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.error.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.error.withOpacity(0.4)),
      ),
      child: const Row(
        children: [
          Icon(Icons.block_rounded, color: AppColors.error, size: 18),
          SizedBox(width: 10),
          Expanded(
            child: Text(
              'No passable route — all paths are flood-blocked.',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: AppColors.text,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoader() {
    return const Center(
      child: CircularProgressIndicator(color: AppColors.blue),
    );
  }
  Widget _buildMLBanner() {
  final mlState = ref.watch(mlProvider);
  if (!mlState.hasRun) return const SizedBox.shrink();

  final highRisk = mlState.riskResults
      .where((r) => r.impassabilityProbability >= 0.7)
      .length;

  return Container(
    margin: const EdgeInsets.fromLTRB(16, 6, 16, 0),
    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
    decoration: BoxDecoration(
      color: AppColors.warning.withOpacity(0.10),
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: AppColors.warning.withOpacity(0.4)),
    ),
    child: Row(
      children: [
        const Icon(Icons.psychology_rounded,
            size: 14, color: AppColors.warning),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            'ML active — $highRisk high-risk edges penalized in routing',
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: AppColors.text,
            ),
          ),
        ),
      ],
    ),
  );
}

  
}

// ── Helper Widgets ────────────────────────────────────────────

class _NodeDropdown extends StatelessWidget {
  final String label;
  final List<GraphNode> nodes;
  final String? value;
  final ValueChanged<String?> onChanged;

  const _NodeDropdown({
    required this.label,
    required this.nodes,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.border),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          hint: Text(label,
              style: const TextStyle(
                  fontSize: 12, color: AppColors.textMuted)),
          isExpanded: true,
          dropdownColor: AppColors.card,
          style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: AppColors.text),
          items: nodes
              .map((n) => DropdownMenuItem(
                    value: n.id,
                    child: Text(n.name.split(' ').first,
                        overflow: TextOverflow.ellipsis),
                  ))
              .toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }
}

class _LegendDot extends StatelessWidget {
  final Color color;
  final String label;

  const _LegendDot({required this.color, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
            width: 10,
            height: 10,
            decoration:
                BoxDecoration(color: color, shape: BoxShape.circle)),
        const SizedBox(width: 4),
        Text(label,
            style: const TextStyle(
                fontSize: 10, color: AppColors.textMuted)),
      ],
    );
  }
}