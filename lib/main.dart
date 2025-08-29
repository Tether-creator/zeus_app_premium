import 'package:flutter/material.dart';
import 'theme.dart';
import 'ui.dart';

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

class Routes {
  static const home = '/';
  static const send = '/send';
  static const receipt = '/receipt';
  static const transactions = '/transactions';
  static const care = '/customer-care';
  static const airtime = '/airtime';
  static const data = '/data';
  static const bills = '/bills';
  static const convert = '/convert';
  static const addMoney = '/add-money';
  static const openAccount = '/open-account';
  static const settings = '/settings';
  static const about = '/about';
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const ZeusApp());
}

class ZeusApp extends StatelessWidget {
  const ZeusApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ZEUS Premium',
      debugShowCheckedModeBanner: false,
      theme: buildZeusTheme(),
      initialRoute: Routes.home,
      routes: {
        Routes.home: (_) => const HomeScreen(),
        Routes.send: (_) => const SendScreen(),
        Routes.receipt: (_) => const ReceiptScreen(),
        Routes.transactions: (_) => const TransactionsScreen(),
        Routes.care: (_) => const CustomerCareScreen(),
        Routes.airtime: (_) => const AirtimeScreen(),
        Routes.data: (_) => const DataScreen(),
        Routes.bills: (_) => const BillsScreen(),
        Routes.convert: (_) => const ConvertScreen(),
        Routes.addMoney: (_) => const AddMoneyScreen(),
        Routes.openAccount: (_) => const AccountOpeningScreen(),
        Routes.settings: (_) => const SettingsScreen(),
        Routes.about: (_) => const AboutScreen(),
      },
      onUnknownRoute: (_) => MaterialPageRoute(builder: (_) => const HomeScreen()),
    );
  }
}
