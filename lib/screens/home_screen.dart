import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../state/app_state.dart';
import 'add_money_screen.dart';
import 'send_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key, required this.state});
  final AppState state;

  @override
  Widget build(BuildContext context) {
    final ngn = NumberFormat.currency(locale: 'en_NG', symbol: '₦');
    Widget wallet(String label, String cur, double amt) => Card(
      child: ListTile(
        title: Text(label),
        subtitle: Text(cur),
        trailing: Text(cur=='NGN' ? ngn.format(amt) : '$cur ${amt.toStringAsFixed(2)}',
            style: const TextStyle(fontWeight: FontWeight.w700)),
      ),
    );

    return Scaffold(
      appBar: AppBar(title: const Text('ZEUS Premium')),
      body: ListView(
        padding: const EdgeInsets.all(12),
        children: [
          wallet('Naira Wallet', 'NGN', state.ngn),
          wallet('Dollar Wallet', 'USD', state.usd),
          wallet('Euro Wallet', 'EUR', state.eur),
          wallet('Kenya Wallet', 'KES', state.kes),
          const SizedBox(height: 12),
          Wrap(
            spacing: 12, runSpacing: 12,
            children: [
              _quick(context, Icons.add_card, 'Add Money', () => Navigator.pushNamed(context, AddMoneyScreen.route)),
              _quick(context, Icons.send, 'Send', () => Navigator.pushNamed(context, SendScreen.route)),
              _quick(context, Icons.phone_android, 'Airtime', () => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Airtime (demo)')))),
              _quick(context, Icons.network_check, 'Data', () => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Data (demo)')))),
              _quick(context, Icons.receipt_long, 'Bills', () => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Bills (demo)')))),
              _quick(context, Icons.support_agent, 'Support', () => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Customer care (demo)')))),
            ],
          ),
        ],
      ),
    );
  }

  Widget _quick(BuildContext c, IconData i, String t, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: (MediaQuery.of(c).size.width - 48) / 2,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: const Color(0xFF1F2024),
        ),
        child: Column(children: [
          Icon(i, size: 28, color: const Color(0xFFE5C063)),
          const SizedBox(height: 8),
          Text(t),
        ]),
      ),
    );
  }
}
