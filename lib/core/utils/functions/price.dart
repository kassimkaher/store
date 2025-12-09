import 'package:intl/intl.dart';

String formatPrice(double price) {
  final formatter = NumberFormat('#,###');
  return formatter.format(price.round());
}
