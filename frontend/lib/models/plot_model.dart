enum PlotStatus { available, assigned, reserved, sold, disputed }

class PlotModel {
  final String id;
  final String societyId;
  final String plotNumber;
  final String block;
  final double sizeValue;
  final String sizeUnit;
  final String category;
  final double pricePkr;
  final PlotStatus status;
  final String? svgZoneId;

  const PlotModel({
    required this.id,
    required this.societyId,
    required this.plotNumber,
    required this.block,
    required this.sizeValue,
    required this.sizeUnit,
    required this.category,
    required this.pricePkr,
    required this.status,
    this.svgZoneId,
  });

  factory PlotModel.fromJson(Map<String, dynamic> json) => PlotModel(
        id: json['id'] as String,
        societyId: json['society_id'] as String,
        plotNumber: json['plot_number'] as String,
        block: json['block'] as String,
        sizeValue: (json['size_value'] as num).toDouble(),
        sizeUnit: json['size_unit'] as String? ?? 'marla',
        category: json['category'] as String? ?? 'residential',
        pricePkr: (json['price_pkr'] as num).toDouble(),
        status: PlotStatus.values.byName(json['status'] as String? ?? 'available'),
        svgZoneId: json['svg_zone_id'] as String?,
      );
}
