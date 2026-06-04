class LotModel {
  final String id;
  final String societyId;
  final String dealerId;
  final String name;
  final String block;
  final String status;
  final DateTime? expiresAt;

  const LotModel({
    required this.id,
    required this.societyId,
    required this.dealerId,
    required this.name,
    required this.block,
    required this.status,
    this.expiresAt,
  });

  factory LotModel.fromJson(Map<String, dynamic> json) => LotModel(
        id: json['id'] as String,
        societyId: json['society_id'] as String,
        dealerId: json['dealer_id'] as String,
        name: json['name'] as String,
        block: json['block'] as String,
        status: json['status'] as String? ?? 'active',
        expiresAt: json['expires_at'] != null
            ? DateTime.parse(json['expires_at'] as String)
            : null,
      );
}
