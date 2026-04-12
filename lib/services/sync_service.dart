import 'package:flutter/services.dart';
import 'package:grpc/grpc.dart';
import '../generated/mesh.pb.dart';
import '../generated/mesh.pbgrpc.dart';
import '../generated/inventory.pb.dart';

class SyncService {
  static ClientChannel? _channel;
  static MeshSyncClient? _stub;

  static const _serverHost = '192.168.67.16';
  static const _serverPort = 50051;

  // ⚠️ IMPORTANT: This must match the CN in your ca.crt exactly.
  // Ask Person A what CN they used when generating certs.
  // Common values: 'node-sylhet-base', 'localhost', 'digitaldelta'
  static const _certAuthority = 'node-sylhet-base';

  static Future<MeshSyncClient> _getStub() async {
    if (_stub != null) return _stub!;

    try {
      final certBytes = await rootBundle.load('assets/certs/ca.crt');
      final creds = ChannelCredentials.secure(
        certificates: certBytes.buffer.asUint8List(),
        authority: _certAuthority,
      );
      _channel = ClientChannel(
        _serverHost,
        port: _serverPort,
        options: ChannelOptions(
          credentials: creds,
          connectionTimeout: const Duration(seconds: 5),
          keepAlive: const ClientKeepAliveOptions(
            pingInterval: Duration(seconds: 10),
            timeout: Duration(seconds: 5),
          ),
        ),
      );
    } catch (_) {
      // ca.crt not found — fall back to insecure for testing
      _channel = ClientChannel(
        _serverHost,
        port: _serverPort,
        options: const ChannelOptions(
          credentials: ChannelCredentials.insecure(),
        ),
      );
    }

    _stub = MeshSyncClient(_channel!);
    return _stub!;
  }

  static Future<SyncResult> sync() async {
    final stub = await _getStub();

    final request = SyncRequest(
      requesterId: 'node-flutter-bd04',
      have: VectorClock(clocks: {}),
      shards: ['sylhet-main'],
    );

    final response = await stub
        .sync(request,
            options: CallOptions(
              timeout: const Duration(seconds: 8),
            ))
        .catchError((e) => throw Exception('gRPC error: $e'));

    final itemCount = response.inventory.items.length;
    final podCount = response.pods.length;

    return SyncResult(
      success: true,
      mergedCount: itemCount + podCount,
      nodeId: _serverHost,
      items: response.inventory.items,
    );
  }

  static Future<bool> checkConnection() async {
    try {
      final result = await sync().timeout(const Duration(seconds: 8));
      return result.success;
    } catch (_) {
      return false;
    }
  }

  static void dispose() {
    _channel?.shutdown();
    _channel = null;
    _stub = null;
  }
}

class SyncResult {
  final bool success;
  final int mergedCount;
  final String nodeId;
  final List<SupplyItem> items;

  SyncResult({
    required this.success,
    required this.mergedCount,
    required this.nodeId,
    required this.items,
  });
}