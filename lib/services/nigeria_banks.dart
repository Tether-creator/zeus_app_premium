class NigeriaBanks {
  static const List<String> banks = [
    'Access Bank', 'GTBank', 'First Bank', 'Zenith Bank', 'UBA',
    'Fidelity Bank', 'FCMB', 'Sterling Bank', 'Union Bank', 'Polaris Bank',
  ];

  // Extremely simple mock resolver for demos.
  static String resolveAccountName({required String accountNumber, required String bank}) {
    if (accountNumber.length == 10) {
      final last2 = int.tryParse(accountNumber.substring(8)) ?? 0;
      final list = [
        'David Ogie Musa',
        'Jude Ojodomo Benjamin',
        'Queen Ajuruchi Benjamin',
        'Eunice Oyine Godwin',
        'Precious Chinenye Ndukwe',
        'Juliet Chinaza Ogaraku',
        'Gloria Ebube Nworah',
        'Kelvin Onyemaechi Abugu',
        'Abel Mairiga Biya',
        'Buhari Abubakar Zakariyya',
      ];
      return list[last2 % list.length];
    }
    return 'Unknown Name';
  }
}
