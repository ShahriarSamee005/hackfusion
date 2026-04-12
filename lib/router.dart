import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'providers/role_provider.dart';
import 'screens/role_selection_screen.dart';
import 'screens/dashboard_screen.dart';
import 'screens/qr_generator_screen.dart';
import 'screens/qr_scanner_screen.dart';

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/role',
    routes: [
      // GoRoute(
      //   path: '/role',
      //   builder: (context, state) => const RoleSelectionScreen(),
      // ),
      // GoRoute(
      //   path: '/dashboard',
      //   builder: (context, state) => const DashboardScreen(),
      // ),
      GoRoute(
        path: '/qr-generate',
        builder: (context, state) => const QRGeneratorScreen(),
      ),
      GoRoute(
        path: '/qr-scan',
        builder: (context, state) => const QRScannerScreen(),
      ),
    ],
  );
});