class PaymentModel {
  final String id;
  final String bookingId;
  final double amountPkr;
  final String method;
  final String status;
  final DateTime? dueDate;
  final String? receiptUrl;

  const PaymentModel({
    required this.id,
    required this.bookingId,
    required this.amountPkr,
    required this.method,
    required this.status,
    this.dueDate,
    this.receiptUrl,
  });

  factory PaymentModel.fromJson(Map<String, dynamic> json) => PaymentModel(
        id: json['id'] as String,
        bookingId: json['booking_id'] as String,
        amountPkr: (json['amount_pkr'] as num).toDouble(),
        method: json['method'] as String,
        status: json['status'] as String? ?? 'pending',
        dueDate: json['due_date'] != null
            ? DateTime.parse(json['due_date'] as String)
            : null,
        receiptUrl: json['receipt_url'] as String?,
      );
}
