import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/triage_case.dart';
import '../providers/triage_provider.dart';
import '../services/app_theme.dart';
import '../widgets/widgets.dart';

class TriageScreen extends ConsumerStatefulWidget {
  const TriageScreen({super.key});

  @override
  ConsumerState<TriageScreen> createState() => _TriageScreenState();
}

class _TriageScreenState extends ConsumerState<TriageScreen> {
  Timer? _uiTimer;

  @override
  void initState() {
    super.initState();
    // Rebuild every second so countdowns are live
    _uiTimer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (mounted) setState(() {});
    });
  }

  @override
  void dispose() {
    _uiTimer?.cancel();
    super.dispose();
  }

  void _showAddCaseSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => _AddCaseSheet(
        onAdd: (title, location, priority) {
          ref.read(triageProvider.notifier).addCase(
                title: title,
                location: location,
                priority: priority,
              );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final notifier = ref.read(triageProvider.notifier);
    final cases = notifier.sorted;

    final activeCount = cases.where((c) => !c.isResolved).length;
    final p0Count = cases
        .where((c) => !c.isResolved && c.priority == TriagePriority.P0)
        .length;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: AppBackground(
        child: SafeArea(
          child: Column(
            children: [
              // ── Top bar ─────────────────────────────────
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 12, 16, 0),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.arrow_back_rounded,
                          color: AppColors.text, size: 22),
                    ),
                    const Text(
                      'Triage Queue',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w800,
                        color: AppColors.text,
                      ),
                    ),
                    const Spacer(),
                    // Active count badge
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: p0Count > 0
                            ? AppColors.error.withOpacity(0.15)
                            : AppColors.surface,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: p0Count > 0
                              ? AppColors.error.withOpacity(0.4)
                              : AppColors.border,
                        ),
                      ),
                      child: Text(
                        '$activeCount active',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: p0Count > 0
                              ? AppColors.error
                              : AppColors.textMuted,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // ── P0 alert banner ──────────────────────────
              if (p0Count > 0)
                Container(
                  margin: const EdgeInsets.fromLTRB(16, 12, 16, 0),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 14, vertical: 10),
                  decoration: BoxDecoration(
                    color: AppColors.error.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10),
                    border:
                        Border.all(color: AppColors.error.withOpacity(0.4)),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.warning_rounded,
                          color: AppColors.error, size: 16),
                      const SizedBox(width: 8),
                      Text(
                        '$p0Count critical P0 ${p0Count == 1 ? 'case' : 'cases'} — immediate action required',
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: AppColors.error,
                        ),
                      ),
                    ],
                  ),
                ),

              const SizedBox(height: 12),

              // ── Case list ────────────────────────────────
              Expanded(
                child: cases.isEmpty
                    ? const Center(
                        child: Text(
                          'No triage cases',
                          style: TextStyle(color: AppColors.textMuted),
                        ),
                      )
                    : ListView.builder(
                        padding:
                            const EdgeInsets.fromLTRB(16, 0, 16, 100),
                        itemCount: cases.length,
                        itemBuilder: (context, i) {
                          return _TriageCard(
                            triageCase: cases[i],
                            onResolve: () => ref
                                .read(triageProvider.notifier)
                                .resolveCase(cases[i].id),
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),

      // ── FAB: Add case ─────────────────────────────────────
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _showAddCaseSheet,
        backgroundColor: AppColors.blueDark,
        foregroundColor: Colors.white,
        icon: const Icon(Icons.add_rounded, size: 20),
        label: const Text(
          'Add Case',
          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 13),
        ),
      ),
    );
  }
}

// ── Triage Card ───────────────────────────────────────────────
class _TriageCard extends StatelessWidget {
  final TriageCase triageCase;
  final VoidCallback onResolve;

  const _TriageCard({required this.triageCase, required this.onResolve});

  String _formatDuration(Duration d) {
    if (d == Duration.zero) return 'BREACHED';
    final h = d.inHours;
    final m = d.inMinutes.remainder(60);
    final s = d.inSeconds.remainder(60);
    if (h > 0) return '${h}h ${m}m';
    if (m > 0) return '${m}m ${s}s';
    return '${s}s';
  }

