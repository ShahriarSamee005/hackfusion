import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import '../models/delivery.dart';
import '../providers/triage_provider.dart';
import '../providers/sync_provider.dart';
import '../services/app_theme.dart';
import '../widgets/widgets.dart';
import '../providers/activity_provider.dart';

class QRScannerScreen extends ConsumerStatefulWidget {
  const QRScannerScreen({super.key});

  @override
  ConsumerState<QRScannerScreen> createState() => _QRScannerScreenState();
}

class _QRScannerScreenState extends ConsumerState<QRScannerScreen> {
  DeliveryReceipt? _receipt;
  bool _scanned = false;
  bool _resolvedTriage = false;

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

    // Replay attack check
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

    // Check if delivery ID matches a triage case — auto-resolve it
    final cases = ref.read(triageProvider);
    final matchingCase = cases.where(
      (c) => c.id == request.id && !c.isResolved,
    ).firstOrNull;

if (matchingCase != null) {
  ref.read(triageProvider.notifier).resolveCase(matchingCase.id);
  ref.read(activityProvider.notifier).addTriageResolved(matchingCase.id);
  setState(() => _resolvedTriage = true);
}

    // Push delivery confirmed to activity feed
    ref.read(activityProvider.notifier).addDeliveryConfirmed(
      request.id.substring(0, 6),
    );

    // Auto-trigger sync
    ref.read(syncProvider.notifier).checkAndSync();
    ref.read(activityProvider.notifier).addSynced();

    setState(() {
      _scanned = true;
      _receipt = DeliveryReceipt(
        deliveryId: request.id,
        receivedBy: 'NODE-LOCAL',
        receivedAt: DateTime.now(),
        nonce: request.nonce,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: AppBackground(
        child: SafeArea(
          child: Column(
            children: [
              // ── Top bar ───────────────────────────────
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 12, 16, 0),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.arrow_back_rounded,
                          color: AppColors.text, size: 22),
                    ),
                    const Text(
                      'Scan Delivery QR',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w800,
                        color: AppColors.text,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: _scanned ? _buildReceipt() : _buildScanner(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildScanner() {
    return Column(
      children: [
        const SizedBox(height: 20),
        // Scanner frame
        Expanded(
          flex: 3,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: MobileScanner(onDetect: _onDetect),
            ),
          ),
        ),
        Expanded(
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.qr_code_scanner_rounded,
                    color: AppColors.textDim, size: 28),
                const SizedBox(height: 8),
                const Text(
                  'Point camera at delivery QR code',
                  style: TextStyle(
                    color: AppColors.textMuted,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildReceipt() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 8),

          // ── Success banner ────────────────────────────
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.success.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
              border:
                  Border.all(color: AppColors.success.withOpacity(0.4)),
            ),
            child: Row(
              children: [
                const Icon(Icons.check_circle_rounded,
                    color: AppColors.success, size: 22),
                const SizedBox(width: 12),
                const Expanded(
                  child: Text(
                    'Delivery confirmed',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                      color: AppColors.success,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // ── Triage resolved banner ────────────────────
          if (_resolvedTriage) ...[
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: AppColors.blue.withOpacity(0.08),
                borderRadius: BorderRadius.circular(12),
                border:
                    Border.all(color: AppColors.blue.withOpacity(0.3)),
              ),
              child: Row(
                children: [
                  const Icon(Icons.medical_services_rounded,
                      color: AppColors.blueDark, size: 18),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      'Triage case ${_receipt!.deliveryId} auto-resolved',
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: AppColors.blueDark,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],

          // ── Sync banner ───────────────────────────────
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.symmetric(
                horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              color: AppColors.mint.withOpacity(0.15),
              borderRadius: BorderRadius.circular(10),
              border:
                  Border.all(color: AppColors.mint.withOpacity(0.4)),
            ),
            child: const Row(
              children: [
                Icon(Icons.sync_rounded,
                    color: AppColors.success, size: 16),
                SizedBox(width: 8),
                Text(
                  'Sync pushed to mesh',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: AppColors.success,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // ── Receipt details ───────────────────────────
          const Text(
            'Receipt Details',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w800,
              color: AppColors.text,
            ),
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.card,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.border),
            ),
            child: Column(
              children: [
                _ReceiptRow('Delivery ID', _receipt!.deliveryId),
                _ReceiptRow('Received by', _receipt!.receivedBy),
                _ReceiptRow(
                  'Received at',
                  _receipt!.receivedAt
                      .toLocal()
                      .toString()
                      .substring(0, 16),
                ),
                _ReceiptRow(
                  'Nonce (echoed)',
                  '${_receipt!.nonce.substring(0, 8)}...',
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // ── Scan another ──────────────────────────────
          PrimaryButton(
            label: 'Scan Another',
            icon: Icons.qr_code_scanner_rounded,
            onTap: () => setState(() {
              _scanned = false;
              _receipt = null;
              _resolvedTriage = false;
            }),
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
            child: Text(
              label,
              style: const TextStyle(
                  fontSize: 13, color: AppColors.textMuted),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: AppColors.text,
              ),
            ),
          ),
        ],
      ),
    );
  }
}