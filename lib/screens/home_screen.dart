import 'package:flutter/material.dart';
import '../ui.dart';
import '../utils/format.dart';
import '../state.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final b = AppState.i.balances;

    double totalNGN = 0;
    b.forEach((k, v) {
      // naive: sum as NGN; for demo we treat non-NGN as NGN equivalent stored.
      totalNGN += k == 'NGN' ? v : 0;
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('Wallet'),
        actions: [
          IconButton(onPressed: () => Navigator.pushNamed(context, '/receipt'), icon: const Icon(Icons.qr_code_2)),
        ],
      ),
      bottomNavigationBar: const BottomNav(index: 0),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            ZeusCard(
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                const Text('Total Balance', style: TextStyle(color: Colors.white70)),
                const SizedBox(height: 6),
                Text(fmt('NGN', b['NGN']!), style: const TextStyle(fontSize: 26, fontWeight: FontWeight.w800)),
                const SizedBox(height: 8),
                const Text('Multi-currency portfolios: USD, EUR, GBP, GHC, KSH', style: TextStyle(color: Colors.white60)),
              ]),
            ),
            const SizedBox(height: 12),
            WalletTile(icon: Icons.attach_money, title: 'Naira Wallet', trailing: fmt('NGN', b['NGN']!)),
            WalletTile(icon: Icons.attach_money, title: 'Dollar Wallet', trailing: fmt('USD', b['USD']!)),
            WalletTile(icon: Icons.euro, title: 'Euro Wallet', trailing: fmt('EUR', b['EUR']!)),
            WalletTile(icon: Icons.currency_pound, title: 'Pound Wallet', trailing: fmt('GBP', b['GBP']!)),
            WalletTile(icon: Icons.currency_exchange, title: 'Ghana Cedi', trailing: fmt('GHC', b['GHC']!)),
            WalletTile(icon: Icons.currency_exchange, title: 'Kenyan Shilling', trailing: fmt('KSH', b['KSH']!)),
            const SizedBox(height: 12),
            Row(children: [
              Expanded(child: PrimaryButton(text: 'Send Money', onPressed: () => Navigator.pushNamed(context, '/send'))),
              const SizedBox(width: 12),
              Expanded(child: PrimaryButton(text: 'Transactions', onPressed: () => Navigator.pushNamed(context, '/transactions'))),
            ]),
            const SizedBox(height: 12),
            ZeusCard(
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                const Text('Shortcuts', style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                Wrap(spacing: 10, runSpacing: 10, children: [
                  _chip(context, 'Airtime', Icons.phone_android, '/airtime'),
                  _chip(context, 'Data', Icons.network_check, '/data'),
                  _chip(context, 'Bills', Icons.receipt, '/bills'),
                  _chip(context, 'Convert', Icons.swap_horiz, '/convert'),
                  _chip(context, 'Add Money', Icons.add_card, '/add-money'),
                  _chip(context, 'Open Account', Icons.verified_user, '/open-account'),
                  _chip(context, 'Care', Icons.support_agent, '/customer-care'),
                ]),
              ]),
            ),
          ],
        ),
      ),
    );
  }

  Widget _chip(BuildContext ctx, String t, IconData i, String route) => ActionChip(
        avatar: Icon(i, size: 18, color: Colors.black),
        label: Text(t, style: const TextStyle(fontWeight: FontWeight.w700)),
        onPressed: () => Navigator.pushNamed(ctx, route),
        backgroundColor: const Color(0xFFC9A227),
      );
}
