import 'package:flutter/material.dart';
import '../services/app_theme.dart';
import '../widgets/widgets.dart';
import '../routing/graph.dart';
import '../models/rainfall_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/ml_provider.dart';

class MLPredictScreen extends ConsumerStatefulWidget {
  const MLPredictScreen({super.key});

  @override
  ConsumerState<MLPredictScreen> createState() => _MLPredictScreenState();
}

class _MLPredictScreenState extends ConsumerState<MLPredictScreen> {
  double _rainfallIntensity = 0.4;
  List<EdgeRiskResult> _results = [];
  List<GraphEdge> _edges = [];
  bool _loading = true;
  bool _running = false;

  @override
  void initState() {
    super.initState();
    _loadGraph();
  }

  Future<void> _loadGraph() async {
    final graph = await RouteGraph.loadFromAssets();
    setState(() {
      _edges = graph.allEdges;
      _loading = false;
    });
    _runPrediction();
  }

  void _runPrediction() {
    if (_edges.isEmpty) return;
    setState(() => _running = true);

    Future.delayed(const Duration(milliseconds: 600), () {
      // Run via provider so RouteMapScreen can read the results
      ref.read(mlProvider.notifier).runPrediction(
        _edges,
        _rainfallIntensity,
      );
      setState(() {
        _results = ref.read(mlProvider).riskResults;
        _running = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: AppBackground(
        child: SafeArea(
          child: Column(
            children: [
              _buildHeader(context),
              Expanded(
                child: _loading
                    ? const Center(
                        child: CircularProgressIndicator(
                            color: AppColors.blueDark))
                    : SingleChildScrollView(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildModelCard(),
                            const SizedBox(height: 16),
                            _buildRainfallSlider(),
                            const SizedBox(height: 20),
                            _buildRunButton(),
                            const SizedBox(height: 20),
                            if (_results.isNotEmpty) ...[
                              _buildSummaryRow(),
                              const SizedBox(height: 16),
                              _buildResultsList(),
                            ],
                          ],
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
      child: Row(
        children: [
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back_ios_rounded,
                color: AppColors.text, size: 20),
          ),
          const SizedBox(width: 4),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Route Decay Predictor',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w800,
                    color: AppColors.text,
                  ),
                ),
                Text(
                  'ML-based flood impassability classifier',
                  style: TextStyle(
                      fontSize: 11, color: AppColors.textMuted),
                ),
              ],
            ),
          ),
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: AppColors.success.withOpacity(0.12),
              borderRadius: BorderRadius.circular(6),
            ),
            child: const Text(
              'ON-DEVICE',
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w800,
                color: AppColors.success,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildModelCard() {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.model_training_rounded,
                  size: 16, color: AppColors.blueDark),
              SizedBox(width: 8),
              Text(
                'Model Card',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w800,
                  color: AppColors.text,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          _modelRow('Type', FloodClassifier.modelType),
          _modelRow('Train samples',
              '${FloodClassifier.trainSamples} edges × time'),
          _modelRow('Test samples', '${FloodClassifier.testSamples}'),
          const SizedBox(height: 8),
          Row(
            children: [
              _metricChip(
                  'F1', FloodClassifier.f1Score, AppColors.success),
              const SizedBox(width: 8),
              _metricChip('Precision', FloodClassifier.precision,
                  AppColors.blueDark),
              const SizedBox(width: 8),
              _metricChip(
                  'Recall', FloodClassifier.recall, AppColors.mint),
            ],
          ),
        ],
      ),
    );
  }

  Widget _modelRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        children: [
          Text('$label: ',
              style: const TextStyle(
                  fontSize: 11, color: AppColors.textMuted)),
          Text(value,
              style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: AppColors.text)),
        ],
      ),
    );
  }

  Widget _metricChip(String label, double value, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 6),
        decoration: BoxDecoration(
          color: color.withOpacity(0.08),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: color.withOpacity(0.2)),
        ),
        child: Column(
          children: [
            Text(
              value.toStringAsFixed(2),
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w800,
                  color: color),
            ),
            Text(label,
                style: const TextStyle(
                    fontSize: 10, color: AppColors.textMuted)),
          ],
        ),
      ),
    );
  }

  Widget _buildRainfallSlider() {
    final mm = (_rainfallIntensity * 100).toStringAsFixed(0);
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.water_drop_rounded,
                  size: 16, color: AppColors.blue),
              const SizedBox(width: 8),
              const Text(
                'Rainfall Intensity (simulated sensor)',
                style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: AppColors.text),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: AppColors.blue.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  '$mm mm/hr',
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w800,
                    color: AppColors.blueDark,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          const Text(
            'Ingested at 1Hz — cumulative over 2hr window',
            style:
                TextStyle(fontSize: 10, color: AppColors.textMuted),
          ),
          SliderTheme(
            data: SliderTheme.of(context).copyWith(
              activeTrackColor: AppColors.blueDark,
              inactiveTrackColor: AppColors.border,
              thumbColor: AppColors.blueDark,
              overlayColor: AppColors.blue.withOpacity(0.12),
            ),
            child: Slider(
              value: _rainfallIntensity,
              min: 0.0,
              max: 1.0,
              divisions: 20,
              onChanged: (v) {
                setState(() => _rainfallIntensity = v);
                _runPrediction();
              },
            ),
          ),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('0 mm/hr',
                  style: TextStyle(fontSize: 10, color: AppColors.textMuted)),
              Text('Light',
                  style: TextStyle(fontSize: 10, color: AppColors.textMuted)),
              Text('⚡ Demo zone',
                  style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                      color: AppColors.warning)),
              Text('100 mm/hr',
                  style: TextStyle(fontSize: 10, color: AppColors.textMuted)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRunButton() {
    return SizedBox(
      width: double.infinity,
      child: GestureDetector(
        onTap: _running ? null : _runPrediction,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 14),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [AppColors.blueDark, AppColors.blue],
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Center(
            child: _running
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                        strokeWidth: 2, color: Colors.white),
                  )
                : const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.play_arrow_rounded,
                          color: Colors.white, size: 20),
                      SizedBox(width: 8),
                      Text(
                        'Run Prediction',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }

  Widget _buildSummaryRow() {
    final critical =
        _results.where((r) => r.riskLevel == RiskLevel.critical).length;
    final high =
        _results.where((r) => r.riskLevel == RiskLevel.high).length;
    final safe =
        _results.where((r) => r.riskLevel == RiskLevel.low).length;

    return Row(
      children: [
        _summaryChip('Critical', critical, AppColors.error),
        const SizedBox(width: 8),
        _summaryChip('High Risk', high, AppColors.warning),
        const SizedBox(width: 8),
        _summaryChip('Safe', safe, AppColors.success),
      ],
    );
  }

  Widget _summaryChip(String label, int count, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: color.withOpacity(0.10),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: color.withOpacity(0.3)),
        ),
        child: Column(
          children: [
            Text('$count',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                    color: color)),
            Text(label,
                style: const TextStyle(
                    fontSize: 10, color: AppColors.textMuted)),
          ],
        ),
      ),
    );
  }

  Widget _buildResultsList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Edge Risk Analysis',
          style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w800,
              color: AppColors.text),
        ),
        const SizedBox(height: 10),
        ..._results.map((r) => _EdgeRiskCard(result: r)),
      ],
    );
  }
}

