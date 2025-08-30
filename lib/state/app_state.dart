import 'package:flutter/foundation.dart';

class TransactionItem {
  final DateTime ts;
  final String type;     // transfer | airtime | data | bill | convert | add
  final String ccy;      // NGN | USD | EUR
  final double amount;   // negative = debit, positive = credit
  final String title;    // display name (beneficiary/provider)
  final String channel;  // bank / card / provider / biller
  final String ref;
  const TransactionItem({
    required this.ts,
    required this.type,
    required this.ccy,
    required this.amount,
    required this.title,
    required this.channel,
    required this.ref,
  });
}

class AppState extends ChangeNotifier {
  static final AppState instance = AppState._();
  AppState._();

  // Balances (mock, NGN is primary for transfers/billers)
  double naira = 2_500_000;
  double usd = 12_300;
  double eur = 6_800;

  // Limits
  double transferSingleLimit = 2_000_000;
  double transferDailyLimit = 100_000_000;

  double airtimeSingle = 20_000;
  double airtimeDaily = 100_000;

  double dataSingle = 20_000;
  double dataDaily = 100_000;

  double billerSingle = 100_000;
  double billerDaily = 500_000;

  // Running totals (reset daily in a real app)
  double _todayTransfers = 0;
  double _todayAirtime = 0;
  double _todayData = 0;
  double _todayBills = 0;

  final List<TransactionItem> _tx = [];
  List<TransactionItem> get transactions => List.unmodifiable(_tx);

  void init() {}

  bool _check(double amount, double single, double daily, double todays) {
    return amount <= single && (todays + amount) <= daily;
  }

  bool canTransfer(double amount) => _check(amount, transferSingleLimit, transferDailyLimit, _todayTransfers);
  bool canAirtime(double amount) => _check(amount, airtimeSingle, airtimeDaily, _todayAirtime);
  bool canData(double amount) => _check(amount, dataSingle, dataDaily, _todayData);
  bool canBills(double amount) => _check(amount, billerSingle, billerDaily, _todayBills);

  String _ref(String prefix) => '$prefix-${DateTime.now().millisecondsSinceEpoch}';

  void _pushTx(TransactionItem t) {
    _tx.insert(0, t);
    notifyListeners();
  }

  // Money helpers
  void debitNGN(double amount, {required String type, required String title, required String channel}) {
    naira -= amount;
    if (type == 'transfer') _todayTransfers += amount;
    if (type == 'airtime') _todayAirtime += amount;
    if (type == 'data') _todayData += amount;
    if (type == 'bill') _todayBills += amount;

    _pushTx(TransactionItem(
      ts: DateTime.now(),
      type: type,
      ccy: 'NGN',
      amount: -amount,
      title: title,
      channel: channel,
      ref: _ref('ZEUS'),
    ));
  }

  void creditNGN(double amount, {required String type, required String title, required String channel}) {
    naira += amount;
    _pushTx(TransactionItem(
      ts: DateTime.now(),
      type: type,
      ccy: 'NGN',
      amount: amount,
      title: title,
      channel: channel,
      ref: _ref('ZEUS'),
    ));
  }

  // FX convert
  void convert({required String from, required String to, required double amount, required double rate}) {
    if (from == 'NGN') naira -= amount;
    if (from == 'USD') usd -= amount;
    if (from == 'EUR') eur -= amount;

    final got = amount * rate;
    if (to == 'NGN') naira += got;
    if (to == 'USD') usd += got;
    if (to == 'EUR') eur += got;

    _pushTx(TransactionItem(
      ts: DateTime.now(),
      type: 'convert',
      ccy: to,
      amount: got,
      title: 'Convert $from→$to',
      channel: 'FX Desk',
      ref: _ref('FX'),
    ));
  }
}
