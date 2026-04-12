import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/triage_case.dart';

class TriageNotifier extends StateNotifier<List<TriageCase>> {
  Timer? _escalationTimer;
  Timer? _uiTimer;

  TriageNotifier() : super(_demoData()) {
    _startEscalationTimer();
  }

  // ── Demo data preloaded ───────────────────────────────────
  static List<TriageCase> _demoData() {
    final now = DateTime.now();
    return [
      TriageCase(
        id: 'TC001',
        title: 'Medical Emergency',
        location: 'Sylhet Zone 4',
        priority: TriagePriority.P0,
        createdAt: now.subtract(const Duration(minutes: 28)),
      ),
      TriageCase(
        id: 'TC002',
        title: 'Food Supply Critical',
        location: 'Sunamganj Camp B',
        priority: TriagePriority.P1,
        createdAt: now.subtract(const Duration(minutes: 100)),
      ),
      TriageCase(
        id: 'TC003',
        title: 'Shelter Needed',
        location: 'Habiganj North',
        priority: TriagePriority.P2,
        createdAt: now.subtract(const Duration(minutes: 300)),
      ),
      TriageCase(
        id: 'TC004',
        title: 'Water Purification',
        location: 'Moulvibazar East',
        priority: TriagePriority.P3,
        createdAt: now.subtract(const Duration(minutes: 60)),
      ),
      TriageCase(
        id: 'TC005',
        title: 'Evacuation Request',
        location: 'Netrokona Basin',
        priority: TriagePriority.P1,
        createdAt: now.subtract(const Duration(minutes: 110)),
      ),
    ];
  }

  // ── Escalation every 10 seconds ───────────────────────────
  void _startEscalationTimer() {
    _escalationTimer = Timer.periodic(
      const Duration(seconds: 10),
      (_) => autoEscalate(),
    );
  }

  void autoEscalate() {
    state = state.map((c) {
      if (!c.isResolved && c.isSLABreached) {
        c.priority = c.priority.escalated;
      }
      return c;
    }).toList();
  }

  // ── Add new case ──────────────────────────────────────────
  void addCase({
    required String title,
    required String location,
    required TriagePriority priority,
  }) {
    final newCase = TriageCase(
      id: 'TC${(state.length + 1).toString().padLeft(3, '0')}',
      title: title,
      location: location,
      priority: priority,
      createdAt: DateTime.now(),
    );
    state = [...state, newCase];
  }

  // ── Resolve case ──────────────────────────────────────────
  void resolveCase(String id) {
    state = state.map((c) {
      if (c.id == id) c.isResolved = true;
      return c;
    }).toList();
  }

  // ── Sort: unresolved first, then by priority ──────────────
  List<TriageCase> get sorted {
    final list = [...state];
    list.sort((a, b) {
      if (a.isResolved != b.isResolved) {
        return a.isResolved ? 1 : -1;
      }
      return a.priority.index.compareTo(b.priority.index);
    });
    return list;
  }

  @override
  void dispose() {
    _escalationTimer?.cancel();
    _uiTimer?.cancel();
    super.dispose();
  }
}

final triageProvider =
    StateNotifierProvider<TriageNotifier, List<TriageCase>>(
  (ref) => TriageNotifier(),
);