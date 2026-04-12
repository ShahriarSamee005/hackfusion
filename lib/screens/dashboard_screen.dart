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
                const Text(
                  'Quick Actions',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w800,
                    color: AppColors.text,
                  ),
                ),
                const SizedBox(height: 12),
                _ActionGrid(),
                const SizedBox(height: 24),
                const Text(
                  'Recent Activity',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w800,
                    color: AppColors.text,
                  ),
                ),
                const SizedBox(height: 12),
                _ActivityFeed(),
              ],
            ),
          ),
        ),
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
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            width: 10,
            height: 10,
            decoration: BoxDecoration(
              color: sync.isConnected ? AppColors.success : AppColors.error,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  sync.isConnected
                      ? 'Mesh node connected'
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
            onTap: () => ref.read(syncProvider.notifier).checkAndSync(),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: AppColors.blue.withOpacity(0.12),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Row(
                children: [
                  Icon(Icons.sync_rounded, size: 14, color: AppColors.blueDark),
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
    );
  }

  String _timeAgo(DateTime t) {
    final diff = DateTime.now().difference(t);
    if (diff.inSeconds < 60) return '${diff.inSeconds}s ago';
    if (diff.inMinutes < 60) return '${diff.inMinutes}m ago';
    return '${diff.inHours}h ago';
  }
}

// ── Stats Row ─────────────────────────────────────────────────
class _StatsRow extends StatelessWidget {
  final _stats = const [
    ('Nodes', '4', Icons.device_hub_rounded),
    ('Pending', '12', Icons.pending_actions_rounded),
    ('Delivered', '7', Icons.check_circle_rounded),
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
        () => ref.read(syncProvider.notifier).checkAndSync(),
      ),
      (
        'Fleet',
        Icons.local_shipping_rounded,
        AppColors.textMuted,
        () {},
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

// ── Activity Feed ─────────────────────────────────────────────
class _ActivityFeed extends StatelessWidget {
  final _items = const [
    (
      'Delivery #A1F2 confirmed',
      '2 min ago',
      Icons.check_circle_rounded,
      AppColors.success,
    ),
    (
      'Node BD-04 joined mesh',
      '5 min ago',
      Icons.device_hub_rounded,
      AppColors.blue,
    ),
    (
      'Route recalculated — flood',
      '11 min ago',
      Icons.alt_route_rounded,
      AppColors.warning,
    ),
    (
      'P0 triage alert raised',
      '18 min ago',
      Icons.warning_amber_rounded,
      AppColors.error,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        children: List.generate(_items.length, (i) {
          final item = _items[i];
          final isLast = i == _items.length - 1;
          return Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Row(
                  children: [
                    Icon(item.$3, color: item.$4, size: 18),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        item.$1,
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: AppColors.text,
                        ),
                      ),
                    ),
                    Text(
                      item.$2,
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
        }).toList(),
      ),
    );
  }
}