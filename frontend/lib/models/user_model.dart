enum UserRole { admin, society, dealer, customer }

enum ApprovalStatus { pending, approved, rejected }

class UserModel {
  final String id;
  final String email;
  final String fullName;
  final String? phone;
  final UserRole role;
  final ApprovalStatus approvalStatus;
  final String? cnic;
  final String? cnicDocumentUrl;
  final String? agentLicenseNumber;
  final String? societyName;
  final String? nocDocumentUrl;
  final String? secpDocumentUrl;
  final bool emailVerified;
  final bool phoneVerified;

  const UserModel({
    required this.id,
    required this.email,
    required this.fullName,
    this.phone,
    required this.role,
    required this.approvalStatus,
    this.cnic,
    this.cnicDocumentUrl,
    this.agentLicenseNumber,
    this.societyName,
    this.nocDocumentUrl,
    this.secpDocumentUrl,
    this.emailVerified = false,
    this.phoneVerified = false,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String,
      email: json['email'] as String,
      fullName: json['full_name'] as String? ?? '',
      phone: json['phone'] as String?,
      role: UserRole.values.byName(json['role'] as String? ?? 'customer'),
      approvalStatus: ApprovalStatus.values
          .byName(json['approval_status'] as String? ?? 'pending'),
      cnic: json['cnic'] as String?,
      cnicDocumentUrl: json['cnic_document_url'] as String?,
      agentLicenseNumber: json['agent_license_number'] as String?,
      societyName: json['society_name'] as String?,
      nocDocumentUrl: json['noc_document_url'] as String?,
      secpDocumentUrl: json['secp_document_url'] as String?,
      emailVerified: json['email_verified'] as bool? ?? false,
      phoneVerified: json['phone_verified'] as bool? ?? false,
    );
  }

  bool get isApproved => approvalStatus == ApprovalStatus.approved;
}