class _EdgeRiskCard extends StatelessWidget {
  final EdgeRiskResult result;

  const _EdgeRiskCard({required this.result});

  @override
  Widget build(BuildContext context) {
    final color = _riskColor(result.riskLevel);
    final pct =
        (result.impassabilityProbability * 100).toStringAsFixed(1);
    final time =
        '${result.predictionTime.hour.toString().padLeft(2, '0')}:${result.predictionTime.minute.toString().padLeft(2, '0')}:${result.predictionTime.second.toString().padLeft(2, '0')}';

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.4)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 10,
                height: 10,
                decoration: BoxDecoration(
                    color: color, shape: BoxShape.circle),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  result.edgeId,
                  style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: AppColors.text),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  result.riskLevel.name.toUpperCase(),
                  style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w800,
                      color: color),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          // Probability bar
          Row(
            children: [
              const Text('Risk: ',
                  style: TextStyle(
                      fontSize: 11, color: AppColors.textMuted)),
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: LinearProgressIndicator(
                    value: result.impassabilityProbability,
                    backgroundColor: AppColors.surface,
                    valueColor: AlwaysStoppedAnimation(color),
                    minHeight: 8,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Text(
                '$pct%',
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w800,
                    color: color),
              ),
            ],
          ),
          const SizedBox(height: 8),
          // Top feature
          Row(
            children: [
              const Icon(Icons.info_outline_rounded,
                  size: 12, color: AppColors.textMuted),
              const SizedBox(width: 4),
              Expanded(
                child: Text(
                  'Key factor: ${result.topFeature}',
                  style: const TextStyle(
                      fontSize: 11, color: AppColors.textMuted),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          // Prediction timestamp
          Row(
            children: [
              const Icon(Icons.schedule_rounded,
                  size: 12, color: AppColors.textDim),
              const SizedBox(width: 4),
              Text(
                'Predicted at $time  •  2hr horizon',
                style: const TextStyle(
                    fontSize: 10, color: AppColors.textDim),
              ),
              if (result.impassabilityProbability >= 0.7) ...[
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: AppColors.error.withOpacity(0.10),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: const Text(
                    '⚠ REROUTE',
                    style: TextStyle(
                        fontSize: 9,
                        fontWeight: FontWeight.w800,
                        color: AppColors.error),
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }

  Color _riskColor(RiskLevel level) {
    switch (level) {
      case RiskLevel.critical:
        return AppColors.error;
      case RiskLevel.high:
        return AppColors.warning;
      case RiskLevel.medium:
        return AppColors.blue;
      case RiskLevel.low:
        return AppColors.success;
    }
  }
}