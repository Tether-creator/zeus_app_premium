import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

class AppState extends ChangeNotifier {
  // Balances (demo only)
  double ngnBalance = 5_000_000; // ₦5,000,000
  double usdBalance = 8_500;     // $8,500
  double eurBalance = 3_200;     // €3,200

  // Running totals (reset with a "new day" in real backend)
  double _spentTodayNGN = 0;
  double _spentTodayAirtime = 0;
  double _spentTodayData = 0;
  double _spentTodayBills = 0;

  // Limits
  static const double transferPerTxLimitNGN = 2_000_000;
  static const double transferDailyLimitNGN  = 100_000_000;

  static const double airtimePerTxLimitNGN = 20_000;
  static const double airtimeDailyLimitNGN  = 100_000;

  static const double dataPerTxLimitNGN = 20_000;
  static const double dataDailyLimitNGN  = 100_000;

  static const double billsPerTxLimitNGN = 100_000;
  static const double billsDailyLimitNGN  = 500_000;

  String get ngnFmt => NumberFormat.currency(locale: 'en_NG', symbol: '₦')
      .format(ngnBalance);

  // ---- limit guards (demo) ----
  bool _checkAndDebitNGN(double amount,
      {required double perTx, required double dailyCap, required double todaySpentBucket}) {
    if (amount <= 0) return false;
    if (amount > perTx) return false;
    if ((todaySpentBucket + amount) > dailyCap) return false;
    if (ngnBalance < amount) return false;
    ngnBalance -= amount;
    notifyListeners();
    return true;
  }

  // Public actions (simulate success: returns true/false)
  bool sendTransfer(double amountNGN) {
    final ok = _checkAndDebitNGN(
      amountNGN,
      perTx: transferPerTxLimitNGN,
      dailyCap: transferDailyLimitNGN,
      todaySpentBucket: _spentTodayNGN,
    );
    if (ok) _spentTodayNGN += amountNGN;
    return ok;
  }

  bool buyAirtime(double amountNGN) {
    final ok = _checkAndDebitNGN(
      amountNGN,
      perTx: airtimePerTxLimitNGN,
      dailyCap: airtimeDailyLimitNGN,
      todaySpentBucket: _spentTodayAirtime,
    );
    if (ok) _spentTodayAirtime += amountNGN;
    return ok;
  }

  bool buyData(double amountNGN) {
    final ok = _checkAndDebitNGN(
      amountNGN,
      perTx: dataPerTxLimitNGN,
      dailyCap: dataDailyLimitNGN,
      todaySpentBucket: _spentTodayData,
    );
    if (ok) _spentTodayData += amountNGN;
    return ok;
  }

  bool payBill(double amountNGN) {
    final ok = _checkAndDebitNGN(
      amountNGN,
      perTx: billsPerTxLimitNGN,
      dailyCap: billsDailyLimitNGN,
      todaySpentBucket: _spentTodayBills,
    );
    if (ok) _spentTodayBills += amountNGN;
    return ok;
  }

  // FX conversions (very simple demo rates)
  void convert(String from, String to, double amount) {
    if (amount <= 0) return;
    double ngn = ngnBalance, usd = usdBalance, eur = eurBalance;

    // mock rates
    const ngnPerUsd = 1500.0;
    const ngnPerEur = 1600.0;

    bool success = false;

    switch ('$from-$to') {
      case 'NGN-USD':
        if (ngn >= amount) {
          ngn -= amount;
          usd += amount / ngnPerUsd;
          success = true;
        }
        break;
      case 'NGN-EUR':
        if (ngn >= amount) {
          ngn -= amount;
          eur += amount / ngnPerEur;
          success = true;
        }
        break;
      case 'USD-NGN':
        if (usd >= amount) {
          usd -= amount;
          ngn += amount * ngnPerUsd;
          success = true;
        }
        break;
      case 'EUR-NGN':
        if (eur >= amount) {
          eur -= amount;
          ngn += amount * ngnPerEur;
          success = true;
        }
        break;
      default:
        break;
    }

    if (success) {
      ngnBalance = ngn;
      usdBalance = usd;
      eurBalance = eur;
      notifyListeners();
    }
  }

  // Top-up (card/bank/pos/cash) – mock credit
  void addMoneyNGN(double amount) {
    if (amount <= 0) return;
    ngnBalance += amount;
    notifyListeners();
  }
}
