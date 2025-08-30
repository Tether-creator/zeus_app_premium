import 'dart:async';

/// Simple mock of Nigerian bank resolve so it works offline and on web/APK.
/// Swap to a real API by implementing `resolveWithApi` and changing the toggle.
class BankLookupService {
  /// Toggle this to use the (future) live API implementation.
  static const _useMock = true;

  static Future<List<String>> listBanks() async {
    // Minimal set; add more as needed.
    return const [
      'Access Bank',
      'Fidelity Bank',
      'First Bank',
      'FCMB',
      'GTBank',
      'Keystone Bank',
      'Opay',
      'PalmPay',
      'UBA',
      'Zenith Bank',
    ];
  }

  static Future<String?> resolveAccountName({
    required String bank,
    required String accountNumber,
  }) async {
    if (_useMock) return _resolveMock(bank: bank, accountNumber: accountNumber);
    // return resolveWithApi(bank: bank, accountNumber: accountNumber);
  }

  // ---- MOCK IMPLEMENTATION ----
  static Future<String?> _resolveMock({
    required String bank,
    required String accountNumber,
  }) async {
    await Future<void>.delayed(const Duration(milliseconds: 450));
    if (accountNumber.length != 10) return null;

    // Deterministic pseudo "names" so it feels real while demoing.
    final map = {
      '00': 'David Ogie Musa',
      '01': 'Jude Ojodomo Benjamin',
      '02': 'Queen Ajuruchi Benjamin',
      '03': 'Eunice Oyine Godwin',
      '04': 'Precious Chinenye Ndukwe',
      '05': 'Juliet Chinaza Ogaraku',
      '06': 'Gloria Ebube Nworah',
      '07': 'Kelvin Onyemaechi Abugu',
      '08': 'Abel Mairiga Biya',
      '09': 'Buhari Abubakar Zakariyya',
    };
    return map[accountNumber.substring(8)] ?? 'ZEUS User';
  }

  // ---- REAL API SKELETON (leave uncalled for now) ----
  // static Future<String?> resolveWithApi({
  //   required String bank,
  //   required String accountNumber,
  // }) async {
  //   // Example for Paystack/Monnify/VerifyMe/etc.
  //   // final res = await http.get(Uri.parse('https://api.example/resolve?...'),
  //   //   headers: {'Authorization': 'Bearer ${String.fromEnvironment("RESOLVER_KEY")}'});
  //   // if (res.statusCode == 200) { return jsonDecode(res.body)['account_name']; }
  //   // return null;
  // }
}
