import 'package:flutter/services.dart';
import 'package:grpc/grpc.dart';

// If proto generation worked, use these:
// import '../generated/mesh.pb.dart';
// import '../generated/mesh.pbgrpc.dart';

class SyncService {
  static ClientChannel? _channel;
  static const _serverHost = '172.20.10.9'; // ← Person A's laptop IP
  static const _serverPort = 50051;

  static Future<ClientChannel> _getChannel() async {
    if (_channel != null) return _channel!;

    // Load ca.crt for TLS
    final certBytes =
        await rootBundle.load('assets/certs/ca.crt');
    final creds = ChannelCredentials.secure(
      certificates: certBytes.buffer.asUint8List(),
      authority: 'delta.local', // must match the CN in Person A's cert
    );

    _channel = ClientChannel(
      _serverHost,
      port: _serverPort,
      options: ChannelOptions(credentials: creds),
    );
    return _channel!;
  }

  /// Returns true if server is reachable
  static Future<bool> checkConnection() async {
    try {
      final channel = await _getChannel();
      final state = channel.getConnection();
      return true;
    } catch (_) {
      return false;
    }
  }

  static void dispose() {
    _channel?.shutdown();
    _channel = null;
  }
}