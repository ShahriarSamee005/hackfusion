import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hackfusion/screens/route_map_screen.dart';
import '../services/app_theme.dart';
import '../services/auth_service.dart';
import '../widgets/widgets.dart';
import '../providers/role_provider.dart';
import '../providers/sync_provider.dart';
import '../models/role.dart';
import 'login_screen.dart';
import 'qr_generator_screen.dart';
import 'qr_scanner_screen.dart';
import 'triage_screen.dart';
import '../providers/activity_provider.dart';
import 'ml_predict_screen.dart';

// ── Mock Data ─────────────────────────────────────────────────
class _Delivery {
  final String id;
  final String destination;
  final String status; // 'in_transit' | 'delivered'
  const _Delivery(this.id, this.destination, this.status);
}

class _TriageCase {
  final String title;
  final String priority; // 'P0' | 'P1' | 'P2'
  const _TriageCase(this.title, this.priority);
}

const _mockDeliveries = [
  _Delivery('A1F2', 'Sunamganj Sadar Camp', 'in_transit'),
  _Delivery('B3C7', 'Companyganj Outpost', 'delivered'),
  _Delivery('D9E1', 'Habiganj Medical', 'in_transit'),
];

const _mockTriage = [
  _TriageCase('Flood injury — west bank', 'P0'),
  _TriageCase('Supply shortage — N4', 'P1'),
  _TriageCase('Medical resupply needed', 'P1'),
];

// ── Dashboard ─────────────────────────────────────────────────
class DashboardScreen extends ConsumerWidget {
  final String name;
  final String email;

  const DashboardScreen({
    super.key,
    required this.name,
    required this.email,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final role = ref.watch(roleProvider);

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: AppBackground(
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _TopBar(name: name, role: role, email: email),
                const SizedBox(height: 20),
                _OfflineBanner(),
                const SizedBox(height: 12),
                _SyncStatusCard(),
                const SizedBox(height: 24),
                _StatsRow(),
                const SizedBox(height: 24),
                _SectionHeader('Quick Actions'),
                const SizedBox(height: 12),
                _ActionGrid(),
                const SizedBox(height: 24),
                _SectionHeader('Active Deliveries'),
                const SizedBox(height: 12),
                _ActiveDeliveries(),
                const SizedBox(height: 24),
                _SectionHeader('Pending Triage'),
                const SizedBox(height: 12),
                _PendingTriage(),
                const SizedBox(height: 24),
                _SectionHeader('Recent Activity'),
                const SizedBox(height: 12),
                _ActivityFeed(),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ── Section Header ────────────────────────────────────────────
class _SectionHeader extends StatelessWidget {
  final String title;
  const _SectionHeader(this.title);

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w800,
        color: AppColors.text,
      ),
    );
  }
}

// ── Top Bar ───────────────────────────────────────────────────
class _TopBar extends ConsumerWidget {
  final String name;
  final String email;
  final UserRole? role;

  const _TopBar({
    required this.name,
    required this.email,
    required this.role,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      children: [
        Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [AppColors.blue, AppColors.mint],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Center(
            child: Text(
              name.isNotEmpty ? name[0].toUpperCase() : '?',
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w800,
                fontSize: 18,
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name.isNotEmpty ? name : 'Field Agent',
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w800,
                  color: AppColors.text,
                ),
              ),
              if (role != null)
                Text(
                  role!.label,
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.textMuted,
                  ),
                ),
            ],
          ),
        ),
        IconButton(
          onPressed: () async {
            await AuthService.logout();
            if (context.mounted) {
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (_) => const LoginScreen()),
                (_) => false,
              );
            }
          },
          icon: const Icon(
            Icons.logout_rounded,
            color: AppColors.textMuted,
            size: 20,
          ),
        ),
      ],
    );
  }
}

// ── Offline Banner ────────────────────────────────────────────
class _OfflineBanner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.warning.withOpacity(0.15),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.warning.withOpacity(0.4)),
      ),
      child: Row(
        children: [
          const Icon(Icons.wifi_off_rounded, size: 16, color: AppColors.text),
          const SizedBox(width: 10),
          const Expanded(
            child: Text(
              'Offline mode — mesh sync active',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: AppColors.text,
              ),
            ),
          ),
          Container(
            width: 8,
            height: 8,
            decoration: const BoxDecoration(
              color: AppColors.success,
              shape: BoxShape.circle,
            ),
          ),
        ],
      ),
    );
  }
}

