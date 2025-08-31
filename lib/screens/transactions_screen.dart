import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../state/app_state.dart';

class TransactionsScreen extends StatelessWidget {
  const TransactionsScreen({super.key, required this.state});
  final AppState state;

  static const route = '/transactions';

  @override
  Widget build(BuildContext context) {
    final ngn = NumberFormat.currency(locale: 'en_NG', symbol: '₦');
    final usd = NumberFormat.currency(locale: 'en_US', symbol: r'$'); // ← use raw string to avoid interpolation

    final txns = <Map<String, dynamic>>[
      {'title': 'Wallet Top-up', 'amount': 1500000.0, 'cur': 'NGN', 'time': DateTime.now().subtract(const Duration(hours: 2))},
      {'title': 'Airtime – MTN', 'amount': 5000.0, 'cur': 'NGN', 'time': DateTime.now().subtract(const Duration(hours: 5))},
      {'title': 'Transfer to Vendor', 'amount': 2000.0, 'cur': 'USD', 'time': DateTime.now().subtract(const Duration(days: 1))},
    ];

    String fmt(String cur, double amt) {
      return cur == 'NGN' ? ngn.format(amt) : usd.format(amt);
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Transactions')),
      body: ListView.separated(
        itemCount: txns.length,
        separatorBuilder: (_, __) => const Divider(height: 1),
        itemBuilder: (_, i) {
          final t = txns[i];
          return ListTile(
            leading: const Icon(Icons.compare_arrows),
            title: Text(t['title']),
            subtitle: Text((t['time'] as DateTime).toString()),
            trailing: Text(fmt(t['cur'], t['amount'] as double), style: const TextStyle(fontWeight: FontWeight.w700)),
          );
        },
      ),
    );
  }
}
