import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/sync_state.dart';
import '../services/sync_service.dart';

class SyncNotifier extends StateNotifier<SyncState> {
  SyncNotifier() : super(const SyncState());

  Future<void> checkAndSync() async {
    // Check if server reachable
    final connected = await SyncService.checkConnection();
    state = state.copyWith(isConnected: connected);

    if (!connected) return;

    // Once proto generation is done, replace this with real Sync() call
    // For now simulate a successful sync
    await Future.delayed(const Duration(milliseconds: 600));
    state = state.copyWith(
      isConnected: true,
      lastSynced: DateTime.now(),
      inventoryVersion: state.inventoryVersion + 1,
      podCount: state.podCount + 1,
    );
  }
}

final syncProvider =
    StateNotifierProvider<SyncNotifier, SyncState>((ref) => SyncNotifier());