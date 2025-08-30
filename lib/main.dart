import 'package:flutter/material.dart';
import 'theme.dart';

// Screens
import 'screens/home_screen.dart';
import 'screens/send_screen.dart';
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
import 'screens/receipt_screen.dart';

// For typed receipt args
import 'services/receipt_pdf.dart' show ZeusReceiptData;

class Routes {
  static const home = '/';
  static const send = '/send';
  static const transactions = '/transactions';
  static const care = '/customer-care';
  static const airtime = '/airtime';
  static const data = '/data';
  static const bills = '/bills';
  static const convert = '/convert';
  static const addMoney = '/add-money';
  static const openAccount = '/account-opening';
  static const settings = '/settings';
  static const about = '/about';
  static const receipt = '/receipt';
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
        // NOTE: Receipt handled below in onGenerateRoute because it needs arguments
      },
      onGenerateRoute: (settings) {
        if (settings.name == Routes.receipt) {
          final args = settings.arguments;
          // Expecting a ZeusReceiptData; if not provided, build a harmless default
          final data = (args is ZeusReceiptData)
              ? args
              : ZeusReceiptData(
                  txId: 'ZEUS-${DateTime.now().millisecondsSinceEpoch}',
                  fromName: 'ZEUS User',
                  toName: 'Recipient',
                  toBank: 'Bank',
                  toAccount: '0000000000',
                  currency: 'NGN',
                  amount: 0.00,
                  timestamp: DateTime.now(),
                );
          return MaterialPageRoute(builder: (_) => ReceiptScreen(receipt: data));
        }
        return null; // Let onUnknownRoute handle other cases
      },
      onUnknownRoute: (_) =>
          MaterialPageRoute(builder: (_) => const HomeScreen()),
    );
  }
}
