enum DealStage {
  inquiry,
  siteVisit,
  tokenReceived,
  agreementSigned,
  paymentActive,
  transferSubmitted,
}

class BookingModel {
  final String id;
  final String referenceNumber;
  final String plotId;
  final String customerId;
  final String? dealerId;
  final String societyId;
  final String currentStage;
  final String status;
  final double? tokenAmountPkr;

  const BookingModel({
    required this.id,
    required this.referenceNumber,
    required this.plotId,
    required this.customerId,
    this.dealerId,
    required this.societyId,
    required this.currentStage,
    required this.status,
    this.tokenAmountPkr,
  });

  factory BookingModel.fromJson(Map<String, dynamic> json) => BookingModel(
        id: json['id'] as String,
        referenceNumber: json['reference_number'] as String,
        plotId: json['plot_id'] as String,
        customerId: json['customer_id'] as String,
        dealerId: json['dealer_id'] as String?,
        societyId: json['society_id'] as String,
        currentStage: json['current_stage'] as String? ?? 'inquiry',
        status: json['status'] as String? ?? 'pending',
        tokenAmountPkr: (json['token_amount_pkr'] as num?)?.toDouble(),
      );
}
