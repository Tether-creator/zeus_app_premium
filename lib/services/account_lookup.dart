import '../data/nigeria_banks.dart';

// Deterministic mock: returns a plausible name based on digits.
// Replace with live BVN/NIP verification when keys are available.
String? resolveAccountName(String accountNumber, NigeriaBank bank) {
  final acc = accountNumber.replaceAll(RegExp(r'[^0-9]'), '');
  if (acc.length != 10) return null;

  const first = ['Chinedu','Ayomide','Fatima','Ifeanyi','Aisha','Tunde','Ngozi','Bolu','Hassan','Adaeze'];
  const last  = ['Okeke','Balogun','Mohammed','Okon','Sule','Lawal','Umeh','Nwankwo','Adesina','Oladipo'];

  final i = int.parse(acc.substring(0, 5)) % first.length;
  final j = int.parse(acc.substring(5)) % last.length;
  return '${first[i]} ${last[j]}';
}
