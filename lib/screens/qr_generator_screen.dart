import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:uuid/uuid.dart';
import '../models/delivery.dart';
import '../services/app_theme.dart';
import '../widgets/widgets.dart';

class QRGeneratorScreen extends StatefulWidget {
  // Optional — when opened from triage, these are pre-filled
  final String? prefillCargo;
  final String? prefillDestination;
  final String? triageCaseId;

  const QRGeneratorScreen({
    super.key,
    this.prefillCargo,
    this.prefillDestination,
    this.triageCaseId,
  });

  @override
  State<QRGeneratorScreen> createState() => _QRGeneratorScreenState();
}

class _QRGeneratorScreenState extends State<QRGeneratorScreen> {
  late final TextEditingController _cargoController;
  late final TextEditingController _destController;
  DeliveryRequest? _request;

  bool get _isFromTriage => widget.triageCaseId != null;

  @override
  void initState() {
    super.initState();
    _cargoController =
        TextEditingController(text: widget.prefillCargo ?? '');
    _destController =
        TextEditingController(text: widget.prefillDestination ?? '');

    // Auto-generate if pre-filled from triage
    if (_isFromTriage) {
      WidgetsBinding.instance.addPostFrameCallback((_) => _generate());
    }
  }

  @override
  void dispose() {
    _cargoController.dispose();
    _destController.dispose();
    super.dispose();
  }

  void _generate() {
    if (_cargoController.text.isEmpty || _destController.text.isEmpty) {
      return;
    }
    setState(() {
      _request = DeliveryRequest(
        id: widget.triageCaseId ??
            const Uuid().v4().substring(0, 8).toUpperCase(),
        cargoType: _cargoController.text.trim(),
        destinationId: _destController.text.trim(),
        issuedBy: 'NODE-LOCAL',
        issuedAt: DateTime.now(),
        nonce: const Uuid().v4(),
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
                      'Generate Delivery QR',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w800,
                        color: AppColors.text,
                      ),
                    ),
                  ],
                ),
              ),

              // ── Triage badge ──────────────────────────
              if (_isFromTriage)
                Container(
                  margin: const EdgeInsets.fromLTRB(16, 12, 16, 0),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 14, vertical: 10),
                  decoration: BoxDecoration(
                    color: AppColors.error.withOpacity(0.08),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                        color: AppColors.error.withOpacity(0.3)),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.warning_rounded,
                          color: AppColors.error, size: 16),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          'Dispatching for triage case ${widget.triageCaseId}',
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: AppColors.error,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

              // ── Form ─────────────────────────────────
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 8),
                      AppTextField(
                        label: 'CARGO TYPE',
                        hint: 'e.g. Water, Medicine, Food',
                        controller: _cargoController,
                        prefixIcon: Icons.inventory_2_rounded,
                      ),
                      const SizedBox(height: 16),
                      AppTextField(
                        label: 'DESTINATION',
                        hint: 'e.g. ZONE-04',
                        controller: _destController,
                        prefixIcon: Icons.location_on_rounded,
                      ),
                      const SizedBox(height: 20),

                      // Lock fields if from triage
                      if (!_isFromTriage)
                        PrimaryButton(
                          label: 'Generate QR Code',
                          icon: Icons.qr_code_rounded,
                          onTap: _generate,
                        ),

                      if (_request != null) ...[
                        const SizedBox(height: 32),
                        Center(
                          child: Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: AppColors.card,
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(color: AppColors.border),
                            ),
                            child: QrImageView(
                              data: _request!.toQRString(),
                              version: QrVersions.auto,
                              size: 200,
                              backgroundColor: Colors.white,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),

                        // Details card
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: AppColors.card,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: AppColors.border),
                          ),
                          child: Column(
                            children: [
                              _DetailRow('Delivery ID', _request!.id),
                              _DetailRow('Cargo', _request!.cargoType),
                              _DetailRow(
                                  'Destination', _request!.destinationId),
                              _DetailRow(
                                'Issued at',
                                _request!.issuedAt
                                    .toLocal()
                                    .toString()
                                    .substring(0, 16),
                              ),
                              _DetailRow(
                                'Nonce',
                                '${_request!.nonce.substring(0, 8)}...',
                              ),
                            ],
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ],
          ),
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
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          SizedBox(
            width: 100,
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
                  fontSize: 13, fontWeight: FontWeight.w600,
                  color: AppColors.text),
            ),
          ),
        ],
      ),
    );
  }
}