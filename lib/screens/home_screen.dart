import 'package:flutter/material.dart';
import '../theme.dart';
import 'wallet_screen.dart';
import 'transactions_screen.dart';
import 'send_screen.dart';
import 'airtime_screen.dart';
import 'data_screen.dart';
import 'bills_screen.dart';
import 'convert_screen.dart';
import 'add_money_screen.dart';

class HomeScreen extends StatefulWidget {
  static const route = '/';
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _index = 0;

  final _tabs = const [
    WalletScreen(),
    TransactionsScreen(),
    AddMoneyScreen(),
  ];

  void _onTap(int i) => setState(() => _index = i);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _tabs[_index],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _index,
        onTap: _onTap,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.account_balance_wallet), label: 'Wallet'),
          BottomNavigationBarItem(icon: Icon(Icons.receipt_long), label: 'History'),
          BottomNavigationBarItem(icon: Icon(Icons.add_card), label: 'Add Money'),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 74),
        child: _QuickActionsRow(),
      ),
    );
  }
}

class _QuickActionsRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final chip = (IconData icon, String label, VoidCallback onTap) => ActionChip(
          avatar: Icon(icon, color: Colors.black),
          backgroundColor: ZeusColors.gold,
          label: Text(label, style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w600)),
          onPressed: onTap,
        );

    return Wrap(
      alignment: WrapAlignment.center,
      spacing: 10,
      runSpacing: 10,
      children: [
        chip(Icons.send, 'Send', () => Navigator.pushNamed(context, SendScreen.route)),
        chip(Icons.swap_horiz, 'Convert', () => Navigator.pushNamed(context, ConvertScreen.route)),
        chip(Icons.phone_android, 'Airtime', () => Navigator.pushNamed(context, AirtimeScreen.route)),
        chip(Icons.wifi, 'Data', () => Navigator.pushNamed(context, DataScreen.route)),
        chip(Icons.receipt, 'Bills', () => Navigator.pushNamed(context, BillsScreen.route)),
        chip(Icons.add_card, 'Add Money', () => Navigator.pushNamed(context, AddMoneyScreen.route)),
      ],
    );
  }
}
