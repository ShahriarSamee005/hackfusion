import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:uuid/uuid.dart';
import '../models/delivery.dart';

class QRGeneratorScreen extends StatefulWidget {
  const QRGeneratorScreen({super.key});

  @override
  State<QRGeneratorScreen> createState() => _QRGeneratorScreenState();
}

class _QRGeneratorScreenState extends State<QRGeneratorScreen> {
  final _cargoController = TextEditingController();
  final _destController   = TextEditingController();
  DeliveryRequest? _request;

  void _generate() {
    if (_cargoController.text.isEmpty || _destController.text.isEmpty) return;
    setState(() {
      _request = DeliveryRequest(
        id:            const Uuid().v4().substring(0, 8).toUpperCase(),
        cargoType:     _cargoController.text.trim(),
        destinationId: _destController.text.trim(),
        issuedBy:      'NODE-LOCAL',
        issuedAt:      DateTime.now(),
        nonce:         const Uuid().v4(),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Generate Delivery QR')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _cargoController,
              decoration: const InputDecoration(
                labelText: 'Cargo type',
                hintText: 'e.g. Water, Medicine, Food',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _destController,
              decoration: const InputDecoration(
                labelText: 'Destination ID',
                hintText: 'e.g. ZONE-04',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: _generate,
                child: const Text('Generate QR Code'),
              ),
            ),
            if (_request != null) ...[
              const SizedBox(height: 32),
              Center(
                child: QrImageView(
                  data: _request!.toQRString(),
                  version: QrVersions.auto,
                  size: 240,
                  backgroundColor: Colors.white,
                ),
              ),
              const SizedBox(height: 20),
              // Delivery details card
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey.shade50,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade200),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _DetailRow('Delivery ID', _request!.id),
                    _DetailRow('Cargo',       _request!.cargoType),
                    _DetailRow('Destination', _request!.destinationId),
                    _DetailRow('Issued at',
                        _request!.issuedAt.toLocal().toString().substring(0, 16)),
                    _DetailRow('Nonce',
                        _request!.nonce.substring(0, 8) + '...'),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  final String label, value;
  const _DetailRow(this.label, this.value);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          SizedBox(
            width: 100,
            child: Text(label,
                style: TextStyle(
                    fontSize: 13, color: Colors.grey.shade600)),
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
