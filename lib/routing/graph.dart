import 'dart:convert';
import 'package:flutter/services.dart';

class GraphNode {
  final String id;
  final String name;
  final String type;
  final double lat;
  final double lng;

  const GraphNode({
    required this.id,
    required this.name,
    required this.type,
    required this.lat,
    required this.lng,
  });

  factory GraphNode.fromJson(Map<String, dynamic> json) {
    return GraphNode(
      id: json['id'],
      name: json['name'],
      type: json['type'],
      lat: (json['lat'] as num).toDouble(),
      lng: (json['lng'] as num).toDouble(),
    );
  }
}

class GraphEdge {
  final String id;
  final String source;
  final String target;
  final String type; // 'road' or 'river'
  final double weight; // base_weight_mins
  bool isFlooded;

  GraphEdge({
    required this.id,
    required this.source,
    required this.target,
    required this.type,
    required this.weight,
    required this.isFlooded,
  });

  factory GraphEdge.fromJson(Map<String, dynamic> json) {
    return GraphEdge(
      id: json['id'],
      source: json['source'],
      target: json['target'],
      type: json['type'],
      weight: (json['base_weight_mins'] as num).toDouble(),
      isFlooded: json['is_flooded'] as bool,
    );
  }
}

class RouteGraph {
  final Map<String, GraphNode> nodes = {};
  final Map<String, List<GraphEdge>> adjacency = {};
  final List<GraphEdge> allEdges = [];

  void loadFromJson(Map<String, dynamic> json) {
    // Parse nodes
    for (var n in json['nodes']) {
      final node = GraphNode.fromJson(n);
      nodes[node.id] = node;
    }

    // Parse edges — undirected, so add both directions
    for (var e in json['edges']) {
      final edge = GraphEdge.fromJson(e);
      allEdges.add(edge);

      adjacency.putIfAbsent(edge.source, () => []).add(edge);

      // Reverse edge
      adjacency.putIfAbsent(edge.target, () => []).add(GraphEdge(
        id: '${edge.id}_rev',
        source: edge.target,
        target: edge.source,
        type: edge.type,
        weight: edge.weight,
        isFlooded: edge.isFlooded,
      ));
    }
  }

  static Future<RouteGraph> loadFromAssets() async {
    final jsonStr =
        await rootBundle.loadString('assets/sylhet_map.json');
    final jsonData = jsonDecode(jsonStr) as Map<String, dynamic>;
    final graph = RouteGraph();
    graph.loadFromJson(jsonData);
    return graph;
  }
}