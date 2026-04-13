import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/rainfall_model.dart';
import '../routing/graph.dart';

class MLState {
  final double rainfallIntensity;
  final List<EdgeRiskResult> riskResults;
  final bool hasRun;

  const MLState({
    this.rainfallIntensity = 0.4,
    this.riskResults = const [],
    this.hasRun = false,
  });

  /// Returns impassability probability for a given edge ID
  /// Returns 0.0 if edge not found or ML hasn't run yet
  double riskFor(String edgeId) {
    try {
      return riskResults
          .firstWhere((r) => r.edgeId == edgeId)
          .impassabilityProbability;
    } catch (_) {
      return 0.0;
    }
  }

  MLState copyWith({
    double? rainfallIntensity,
    List<EdgeRiskResult>? riskResults,
    bool? hasRun,
  }) {
    return MLState(
      rainfallIntensity: rainfallIntensity ?? this.rainfallIntensity,
      riskResults: riskResults ?? this.riskResults,
      hasRun: hasRun ?? this.hasRun,
    );
  }
}

class MLNotifier extends StateNotifier<MLState> {
  MLNotifier() : super(const MLState());

  void runPrediction(List<GraphEdge> edges, double intensity) {
    final features = RainfallIngester.ingestFeatures(edges, intensity);
    final results = FloodClassifier.classify(features);
    state = state.copyWith(
      rainfallIntensity: intensity,
      riskResults: results,
      hasRun: true,
    );
  }

  void reset() {
    state = const MLState();
  }
}

final mlProvider =
    StateNotifierProvider<MLNotifier, MLState>((ref) => MLNotifier());
    