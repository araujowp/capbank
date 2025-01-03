import 'package:intl/intl.dart';

class UtilFormat {
  static String toMoney(double value) {
    final currencyFormat = NumberFormat.currency(
      locale: 'pt_BR',
      symbol: 'R\$',
    );
    return currencyFormat.format(value);
  }

  static String toDate(DateTime dateTime, {String format = 'dd/MM/yyyy'}) {
    return DateFormat(format).format(dateTime);
  }
}
