import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

class BankInfo {
  final String name;
  final String code;
  final String slug;
  BankInfo({required this.name, required this.code, required this.slug});
  factory BankInfo.fromJson(Map<String, dynamic> j) =>
      BankInfo(name: j['name'], code: j['code'], slug: j['slug']);
}

class BankLookup {
  static List<BankInfo>? _banks;

  static Future<List<BankInfo>> banks() async {
    if (_banks != null) return _banks!;
    final raw = await rootBundle.loadString('assets/data/nigeria_banks.json');
    final list = (json.decode(raw) as List).cast<Map<String, dynamic>>();
    _banks = list.map(BankInfo.fromJson).toList();
    return _banks!;
  }

  /// Demo “resolve account name”. In production, hit Paystack/Monnify/Live backend.
  static Future<String> resolveAccountName({
    required String accountNumber,
    required String bankCode,
  }) async {
    await Future.delayed(const Duration(milliseconds: 400));
    // Simple mock: mask + deterministic initials based on accountNumber.
    if (accountNumber.length < 10) return 'Invalid account';
    final tail = accountNumber.substring(accountNumber.length - 4);
    return 'ZEUS User ••••$tail';
  }
}
