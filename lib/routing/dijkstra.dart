import 'package:collection/collection.dart';
import 'graph.dart';

class RouteResult {
  final List<String> path;
  final double totalMins;
  final List<String> modes;

  const RouteResult({
    required this.path,
    required this.totalMins,
    required this.modes,
  });
}

/// [mlRiskScores] optional map of edgeId → impassability probability (0.0–1.0)
/// Edges with probability ≥ 0.7 get weight penalized (M7.3)
RouteResult? dijkstra(
  RouteGraph graph,
  String startId,
  String endId, {
  Map<String, double>? mlRiskScores,
}) {
  if (!graph.nodes.containsKey(startId) ||
      !graph.nodes.containsKey(endId)) return null;

  if (startId == endId) {
    return RouteResult(path: [startId], totalMins: 0, modes: []);
  }

  final dist = <String, double>{};
  final prev = <String, String?>{};
  final prevMode = <String, String>{};

  for (var id in graph.nodes.keys) {
    dist[id] = double.infinity;
  }
  dist[startId] = 0;

  final pq = PriorityQueue<(double, String)>(
    (a, b) => a.$1.compareTo(b.$1),
  );
  pq.add((0, startId));

  while (pq.isNotEmpty) {
    final (cost, u) = pq.removeFirst();
    if (cost > dist[u]!) continue;
    if (u == endId) break;

    for (var edge in graph.adjacency[u] ?? []) {
      if (edge.isFlooded) continue;

      double edgeWeight = edge.weight;

      // M7.3 — penalize high-risk edges from ML prediction
      if (mlRiskScores != null) {
        final risk = mlRiskScores[edge.id] ?? 0.0;
        if (risk >= 0.7) {
          // High risk: penalize weight heavily so Dijkstra avoids it
          edgeWeight *= (1 + risk * 4.0);
        } else if (risk >= 0.5) {
          // Medium risk: slight penalty
          edgeWeight *= (1 + risk * 1.5);
        }
      }

      final newCost = dist[u]! + edgeWeight;
      if (newCost < dist[edge.target]!) {
        dist[edge.target] = newCost;
        prev[edge.target] = u;
        prevMode[edge.target] = edge.type;
        pq.add((newCost, edge.target));
      }
    }
  }

  if (dist[endId] == double.infinity) return null;

  final path = <String>[];
  final modes = <String>[];
  var cur = endId;
  while (cur != startId) {
    path.insert(0, cur);
    if (prevMode[cur] != null) modes.insert(0, prevMode[cur]!);
    cur = prev[cur]!;
  }
  path.insert(0, startId);

  return RouteResult(
    path: path,
    totalMins: dist[endId]!,
    modes: modes,
  );
}