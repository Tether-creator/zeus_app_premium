import 'package:flutter/material.dart';
import '../state/app_state.dart';
import '../utils/format.dart';
import 'transactions_screen.dart';
import 'convert_screen.dart';
import 'send_screen.dart';
import 'airtime_screen.dart';
import 'data_screen.dart';
import 'bills_screen.dart';
import 'add_money_screen.dart';
import 'account_opening_screen.dart';
import 'customer_care_screen.dart';
import 'settings_screen.dart';
import 'about_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  static const route = '/home';
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _index = 0;
  final _pages = const [
    _Dashboard(),
    TransactionsScreen(),
    ConvertScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 250),
      child: Scaffold(
        key: ValueKey(_index),
        appBar: AppBar(title: const Text('ZEUS Premium')),
        body: _pages[_index],
        floatingActionButton: _index == 0
            ? FloatingActionButton.extended(
                onPressed: () => Navigator.pushNamed(context, SendScreen.route),
                label: const Text('Send'),
                icon: const Icon(Icons.send),
              )
            : null,
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _index,
          onTap: (i) => setState(() => _index = i),
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.receipt_long), label: 'History'),
            BottomNavigationBarItem(icon: Icon(Icons.swap_horiz), label: 'Convert'),
          ],
        ),
      ),
    );
  }
}

class _Dashboard extends StatelessWidget {
  const _Dashboard();

  @override
  Widget build(BuildContext context) {
    final s = AppState.instance;
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Row(
          children: [
            Expanded(child: _balanceCard('NGN', money('NGN', s.naira))),
            const SizedBox(width: 12),
            Expanded(child: _balanceCard('USD', money('USD', s.usd))),
            const SizedBox(width: 12),
            Expanded(child: _balanceCard('EUR', money('EUR', s.eur))),
          ],
        ),
        const SizedBox(height: 16),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: const [
            _QuickTile(icon: Icons.phone_android, title: 'Airtime', route: '/airtime'),
            _QuickTile(icon: Icons.network_cell, title: 'Data', route: '/data'),
            _QuickTile(icon: Icons.receipt, title: 'Bills', route: '/bills'),
            _QuickTile(icon: Icons.account_balance_wallet, title: 'Add Money', route: '/add-money'),
            _QuickTile(icon: Icons.person_add, title: 'Open Account', route: '/account-open'),
            _QuickTile(icon: Icons.support_agent, title: 'Customer Care', route: '/customer-care'),
            _QuickTile(icon: Icons.settings, title: 'Settings', route: '/settings'),
            _QuickTile(icon: Icons.info, title: 'About', route: '/about'),
          ],
        ),
      ],
    );
  }

  Widget _balanceCard(String label, String amt) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(label, style: const TextStyle(fontSize: 13, color: Colors.white70)),
          const SizedBox(height: 8),
          Text(amt, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
        ]),
      ),
    );
  }
}

class _QuickTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String route;
  const _QuickTile({required this.icon, required this.title, required this.route});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.pushNamed(context, route),
      child: Container(
        width: 160,
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: const Color(0xFF151515),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.white10),
        ),
        child: Row(children: [
          Icon(icon),
          const SizedBox(width: 10),
          Flexible(child: Text(title, overflow: TextOverflow.ellipsis)),
        ]),
      ),
    );
  }
}
