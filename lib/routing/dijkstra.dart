import 'package:collection/collection.dart';
import 'graph.dart';

class RouteResult {
  final List<String> path; // ordered node IDs
  final double totalMins; // total travel time
  final List<String> modes; // transport mode per hop

  const RouteResult({
    required this.path,
    required this.totalMins,
    required this.modes,
  });
}

RouteResult? dijkstra(RouteGraph graph, String startId, String endId) {
  if (!graph.nodes.containsKey(startId) ||
      !graph.nodes.containsKey(endId)) return null;
  if (startId == endId) return RouteResult(
    path: [startId], totalMins: 0, modes: [],
  );

  final dist = <String, double>{};
  final prev = <String, String?>{};
  final prevMode = <String, String>{};

  for (var id in graph.nodes.keys) {
    dist[id] = double.infinity;
  }
  dist[startId] = 0;

  // PriorityQueue sorted by cost ascending
  final pq = PriorityQueue<(double, String)>(
    (a, b) => a.$1.compareTo(b.$1),
  );
  pq.add((0, startId));

  while (pq.isNotEmpty) {
    final (cost, u) = pq.removeFirst();

    if (cost > dist[u]!) continue;
    if (u == endId) break;

    for (var edge in graph.adjacency[u] ?? []) {
      if (edge.isFlooded) continue; // skip blocked routes

      final newCost = dist[u]! + edge.weight;
      if (newCost < dist[edge.target]!) {
        dist[edge.target] = newCost;
        prev[edge.target] = u;
        prevMode[edge.target] = edge.type;
        pq.add((newCost, edge.target));
      }
    }
  }

  // No path found
  if (dist[endId] == double.infinity) return null;

  // Reconstruct path
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