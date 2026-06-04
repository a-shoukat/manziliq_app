class DealerModel {
  final String id;
  final String fullName;
  final String? cnic;
  final String? agentLicenseNumber;
  final double commissionPercent;

  const DealerModel({
    required this.id,
    required this.fullName,
    this.cnic,
    this.agentLicenseNumber,
    this.commissionPercent = 2.0,
  });

  factory DealerModel.fromJson(Map<String, dynamic> json) => DealerModel(
        id: json['id'] as String,
        fullName: json['full_name'] as String? ?? '',
        cnic: json['cnic'] as String?,
        agentLicenseNumber: json['agent_license_number'] as String?,
        commissionPercent: (json['commission_percent'] as num?)?.toDouble() ?? 2.0,
      );
}
