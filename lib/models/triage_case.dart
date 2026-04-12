import 'package:flutter/material.dart';

enum TriagePriority { P0, P1, P2, P3 }

extension TriagePriorityExtension on TriagePriority {
  String get label => name;

  Color get color {
    switch (this) {
      case TriagePriority.P0:
        return const Color(0xFFFF7B8A); // AppColors.error
      case TriagePriority.P1:
        return const Color(0xFFFFCC80); // AppColors.warning
      case TriagePriority.P2:
        return const Color(0xFF7EC8E3); // AppColors.blue
      case TriagePriority.P3:
        return const Color(0xFF9EECD9); // AppColors.mint
    }
  }

  Color get textColor {
    switch (this) {
      case TriagePriority.P0:
        return const Color(0xFF8B0000);
      case TriagePriority.P1:
        return const Color(0xFF7A4F00);
      case TriagePriority.P2:
        return const Color(0xFF1A5F7A);
      case TriagePriority.P3:
        return const Color(0xFF0D6B55);
    }
  }

  int get slaMinutes {
    switch (this) {
      case TriagePriority.P0: return 30;
      case TriagePriority.P1: return 120;
      case TriagePriority.P2: return 360;
      case TriagePriority.P3: return 1440;
    }
  }

  TriagePriority get escalated {
    switch (this) {
      case TriagePriority.P3: return TriagePriority.P2;
      case TriagePriority.P2: return TriagePriority.P1;
      case TriagePriority.P1: return TriagePriority.P0;
      case TriagePriority.P0: return TriagePriority.P0;
    }
  }
}

class TriageCase {
  final String id;
  final String title;
  final String location;
  TriagePriority priority;
  final DateTime createdAt;
  bool isResolved;

  TriageCase({
    required this.id,
    required this.title,
    required this.location,
    required this.priority,
    required this.createdAt,
    this.isResolved = false,
  });

  int get slaMinutes => priority.slaMinutes;

  Duration get remainingTime {
    final deadline = createdAt.add(Duration(minutes: slaMinutes));
    final remaining = deadline.difference(DateTime.now());
    return remaining.isNegative ? Duration.zero : remaining;
  }

  bool get isSLABreached {
    final deadline = createdAt.add(Duration(minutes: slaMinutes));
    return DateTime.now().isAfter(deadline);
  }

  bool get isBreachingsSoon {
    // warn when less than 20% of SLA time remains
    final totalSecs = slaMinutes * 60;
    final remainingSecs = remainingTime.inSeconds;
    return remainingSecs < totalSecs * 0.2 && !isSLABreached;
  }
}