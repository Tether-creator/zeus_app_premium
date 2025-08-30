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

void main() async {
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
      home: const HomeScreen(),
      routes: {
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

