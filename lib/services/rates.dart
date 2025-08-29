class FxRates {
  // Base: NGN. Keep demo-friendly stable rates.
  static const Map<String, double> toNGN = {
    'NGN': 1.0,
    'USD': 1600.0,
    'EUR': 1750.0,
    'GBP': 2050.0,
    'GHC': 130.0,   // demo
    'KSH': 12.0,    // demo
  };

  static double convert({
    required String from,
    required String to,
    required double amount,
  }) {
    if (from == to) return amount;
    final ngn = amount * toNGN[from]!;
    return ngn / toNGN[to]!;
  }
}
