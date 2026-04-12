import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ActivityItem {
  final String message;
  final DateTime time;
  final IconData icon;
  final Color color;

  ActivityItem({
    required this.message,
    required this.time,
    required this.icon,
    required this.color,
  });
}

class ActivityNotifier extends StateNotifier<List<ActivityItem>> {
  ActivityNotifier() : super(_seedData());

  // Seed with realistic demo data so feed isn't empty on launch
  static List<ActivityItem> _seedData() {
    final now = DateTime.now();
    return [
      ActivityItem(
        message: 'Node BD-04 joined mesh',
        time: now.subtract(const Duration(minutes: 5)),
        icon: Icons.device_hub_rounded,
        color: const Color(0xFF7EC8E3),
      ),
      ActivityItem(
        message: 'Route recalculated — flood detected',
        time: now.subtract(const Duration(minutes: 11)),
        icon: Icons.alt_route_rounded,
        color: const Color(0xFFFFCC80),
      ),
      ActivityItem(
        message: 'P0 triage alert raised',
        time: now.subtract(const Duration(minutes: 18)),
        icon: Icons.warning_amber_rounded,
        color: const Color(0xFFFF7B8A),
      ),
    ];
  }

  void add({
    required String message,
    required IconData icon,
    required Color color,
  }) {
    final item = ActivityItem(
      message: message,
      time: DateTime.now(),
      icon: icon,
      color: color,
    );
    // Newest first, keep max 20
    state = [item, ...state].take(20).toList();
  }

  void addDeliveryConfirmed(String deliveryId) {
    add(
      message: 'Delivery #$deliveryId confirmed',
      icon: Icons.check_circle_rounded,
      color: const Color(0xFF3DBFA3),
    );
  }

  void addTriageResolved(String caseId) {
    add(
      message: 'Triage case $caseId resolved',
      icon: Icons.medical_services_rounded,
      color: const Color(0xFF4AADD6),
    );
  }

  void addTriageCreated(String title, String priority) {
    add(
      message: '$priority triage alert — $title',
      icon: Icons.warning_amber_rounded,
      color: const Color(0xFFFF7B8A),
    );
  }

  void addSynced() {
    add(
      message: 'Mesh sync completed',
      icon: Icons.sync_rounded,
      color: const Color(0xFF9EECD9),
    );
  }
}

final activityProvider =
    StateNotifierProvider<ActivityNotifier, List<ActivityItem>>(
  (ref) => ActivityNotifier(),
);