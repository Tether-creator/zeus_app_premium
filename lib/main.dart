// lib/main.dart
import 'dart:async';
import 'package:flutter/material.dart';

// ---- Screens (adjust the import paths if your folder name differs) ----
import 'screens/splash_screen.dart';
import 'screens/home_screen.dart';
import 'screens/about_screen.dart';
import 'screens/account_opening_screen.dart';
import 'screens/add_money_screen.dart';
import 'screens/airtime_screen.dart';
import 'screens/bills_screen.dart';
import 'screens/convert_screen.dart';
import 'screens/customer_care_screen.dart';
import 'screens/data_screen.dart';
import 'screens/receipt_screen.dart';
import 'screens/send_screen.dart';
import 'screens/settings_screen.dart';
import 'screens/transactions_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runZonedGuarded(() {
    runApp(const ZeusPremiumApp());
  }, (error, stack) {
    debugPrint('ZEUS Premium Uncaught Error: $error');
  });
}

class ZeusPremiumApp extends StatelessWidget {
  const ZeusPremiumApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ZEUS Premium',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF111111)),
      ),
      initialRoute: ScreensRegistry.initialRoute,  // change if needed
      onGenerateRoute: ScreensRegistry.onGenerateRoute,
    );
  }
}

class ScreensRegistry {
  // If you want KYC first, change to '/account_opening' or your real KYC route.
  static const String initialRoute = '/splash';

  static final Map<String, WidgetBuilder> _routes = <String, WidgetBuilder>{
    '/splash': (_) => const SplashScreen(),
    '/home': (_) => const HomeScreen(),
    '/about': (_) => const AboutScreen(),
    '/account_opening': (_) => const AccountOpeningScreen(),
    '/add_money': (_) => const AddMoneyScreen(),
    '/airtime': (_) => const AirtimeScreen(),
    '/bills': (_) => const BillsScreen(),
    '/convert': (_) => const ConvertScreen(),
    '/customer_care': (_) => const CustomerCareScreen(),
    '/data': (_) => const DataScreen(),
    '/receipt': (_) => const ReceiptScreen(),
    '/send': (_) => const SendScreen(),
    '/settings': (_) => const SettingsScreen(),
    '/transactions': (_) => const TransactionsScreen(),
  };

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    final builder = _routes[settings.name];
    if (builder != null) {
      return MaterialPageRoute(builder: builder, settings: settings);
    }
    return MaterialPageRoute(
      builder: (_) => _UnknownRouteScreen(route: settings.name ?? 'unknown'),
      settings: settings,
    );
  }
}

class _UnknownRouteScreen extends StatelessWidget {
  final String route;
  const _UnknownRouteScreen({required this.route});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Route not found')),
      body: Center(child: Text('No screen registered for: $route')),
    );
  }
}
