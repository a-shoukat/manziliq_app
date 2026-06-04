class SocietyModel {
  final String id;
  final String ownerId;
  final String name;
  final String city;
  final String? area;
  final double? latitude;
  final double? longitude;
  final String? svgMapUrl;

  const SocietyModel({
    required this.id,
    required this.ownerId,
    required this.name,
    required this.city,
    this.area,
    this.latitude,
    this.longitude,
    this.svgMapUrl,
  });

  factory SocietyModel.fromJson(Map<String, dynamic> json) => SocietyModel(
        id: json['id'] as String,
        ownerId: json['owner_id'] as String,
        name: json['name'] as String,
        city: json['city'] as String,
        area: json['area'] as String?,
        latitude: (json['latitude'] as num?)?.toDouble(),
        longitude: (json['longitude'] as num?)?.toDouble(),
        svgMapUrl: json['svg_map_url'] as String?,
      );
}
