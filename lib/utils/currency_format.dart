import 'package:intl/intl.dart';

String FormattedNominal(int nominal) {
  return NumberFormat.currency(
    symbol: 'Rp ',
    decimalDigits: 0, // 0 digit desimal untuk format Rupiah
    locale: 'id_ID', // Lokal untuk format Rupiah
  ).format(nominal);
}
