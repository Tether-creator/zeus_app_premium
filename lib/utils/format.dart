import 'package:intl/intl.dart';

final _ngn = NumberFormat.currency(locale: 'en_NG', symbol: '₦', decimalDigits: 2);
final _usd = NumberFormat.currency(locale: 'en_US', symbol: '\$', decimalDigits: 2);
final _eur = NumberFormat.currency(locale: 'en_IE', symbol: '€', decimalDigits: 2);

String money(String ccy, num v) {
  switch (ccy) {
    case 'NGN': return _ngn.format(v);
    case 'USD': return _usd.format(v);
    case 'EUR': return _eur.format(v);
    default: return NumberFormat.currency(symbol: '$ccy ').format(v);
  }
}
