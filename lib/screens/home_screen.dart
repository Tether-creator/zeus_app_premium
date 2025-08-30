import 'package:flutter/material.dart';
import 'send_screen.dart';
import 'transactions_screen.dart';
import 'convert_screen.dart';

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
    return Scaffold(
      appBar: AppBar(title: const Text('ZEUS Premium')),
      body: _pages[_index],
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Navigator.pushNamed(context, SendScreen.route),
        label: const Text('Send'),
        icon: const Icon(Icons.send),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _index,
        onTap: (i) => setState(() => _index = i),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.receipt_long), label: 'History'),
          BottomNavigationBarItem(icon: Icon(Icons.swap_horiz), label: 'Convert'),
        ],
      ),
    );
  }
}

class _Dashboard extends StatelessWidget {
  const _Dashboard();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _Tile(icon: Icons.phone_android, title: 'Airtime Purchase', onTap: () => Navigator.pushNamed(context, '/airtime')),
        _Tile(icon: Icons.network_cell, title: 'Data Purchase', onTap: () => Navigator.pushNamed(context, '/data')),
        _Tile(icon: Icons.receipt, title: 'Bill Payment', onTap: () => Navigator.pushNamed(context, '/bills')),
        _Tile(icon: Icons.account_balance_wallet, title: 'Add Money', onTap: () => Navigator.pushNamed(context, '/add-money')),
        _Tile(icon: Icons.person_add, title: 'Open Account', onTap: () => Navigator.pushNamed(context, '/account-open')),
        _Tile(icon: Icons.support_agent, title: 'Customer Care', onTap: () => Navigator.pushNamed(context, '/customer-care')),
        _Tile(icon: Icons.settings, title: 'Settings', onTap: () => Navigator.pushNamed(context, '/settings')),
        _Tile(icon: Icons.info, title: 'About', onTap: () => Navigator.pushNamed(context, '/about')),
      ],
    );
  }
}

class _Tile extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;
  const _Tile({required this.icon, required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(leading: Icon(icon), title: Text(title), trailing: const Icon(Icons.chevron_right), onTap: onTap),
    );
  }
}
