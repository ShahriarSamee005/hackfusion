import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import '../models/delivery.dart';

class QRScannerScreen extends StatefulWidget {
  const QRScannerScreen({super.key});

  @override
  State<QRScannerScreen> createState() => _QRScannerScreenState();
}

class _QRScannerScreenState extends State<QRScannerScreen> {
  DeliveryReceipt? _receipt;
  bool _scanned = false;

  void _onDetect(BarcodeCapture capture) {
    if (_scanned) return;
    final raw = capture.barcodes.firstOrNull?.rawValue;
    if (raw == null) return;

    final request = DeliveryRequest.fromQRString(raw);
    if (request == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Invalid QR code')),
      );
      return;
    }

    // Replay attack check — reject if older than 10 minutes
    final age = DateTime.now().difference(request.issuedAt);
    if (age.inMinutes > 10) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('QR expired — replay attack prevented'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() {
      _scanned = true;
      _receipt = DeliveryReceipt(
        deliveryId: request.id,
        receivedBy: 'NODE-LOCAL',
        receivedAt: DateTime.now(),
        nonce:      request.nonce, // echo back — proves freshness
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Scan Delivery QR')),
      body: _scanned ? _buildReceipt() : _buildScanner(),
    );
  }

  Widget _buildScanner() {
    return Column(
      children: [
        Expanded(
          flex: 3,
          child: MobileScanner(onDetect: _onDetect),
        ),
        Expanded(
          child: Center(
            child: Text(
              'Point camera at delivery QR code',
              style: TextStyle(color: Colors.grey.shade600),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildReceipt() {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Success header
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.green.shade50,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.green.shade200),
            ),
            child: Row(
              children: [
                Icon(Icons.check_circle, color: Colors.green.shade700),
                const SizedBox(width: 12),
                Text('Delivery confirmed',
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.green.shade700)),
              ],
            ),
          ),
          const SizedBox(height: 24),
          Text('Receipt Details',
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          _ReceiptRow('Delivery ID', _receipt!.deliveryId),
          _ReceiptRow('Received by', _receipt!.receivedBy),
          _ReceiptRow('Received at',
              _receipt!.receivedAt.toLocal().toString().substring(0, 16)),
          _ReceiptRow('Nonce (echoed)',
              _receipt!.nonce.substring(0, 8) + '...'),
          const SizedBox(height: 32),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: () => setState(() {
                _scanned = false;
                _receipt = null;
              }),
              child: const Text('Scan another'),
            ),
          ),
        ],
      ),
    );
  }
}

class _ReceiptRow extends StatelessWidget {
  final String label, value;
  const _ReceiptRow(this.label, this.value);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          SizedBox(
            width: 110,
            child: Text(label,
                style: TextStyle(fontSize: 13, color: Colors.grey.shade600)),
          ),
          Expanded(
            child: Text(value,
                style: const TextStyle(
                    fontSize: 13, fontWeight: FontWeight.w500)),
          ),
        ],
      ),
    );
  }
}
