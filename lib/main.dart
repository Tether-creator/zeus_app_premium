import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'state/app_state.dart';
import 'screens/splash_screen.dart';
import 'screens/home_screen.dart';
import 'screens/send_screen.dart';
import 'screens/receipt_screen.dart';
import 'screens/transactions_screen.dart';
import 'screens/customer_care_screen.dart';
import 'screens/airtime_screen.dart';
import 'screens/data_screen.dart';
import 'screens/bills_screen.dart';
import 'screens/convert_screen.dart';
import 'screens/add_money_screen.dart';
import 'screens/account_opening_screen.dart';
import 'screens/settings_screen.dart';
import 'screens/about_screen.dart';

ThemeData _zeusTheme() {
  const gold = Color(0xFFF0C46A);
  final base = ThemeData.dark(useMaterial3: true);
  return base.copyWith(
    colorScheme: base.colorScheme.copyWith(
      primary: gold,
      secondary: gold,
      surface: const Color(0xFF0D0D0D),
      onSurface: Colors.white,
    ),
    scaffoldBackgroundColor: Colors.black,
    appBarTheme: const AppBarTheme(backgroundColor: Colors.black, foregroundColor: gold),
    textTheme: base.textTheme.apply(bodyColor: Colors.white, displayColor: Colors.white),
    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: Colors.black,
      indicatorColor: gold.withOpacity(.15),
      labelTextStyle: WidgetStateProperty.all(const TextStyle(color: Colors.white)),
    ),
  );
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    ChangeNotifierProvider(
      create: (_) => AppState(),
      child: const ZeusApp(),
    ),
  );
}

class ZeusApp extends StatelessWidget {
  const ZeusApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ZEUS Premium',
      debugShowCheckedModeBanner: false,
      theme: _zeusTheme(),
      initialRoute: SplashScreen.route,
      routes: {
        SplashScreen.route: (_) => const SplashScreen(),
        HomeScreen.route: (_) => const HomeScreen(),
        SendScreen.route: (_) => const SendScreen(),
        ReceiptScreen.route: (_) => const ReceiptScreen(),
        TransactionsScreen.route: (_) => const TransactionsScreen(),
        CustomerCareScreen.route: (_) => const CustomerCareScreen(),
        AirtimeScreen.route: (_) => const AirtimeScreen(),
        DataScreen.route: (_) => const DataScreen(),
        BillsScreen.route: (_) => const BillsScreen(),
        ConvertScreen.route: (_) => const ConvertScreen(),
        AddMoneyScreen.route: (_) => const AddMoneyScreen(),
        AccountOpeningScreen.route: (_) => const AccountOpeningScreen(),
        SettingsScreen.route: (_) => const SettingsScreen(),
        AboutScreen.route: (_) => const AboutScreen(),
      },
    );
  }
}
