class DocumentModel {
  final String id;
  final String ownerId;
  final String docType;
  final String title;
  final String fileUrl;
  final int version;
  final DateTime createdAt;

  const DocumentModel({
    required this.id,
    required this.ownerId,
    required this.docType,
    required this.title,
    required this.fileUrl,
    required this.version,
    required this.createdAt,
  });

  factory DocumentModel.fromJson(Map<String, dynamic> json) => DocumentModel(
        id: json['id'] as String,
        ownerId: json['owner_id'] as String,
        docType: json['doc_type'] as String,
        title: json['title'] as String,
        fileUrl: json['file_url'] as String,
        version: json['version'] as int? ?? 1,
        createdAt: DateTime.parse(json['created_at'] as String),
      );
}