  @override
  Widget build(BuildContext context) {
    final c = triageCase;
    final remaining = c.remainingTime;
    final breached = c.isSLABreached;
    final warningSoon = c.isBreachingsSoon;

    return Opacity(
      opacity: c.isResolved ? 0.5 : 1.0,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: AppColors.card,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: breached && !c.isResolved
                ? AppColors.error.withOpacity(0.5)
                : warningSoon && !c.isResolved
                    ? AppColors.warning.withOpacity(0.5)
                    : AppColors.border,
            width: breached && !c.isResolved ? 1.5 : 1,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ── Header row ─────────────────────────────
              Row(
                children: [
                  // Priority badge
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: c.priority.color.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(
                          color: c.priority.color.withOpacity(0.5)),
                    ),
                    child: Text(
                      c.priority.label,
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w800,
                        color: c.priority.textColor,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      c.title,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: c.isResolved
                            ? AppColors.textMuted
                            : AppColors.text,
                        decoration: c.isResolved
                            ? TextDecoration.lineThrough
                            : null,
                      ),
                    ),
                  ),
                  // Resolved checkmark
                  if (c.isResolved)
                    const Icon(Icons.check_circle_rounded,
                        color: AppColors.success, size: 18),
                ],
              ),
              const SizedBox(height: 8),

              // ── Location ───────────────────────────────
              Row(
                children: [
                  const Icon(Icons.location_on_rounded,
                      size: 13, color: AppColors.textMuted),
                  const SizedBox(width: 4),
                  Text(
                    c.location,
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppColors.textMuted,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    '· ${c.id}',
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppColors.textDim,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),

              // ── SLA timer + resolve button ─────────────
              Row(
                children: [
                  // Timer
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: breached && !c.isResolved
                          ? AppColors.error.withOpacity(0.1)
                          : warningSoon && !c.isResolved
                              ? AppColors.warning.withOpacity(0.1)
                              : AppColors.surface,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          breached && !c.isResolved
                              ? Icons.timer_off_rounded
                              : Icons.timer_rounded,
                          size: 13,
                          color: breached && !c.isResolved
                              ? AppColors.error
                              : warningSoon && !c.isResolved
                                  ? AppColors.warning
                                  : AppColors.textMuted,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          c.isResolved
                              ? 'Resolved'
                              : _formatDuration(remaining),
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: c.isResolved
                                ? AppColors.success
                                : breached
                                    ? AppColors.error
                                    : warningSoon
                                        ? AppColors.warning
                                        : AppColors.textMuted,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),

                  // Resolve button
                  if (!c.isResolved)
                    GestureDetector(
                      onTap: onResolve,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: AppColors.success.withOpacity(0.12),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                              color: AppColors.success.withOpacity(0.3)),
                        ),
                        child: const Row(
                          children: [
                            Icon(Icons.check_rounded,
                                size: 13, color: AppColors.success),
                            SizedBox(width: 4),
                            Text(
                              'Resolve',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                                color: AppColors.success,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Add Case Bottom Sheet ─────────────────────────────────────
class _AddCaseSheet extends StatefulWidget {
  final Function(String title, String location, TriagePriority priority)
      onAdd;

  const _AddCaseSheet({required this.onAdd});

  @override
  State<_AddCaseSheet> createState() => _AddCaseSheetState();
}

class _AddCaseSheetState extends State<_AddCaseSheet> {
  final _titleCtrl = TextEditingController();
  final _locationCtrl = TextEditingController();
  TriagePriority _selectedPriority = TriagePriority.P2;

  @override
  void dispose() {
    _titleCtrl.dispose();
    _locationCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(
          24, 24, 24, MediaQuery.of(context).viewInsets.bottom + 24),
      decoration: const BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Handle
          Center(
            child: Container(
              width: 36,
              height: 4,
              decoration: BoxDecoration(
                color: AppColors.border,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: 20),

          const Text(
            'New Triage Case',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w800,
              color: AppColors.text,
            ),
          ),
          const SizedBox(height: 16),

          AppTextField(
            label: 'TITLE',
            hint: 'e.g. Medical Emergency',
            controller: _titleCtrl,
            prefixIcon: Icons.label_rounded,
          ),
          const SizedBox(height: 12),

          AppTextField(
            label: 'LOCATION',
            hint: 'e.g. Sylhet Zone 4',
            controller: _locationCtrl,
            prefixIcon: Icons.location_on_rounded,
          ),
          const SizedBox(height: 16),

          const Text(
            'PRIORITY',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: AppColors.textMuted,
              letterSpacing: 0.8,
            ),
          ),
          const SizedBox(height: 8),

          // Priority selector
          Row(
            children: TriagePriority.values.map((p) {
              final selected = _selectedPriority == p;
              return Expanded(
                child: GestureDetector(
                  onTap: () => setState(() => _selectedPriority = p),
                  child: Container(
                    margin: EdgeInsets.only(
                        right: p == TriagePriority.P3 ? 0 : 8),
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                      color: selected
                          ? p.color.withOpacity(0.2)
                          : AppColors.surface,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: selected
                            ? p.color.withOpacity(0.6)
                            : AppColors.border,
                        width: selected ? 1.5 : 1,
                      ),
                    ),
                    child: Text(
                      p.label,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w800,
                        color: selected ? p.textColor : AppColors.textMuted,
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 20),

          PrimaryButton(
            label: 'Add to Queue',
            icon: Icons.add_rounded,
            onTap: () {
              if (_titleCtrl.text.isEmpty || _locationCtrl.text.isEmpty) {
                return;
              }
              widget.onAdd(
                _titleCtrl.text.trim(),
                _locationCtrl.text.trim(),
                _selectedPriority,
              );
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}