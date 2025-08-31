import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../state/app_state.dart';
import 'transactions_screen.dart';
import 'settings_screen.dart';
import 'send_screen.dart';
import 'airtime_screen.dart';
import 'data_screen.dart';
import 'bills_screen.dart';
import 'convert_screen.dart';
import 'add_money_screen.dart';
import 'account_opening_screen.dart';
import 'customer_care_screen.dart';
import 'receipt_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  static const route = '/';
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _tab = 0;

  @override
  Widget build(BuildContext context) {
    final app = context.watch<AppState>();
    final accent = const Color(0xFFF0C46A);

    final pages = [
      _HomeTab(accent: accent),
      const TransactionsScreen(),
      const SettingsScreen(),
    ];

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: Text('Balance: ${app.ngnFmt}',
            style: TextStyle(color: accent, fontWeight: FontWeight.w700)),
        centerTitle: false,
      ),
      body: pages[_tab],
      bottomNavigationBar: NavigationBar(
        backgroundColor: Colors.black,
        indicatorColor: accent.withOpacity(.15),
        selectedIndex: _tab,
        onDestinationSelected: (i) => setState(() => _tab = i),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home_outlined), label: 'Home'),
          NavigationDestination(icon: Icon(Icons.receipt_long_outlined), label: 'Transactions'),
          NavigationDestination(icon: Icon(Icons.settings_outlined), label: 'Settings'),
        ],
      ),
    );
  }
}

class _HomeTab extends StatelessWidget {
  final Color accent;
  const _HomeTab({required this.accent});

  @override
  Widget build(BuildContext context) {
    final tiles = <_ActionTile>[
      _ActionTile('Send Money', Icons.send, () {
        Navigator.pushNamed(context, SendScreen.route);
      }),
      _ActionTile('Airtime', Icons.phone_android, () {
        Navigator.pushNamed(context, AirtimeScreen.route);
      }),
      _ActionTile('Data', Icons.wifi_tethering, () {
        Navigator.pushNamed(context, DataScreen.route);
      }),
      _ActionTile('Bills', Icons.receipt, () {
        Navigator.pushNamed(context, BillsScreen.route);
      }),
      _ActionTile('Convert', Icons.swap_horiz, () {
        Navigator.pushNamed(context, ConvertScreen.route);
      }),
      _ActionTile('Add Money', Icons.account_balance_wallet, () {
        Navigator.pushNamed(context, AddMoneyScreen.route);
      }),
      _ActionTile('Open Account', Icons.person_add, () {
        Navigator.pushNamed(context, AccountOpeningScreen.route);
      }),
      _ActionTile('Customer Care', Icons.support_agent, () {
        Navigator.pushNamed(context, CustomerCareScreen.route);
      }),
      _ActionTile('Receipt', Icons.picture_as_pdf, () {
        Navigator.pushNamed(context, ReceiptScreen.route);
      }),
    ];

    return GridView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: tiles.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3, mainAxisSpacing: 12, crossAxisSpacing: 12, childAspectRatio: .90),
      itemBuilder: (_, i) => _TileCard(tile: tiles[i], accent: accent),
    );
  }
}

class _ActionTile {
  final String title;
  final IconData icon;
  final VoidCallback onTap;
  _ActionTile(this.title, this.icon, this.onTap);
}

class _TileCard extends StatelessWidget {
  final _ActionTile tile;
  final Color accent;
  const _TileCard({required this.tile, required this.accent});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: tile.onTap,
      borderRadius: BorderRadius.circular(16),
      child: Ink(
        decoration: BoxDecoration(
          color: const Color(0xFF111111),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: accent.withOpacity(.25)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(tile.icon, color: accent, size: 28),
            const SizedBox(height: 8),
            Text(tile.title, textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w600)),
          ],
        ),
      ),
    );
  }
}
