class DeliveryRequest {
  final String id;
  final String cargoType;
  final String destinationId;
  final String issuedBy;
  final DateTime issuedAt;
  final String nonce;

  DeliveryRequest({
    required this.id,
    required this.cargoType,
    required this.destinationId,
    required this.issuedBy,
    required this.issuedAt,
    required this.nonce,
  });

  // Encode to QR string
  String toQRString() =>
      '$id|$cargoType|$destinationId|$issuedBy'
      '|${issuedAt.millisecondsSinceEpoch}|$nonce';

  // Decode from QR string
  static DeliveryRequest? fromQRString(String raw) {
    try {
      final parts = raw.split('|');
      if (parts.length != 6) return null;
      return DeliveryRequest(
        id:            parts[0],
        cargoType:     parts[1],
        destinationId: parts[2],
        issuedBy:      parts[3],
        issuedAt:      DateTime.fromMillisecondsSinceEpoch(int.parse(parts[4])),
        nonce:         parts[5],
      );
    } catch (_) {
      return null;
    }
  }
}

class DeliveryReceipt {
  final String deliveryId;
  final String receivedBy;
  final DateTime receivedAt;
  final String nonce; // echoed from challenge

  DeliveryReceipt({
    required this.deliveryId,
    required this.receivedBy,
    required this.receivedAt,
    required this.nonce,
  });

  @override
  String toString() =>
      'Receipt: $deliveryId | by: $receivedBy | at: $receivedAt';
}