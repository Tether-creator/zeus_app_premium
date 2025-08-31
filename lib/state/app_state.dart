import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

class AppState {
  // Balances
  double ngn = 250_000_000; // ₦
  double usd = 150_000;      // $
  double eur = 80_000;       // €
  double kes = 10_000_000;   // KSh

  // Limits
  static const double transferPerTxnNgn = 2_000_000;
  static const double transferDailyNgn  = 100_000_000;

  static const double airtimePerTxnNgn  = 20_000;
  static const double airtimeDailyNgn   = 100_000;

  static const double dataPerTxnNgn     = 20_000;
  static const double dataDailyNgn      = 100_000;

  static const double billPerTxnNgn     = 100_000;
  static const double billDailyNgn      = 500_000;

  // Very light demo FX (replace with live rates later)
  static const Map<String, double> fx = {
    'NGNUSD': 0.00065,
    'NGNEUR': 0.00060,
    'NGNKES': 0.23,
    'USDNGN': 1540.0,
    'EURNGN': 1660.0,
    'KESNGN': 4.3,
  };

  // Local banks cache (demo)
  List<Map<String, String>> banks = [];

  Future<void> loadBanks() async {
    if (banks.isNotEmpty) return;
    final raw = await rootBundle.loadString('assets/data/banks_ng.json');
    final list = List<Map<String, dynamic>>.from(jsonDecode(raw));
    banks = list.map((e) => {'code': '${e['code']}', 'name': '${e['name']}'}).toList();
  }

  // Demo account-name "resolution" (deterministic mock)
  Future<String> resolveAccountName(String accountNumber, String bankCode) async {
    await Future<void>.delayed(const Duration(milliseconds: 300));
    final last4 = accountNumber.substring(accountNumber.length - 4);
    return 'ZEUS USER $last4';
  }

  // Convert & debit/credit helpers
  bool debit(String currency, double amount) {
    final map = {'NGN': ngn, 'USD': usd, 'EUR': eur, 'KES': kes};
    final current = map[currency] ?? 0;
    if (current < amount) return false;
    switch (currency) {
      case 'NGN': ngn -= amount; break;
      case 'USD': usd -= amount; break;
      case 'EUR': eur -= amount; break;
      case 'KES': kes -= amount; break;
    }
    return true;
  }

  void credit(String currency, double amount) {
    switch (currency) {
      case 'NGN': ngn += amount; break;
      case 'USD': usd += amount; break;
      case 'EUR': eur += amount; break;
      case 'KES': kes += amount; break;
    }
  }

  bool convert(String from, String to, double amount) {
    if (from == to) return true;
    final key = '${from}${to}';
    final rate = fx[key];
    if (rate == null) return false;
    if (!debit(from, amount)) return false;
    credit(to, amount * rate);
    return true;
  }
}
