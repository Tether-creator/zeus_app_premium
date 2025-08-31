import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'state/app_state.dart';
import 'screens/home_screen.dart';
import 'screens/send_screen.dart';
import 'screens/transactions_screen.dart';
import 'screens/convert_screen.dart';
import 'screens/add_money_screen.dart';
import 'screens/receipt_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const ZeusApp());
}

class ZeusApp extends StatefulWidget {
  const ZeusApp({super.key});
  @override
  State<ZeusApp> createState() => _ZeusAppState();
}

class _ZeusAppState extends State<ZeusApp> {
  final AppState state = AppState();
  int index = 0;

  final currency = NumberFormat.currency(locale: 'en_NG', symbol: '₦');

  // Simple splash: 1 second then show app
  bool _splash = true;

  @override
  void initState() {
    super.initState();
    state.loadBanks();
    Future.delayed(const Duration(seconds: 1), () {
      if (mounted) setState(() => _splash = false);
    });
  }

  @override
  Widget build(BuildContext context) {
    final screens = <Widget>[
      HomeScreen(state: state),
      SendScreen(state: state),
      TransactionsScreen(state: state),
    ];

    return MaterialApp(
      title: 'ZEUS Premium',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF0C0C0E),
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFFE5C063), // ZEUS gold
          secondary: Color(0xFF1F2024),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF0C0C0E),
          elevation: 0,
        ),
        useMaterial3: true,
      ),
      home: _splash
          ? const Splash()
          : Scaffold(
              body: screens[index],
              bottomNavigationBar: NavigationBar(
                selectedIndex: index,
                onDestinationSelected: (i) => setState(() => index = i),
                destinations: const [
                  NavigationDestination(icon: Icon(Icons.home_outlined), selectedIcon: Icon(Icons.home), label: 'Home'),
                  NavigationDestination(icon: Icon(Icons.send_outlined), selectedIcon: Icon(Icons.send), label: 'Send'),
                  NavigationDestination(icon: Icon(Icons.receipt_long_outlined), selectedIcon: Icon(Icons.receipt_long), label: 'History'),
                ],
              ),
              floatingActionButton: FloatingActionButton.extended(
                onPressed: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => ConvertScreen(state: state)),
                ),
                label: const Text('Convert'),
                icon: const Icon(Icons.swap_horiz),
              ),
            ),
      routes: {
        AddMoneyScreen.route: (_) => AddMoneyScreen(state: state),
        ReceiptScreen.route: (_) => ReceiptScreen(state: state),
      },
    );
  }
}

class Splash extends StatelessWidget {
  const Splash({super.key});
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('ZEUS', style: TextStyle(fontSize: 42, fontWeight: FontWeight.bold, color: Color(0xFFE5C063))),
      ),
    );
  }
}
