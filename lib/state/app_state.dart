import 'package:flutter/foundation.dart';

class AppState extends ChangeNotifier {
  static final AppState instance = AppState._();
  AppState._();

  // Balances (mock)
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

  double _todayTransfers = 0;
  double _todayAirtime = 0;
  double _todayData = 0;
  double _todayBills = 0;

  void init() {
    // could load from local storage later
  }

  bool _check(double amount, double single, double daily, double todays) {
    return amount <= single && (todays + amount) <= daily;
  }

  bool canTransfer(double amount) => _check(amount, transferSingleLimit, transferDailyLimit, _todayTransfers);
  bool canAirtime(double amount) => _check(amount, airtimeSingle, airtimeDaily, _todayAirtime);
  bool canData(double amount) => _check(amount, dataSingle, dataDaily, _todayData);
  bool canBills(double amount) => _check(amount, billerSingle, billerDaily, _todayBills);

  void debitNaira(double amount) {
    naira -= amount;
    notifyListeners();
  }

  void creditNaira(double amount) {
    naira += amount;
    notifyListeners();
  }

  // Conversions (simple demo rates)
  void convert({required String from, required String to, required double amount, required double rate}) {
    if (from == 'NGN') naira -= amount;
    if (from == 'USD') usd -= amount;
    if (from == 'EUR') eur -= amount;

    final got = amount * rate;
    if (to == 'NGN') naira += got;
    if (to == 'USD') usd += got;
    if (to == 'EUR') eur += got;
    notifyListeners();
  }
}
