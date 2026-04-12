class SyncState {
  final bool isConnected;
  final DateTime? lastSynced;
  final int inventoryVersion;
  final int podCount;
  final String nodeId;

  const SyncState({
    this.isConnected = false,
    this.lastSynced,
    this.inventoryVersion = 0,
    this.podCount = 0,
    this.nodeId = 'node-local',
  });

  SyncState copyWith({
    bool? isConnected,
    DateTime? lastSynced,
    int? inventoryVersion,
    int? podCount,
    String? nodeId,
  }) {
    return SyncState(
      isConnected: isConnected ?? this.isConnected,
      lastSynced: lastSynced ?? this.lastSynced,
      inventoryVersion: inventoryVersion ?? this.inventoryVersion,
      podCount: podCount ?? this.podCount,
      nodeId: nodeId ?? this.nodeId,
    );
  }
}