import 'package:intl/intl.dart';

class Formatters {
  static final _pkr = NumberFormat.currency(locale: 'en_PK', symbol: 'PKR ', decimalDigits: 0);

  static String pkr(num amount) => _pkr.format(amount);

  static String plotSize(double value, String unit) {
    final label = unit == 'kanal' ? 'Kanal' : 'Marla';
    return '$value $label';
  }

  static String date(DateTime dt) => DateFormat('dd MMM yyyy').format(dt);
}