// ── Sync Status Card ──────────────────────────────────────────
class _SyncStatusCard extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sync = ref.watch(syncProvider);

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: sync.isConnected
              ? AppColors.success.withOpacity(0.4)
              : AppColors.border,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                width: 10,
                height: 10,
                decoration: BoxDecoration(
                  color: sync.isSyncing
                      ? AppColors.warning
                      : sync.isConnected
                          ? AppColors.success
                          : AppColors.error,
                  shape: BoxShape.circle,
                  boxShadow: sync.isConnected
                      ? [
                          BoxShadow(
                            color: AppColors.success.withOpacity(0.4),
                            blurRadius: 6,
                            spreadRadius: 1,
                          )
                        ]
                      : null,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      sync.isSyncing
                          ? 'Syncing mesh node...'
                          : sync.isConnected
                              ? 'Secure mesh link — ${sync.nodeId}'
                              : 'Mesh node offline',
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: AppColors.text,
                      ),
                    ),
                    if (sync.lastSynced != null)
                      Text(
                        'Last sync: ${_timeAgo(sync.lastSynced!)}',
                        style: const TextStyle(
                          fontSize: 11,
                          color: AppColors.textMuted,
                        ),
                      )
                    else
                      const Text(
                        'Not synced yet',
                        style: TextStyle(
                          fontSize: 11,
                          color: AppColors.textMuted,
                        ),
                      ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: sync.isSyncing
                    ? null
                    : () {
                        ref.read(syncProvider.notifier).checkAndSync();
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Row(
                              children: [
                                Icon(Icons.sync_rounded,
                                    color: Colors.white, size: 16),
                                SizedBox(width: 8),
                                Text('Synced with mesh node'),
                              ],
                            ),
                            duration: Duration(seconds: 2),
                          ),
                        );
                      },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: sync.isSyncing
                        ? AppColors.warning.withOpacity(0.12)
                        : AppColors.blue.withOpacity(0.12),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: sync.isSyncing
                      ? const SizedBox(
                          width: 14,
                          height: 14,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: AppColors.warning,
                          ),
                        )
                      : const Row(
                          children: [
                            Icon(Icons.sync_rounded,
                                size: 14, color: AppColors.blueDark),
                            SizedBox(width: 4),
                            Text(
                              'Sync',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                                color: AppColors.blueDark,
                              ),
                            ),
                          ],
                        ),
                ),
              ),
            ],
          ),
          if (sync.syncMessage != null) ...[
            const SizedBox(height: 10),
            Container(
              width: double.infinity,
              padding:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
              decoration: BoxDecoration(
                color: sync.isConnected
                    ? AppColors.success.withOpacity(0.08)
                    : AppColors.blue.withOpacity(0.07),
                borderRadius: BorderRadius.circular(7),
              ),
              child: Row(
                children: [
                  Icon(
                    sync.isConnected
                        ? Icons.verified_rounded
                        : Icons.info_outline_rounded,
                    size: 13,
                    color: sync.isConnected
                        ? AppColors.success
                        : AppColors.blueDark,
                  ),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      sync.syncMessage!,
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: sync.isConnected
                            ? AppColors.success
                            : AppColors.blueDark,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
          if (sync.isConnected) ...[
            const SizedBox(height: 10),
            Row(
              children: [
                _StatChip(
                    label: 'Updates',
                    value: '${sync.inventoryVersion}',
                    icon: Icons.sync_alt_rounded),
                const SizedBox(width: 8),
                _StatChip(
                    label: 'PODs',
                    value: '${sync.podCount}',
                    icon: Icons.verified_rounded),
                const SizedBox(width: 8),
                _StatChip(
                    label: 'mTLS',
                    value: 'AES-256',
                    icon: Icons.lock_rounded),
              ],
            ),
          ],
        ],
      ),
    );
  }

  String _timeAgo(DateTime t) {
    final diff = DateTime.now().difference(t);
    if (diff.inSeconds < 60) return '${diff.inSeconds}s ago';
    if (diff.inMinutes < 60) return '${diff.inMinutes}m ago';
    return '${diff.inHours}h ago';
  }
}

