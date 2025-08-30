import 'package:flutter/material.dart';
import '../theme.dart';

class WalletScreen extends StatelessWidget {
  const WalletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Your provided starting balances
    const balances = {
      'NGN': '₦861,785,661.39',
      'USD': 'USD 601,131.66',
      'EUR': '€681,927.70',
      'GBP': '£409,551.03',
      'GHC': 'GHC 57,900,654.81',
      'KSH': 'KSh 6,674,791.30',
    };

    Widget tile(String title, String amount, IconData icon) => Card(
          margin: const EdgeInsets.only(bottom: 12),
          child: ListTile(
            leading: Icon(icon, color: ZeusColors.gold),
            title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
            trailing: Text(amount, style: const TextStyle(fontWeight: FontWeight.w800)),
          ),
        );

    return Scaffold(
      appBar: AppBar(title: const Text('Wallet')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text('Total Balance', style: TextStyle(color: ZeusColors.muted)),
                  SizedBox(height: 8),
                  Text('₦861,785,661.39',
                      style: TextStyle(fontSize: 26, fontWeight: FontWeight.w800)),
                  SizedBox(height: 6),
                  Text('USD • EUR • GBP • GHC • KSH',
                      style: TextStyle(color: ZeusColors.muted)),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          tile('Naira Wallet', balances['NGN']!, Icons.payments_outlined),
          tile('Dollar Wallet', balances['USD']!, Icons.attach_money),
          tile('Euro Wallet', balances['EUR']!, Icons.euro),
          tile('Pound Wallet', balances['GBP']!, Icons.currency_pound),
          tile('Ghana Cedis', balances['GHC']!, Icons.currency_exchange),
          tile('Kenyan Shillings', balances['KSH']!, Icons.currency_exchange),
        ],
      ),
    );
  }
}
