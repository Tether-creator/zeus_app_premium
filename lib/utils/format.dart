import 'package:intl/intl.dart';

String fmt(String code, num amount) {
  switch (code) {
    case 'NGN':
      return '₦${NumberFormat('#,##0.00').format(amount)}';
    case 'USD':
      return 'USD \$${NumberFormat('#,##0.00').format(amount)}';
    case 'EUR':
      return '€${NumberFormat('#,##0.00').format(amount)}';
    case 'GBP':
      return '£${NumberFormat('#,##0.00').format(amount)}';
    case 'GHC':
      return 'GH₵${NumberFormat('#,##0.00').format(amount)}';
    case 'KSH':
      return 'KSh ${NumberFormat('#,##0.00').format(amount)}';
    default:
      return '${NumberFormat('#,##0.00').format(amount)} $code';
  }
}