class _StatChip extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;

  const _StatChip({
    required this.label,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(7),
          border: Border.all(color: AppColors.border),
        ),
        child: Row(
          children: [
            Icon(icon, size: 12, color: AppColors.blueDark),
            const SizedBox(width: 4),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    value,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w800,
                      color: AppColors.text,
                    ),
                  ),
                  Text(
                    label,
                    style: const TextStyle(
                      fontSize: 9,
                      color: AppColors.textMuted,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Stats Row ─────────────────────────────────────────────────
class _StatsRow extends StatelessWidget {
  final _stats = const [
    ('Nodes', '6', Icons.device_hub_rounded),
    ('Pending', '2', Icons.pending_actions_rounded),
    ('Delivered', '1', Icons.check_circle_rounded),
  ];

  @override
  Widget build(BuildContext context) {
    return Row(
      children: _stats.map((s) {
        return Expanded(
          child: Container(
            margin: EdgeInsets.only(right: s == _stats.last ? 0 : 10),
            padding: const EdgeInsets.symmetric(vertical: 14),
            decoration: BoxDecoration(
              color: AppColors.card,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.border),
            ),
            child: Column(
              children: [
                Icon(s.$3, color: AppColors.blueDark, size: 20),
                const SizedBox(height: 6),
                Text(
                  s.$2,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    color: AppColors.text,
                  ),
                ),
                Text(
                  s.$1,
                  style: const TextStyle(
                    fontSize: 11,
                    color: AppColors.textMuted,
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}

// ── Action Grid ───────────────────────────────────────────────
class _ActionGrid extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final actions = [
      (
        'Generate QR',
        Icons.qr_code_rounded,
        AppColors.blue,
        () => Navigator.push(context,
            MaterialPageRoute(builder: (_) => const QRGeneratorScreen())),
      ),
      (
        'Scan Delivery',
        Icons.qr_code_scanner_rounded,
        AppColors.success,
        () => Navigator.push(context,
            MaterialPageRoute(builder: (_) => const QRScannerScreen())),
      ),
      (
        'Routes',
        Icons.alt_route_rounded,
        AppColors.blueDark,
        () => Navigator.push(context,
            MaterialPageRoute(builder: (_) => const RouteMapScreen())),
      ),
      (
        'Triage',
        Icons.warning_amber_rounded,
        AppColors.error,
        () => Navigator.push(context,
            MaterialPageRoute(builder: (_) => const TriageScreen())),
      ),
      (
        'Sync',
        Icons.sync_rounded,
        AppColors.mint,
        () {
          ref.read(syncProvider.notifier).checkAndSync();
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Row(
                children: [
                  Icon(Icons.sync_rounded, color: Colors.white, size: 16),
                  SizedBox(width: 8),
                  Text('Synced with mesh node'),
                ],
              ),
              duration: Duration(seconds: 2),
            ),
          );
        },
      ),
      (
        'ML Predict',
        Icons.psychology_rounded,
        AppColors.blueDark,
        () => Navigator.push(context,
            MaterialPageRoute(builder: (_) => const MLPredictScreen())),
      ),
    ];

    return GridView.count(
      crossAxisCount: 3,
      shrinkWrap: true,
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      childAspectRatio: 1.0,
      physics: const NeverScrollableScrollPhysics(),
      children: actions.map((a) {
        return InkWell(
          onTap: a.$4,
          borderRadius: BorderRadius.circular(14),
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.card,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: AppColors.border),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 42,
                  height: 42,
                  decoration: BoxDecoration(
                    color: a.$3.withOpacity(0.12),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(a.$2, color: a.$3, size: 22),
                ),
                const SizedBox(height: 8),
                Text(
                  a.$1,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    color: AppColors.text,
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}

// ── Active Deliveries ─────────────────────────────────────────
class _ActiveDeliveries extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        children: List.generate(_mockDeliveries.length, (i) {
          final d = _mockDeliveries[i];
          final isLast = i == _mockDeliveries.length - 1;
          final isDelivered = d.status == 'delivered';

          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 16, vertical: 12),
                child: Row(
                  children: [
                    // Status icon
                    Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        color: isDelivered
                            ? AppColors.success.withOpacity(0.12)
                            : AppColors.blue.withOpacity(0.12),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(
                        isDelivered
                            ? Icons.check_circle_rounded
                            : Icons.local_shipping_rounded,
                        size: 18,
                        color: isDelivered
                            ? AppColors.success
                            : AppColors.blue,
                      ),
                    ),
                    const SizedBox(width: 12),
                    // Info
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            d.destination,
                            style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w700,
                              color: AppColors.text,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            'ID: ${d.id}',
                            style: const TextStyle(
                              fontSize: 11,
                              color: AppColors.textMuted,
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Status badge
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: isDelivered
                            ? AppColors.success.withOpacity(0.12)
                            : AppColors.warning.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: isDelivered
                              ? AppColors.success.withOpacity(0.3)
                              : AppColors.warning.withOpacity(0.4),
                        ),
                      ),
                      child: Text(
                        isDelivered ? 'Delivered' : 'In Transit',
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                          color: isDelivered
                              ? AppColors.success
                              : AppColors.text,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              if (!isLast)
                Divider(
                  height: 1,
                  color: AppColors.border.withOpacity(0.5),
                  indent: 16,
                  endIndent: 16,
                ),
            ],
          );
        }),
      ),
    );
  }
}

// ── Pending Triage ────────────────────────────────────────────
class _PendingTriage extends StatelessWidget {
  Color _priorityColor(String p) {
    switch (p) {
      case 'P0':
        return AppColors.error;
      case 'P1':
        return AppColors.warning;
      default:
        return AppColors.textMuted;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: AppColors.error.withOpacity(0.25),
        ),
      ),
      child: Column(
        children: [
          // Header count
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              children: [
                const Icon(Icons.warning_amber_rounded,
                    size: 18, color: AppColors.error),
                const SizedBox(width: 10),
                const Expanded(
                  child: Text(
                    '3 Active Cases',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w800,
                      color: AppColors.text,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColors.error.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text(
                    'Unresolved',
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                      color: AppColors.error,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Divider(
              height: 1,
              color: AppColors.border.withOpacity(0.5),
              indent: 16,
              endIndent: 16),
          // Case list
          ...List.generate(_mockTriage.length, (i) {
            final t = _mockTriage[i];
            final isLast = i == _mockTriage.length - 1;
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16, vertical: 10),
                  child: Row(
                    children: [
                      Container(
                        width: 28,
                        height: 28,
                        decoration: BoxDecoration(
                          color: _priorityColor(t.priority).withOpacity(0.12),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Center(
                          child: Text(
                            t.priority,
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w800,
                              color: _priorityColor(t.priority),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          t.title,
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: AppColors.text,
                          ),
                        ),
                      ),
                      const Icon(Icons.chevron_right_rounded,
                          size: 16, color: AppColors.textMuted),
                    ],
                  ),
                ),
                if (!isLast)
                  Divider(
                    height: 1,
                    color: AppColors.border.withOpacity(0.5),
                    indent: 16,
                    endIndent: 16,
                  ),
              ],
            );
          }),
        ],
      ),
    );
  }
}

// ── Activity Feed ─────────────────────────────────────────────
class _ActivityFeed extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final items = ref.watch(activityProvider);

    if (items.isEmpty) {
      return Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: AppColors.card,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: AppColors.border),
        ),
        child: const Center(
          child: Text(
            'No activity yet',
            style: TextStyle(
              fontSize: 13,
              color: AppColors.textMuted,
            ),
          ),
        ),
      );
    }

    return Container(
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        children: List.generate(items.length, (i) {
          final item = items[i];
          final isLast = i == items.length - 1;
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 16, vertical: 12),
                child: Row(
                  children: [
                    Icon(item.icon, color: item.color, size: 18),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        item.message,
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: AppColors.text,
                        ),
                      ),
                    ),
                    Text(
                      _timeAgo(item.time),
                      style: const TextStyle(
                        fontSize: 11,
                        color: AppColors.textMuted,
                      ),
                    ),
                  ],
                ),
              ),
              if (!isLast)
                Divider(
                  height: 1,
                  color: AppColors.border.withOpacity(0.5),
                  indent: 16,
                  endIndent: 16,
                ),
            ],
          );
        }),
      ),
    );
  }

  String _timeAgo(DateTime t) {
    final diff = DateTime.now().difference(t);
    if (diff.inSeconds < 60) return '${diff.inSeconds}s ago';
    if (diff.inMinutes < 60) return '${diff.inMinutes}m ago';
    return '${diff.inHours}h ago';
  }
}
