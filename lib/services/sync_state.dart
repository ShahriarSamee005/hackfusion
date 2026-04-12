class SyncState {
  final bool isConnected;
  final bool isSyncing;       // NEW — shows spinner while syncing
  final String? syncMessage;  // NEW — shows "Synced 3 updates" etc
  final DateTime? lastSynced;
  final int inventoryVersion;
  final int podCount;
  final String nodeId;

  const SyncState({
    this.isConnected = false,
    this.isSyncing = false,
    this.syncMessage,
    this.lastSynced,
    this.inventoryVersion = 0,
    this.podCount = 0,
    this.nodeId = 'node-local',
  });

  SyncState copyWith({
    bool? isConnected,
    bool? isSyncing,
    String? syncMessage,
    DateTime? lastSynced,
    int? inventoryVersion,
    int? podCount,
    String? nodeId,
  }) {
    return SyncState(
      isConnected: isConnected ?? this.isConnected,
      isSyncing: isSyncing ?? this.isSyncing,
      syncMessage: syncMessage ?? this.syncMessage,
      lastSynced: lastSynced ?? this.lastSynced,
      inventoryVersion: inventoryVersion ?? this.inventoryVersion,
      podCount: podCount ?? this.podCount,
      nodeId: nodeId ?? this.nodeId,
    );
  }
}