import 'package:intl/intl.dart';

class TransactionItem {
  final String title;
  final String currency;
  final double amount;
  final DateTime time;
  final String type; // 'transfer', 'airtime', 'data', 'bills', 'convert', 'add'
  TransactionItem({required this.title, required this.currency, required this.amount, required this.time, required this.type});
}

class AppState {
  AppState._();
  static final AppState i = AppState._();

  // Initial balances (your numbers)
  final Map<String, double> balances = {
    'NGN': 861785661.39,
    'USD': 601131.66,
    'EUR': 681927.70,
    'GBP': 409551.03,
    'GHC': 57900654.81,
    'KSH': 6674791.30,
  };

  final List<TransactionItem> history = [];

  // Limits (per txn / per day)
  static const transferPerTxn = 2000000.0; // NGN
  static const transferDaily = 100000000.0; // NGN

  static const airtimePerTxn = 20000.0;
  static const airtimeDaily = 100000.0;

  static const dataPerTxn = 20000.0;
  static const dataDaily = 100000.0;

  static const billsPerTxn = 100000.0;
  static const billsDaily = 500000.0;

  final Map<String, double> _dailyTotals = {}; // key: yyyyMMdd:type -> ngnValue

  String _key(String type, DateTime d) => '${DateFormat('yyyyMMdd').format(d)}:$type';

  void _addDaily(String type, double valueNGN) {
    final k = _key(type, DateTime.now());
    _dailyTotals[k] = (_dailyTotals[k] ?? 0) + valueNGN;
  }

  double todayUsed(String type) {
    final k = _key(type, DateTime.now());
    return _dailyTotals[k] ?? 0;
  }

  // Simple helpers (no provider; screens can read state directly)
  void addTransaction(TransactionItem t) => history.insert(0, t);
}
