import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const ZeusApp());
}

class ZeusApp extends StatelessWidget {
  const ZeusApp({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: const Color(0xFF0E2431),
      primaryColor: const Color(0xFFE2B23A),
      colorScheme: const ColorScheme.dark(
        primary: Color(0xFFE2B23A),
        secondary: Color(0xFF1A3A4A),
        surface: Color(0xFF112A36),
      ),
      textTheme: const TextTheme(
        headlineMedium: TextStyle(fontWeight: FontWeight.w700, color: Colors.white),
        bodyLarge: TextStyle(color: Colors.white70),
        bodyMedium: TextStyle(color: Colors.white70),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xFF0E2431),
        elevation: 0,
        centerTitle: true,
        titleTextStyle: TextStyle(
          color: Colors.white, fontWeight: FontWeight.w700, fontSize: 20,
        ),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFE2B23A),
          foregroundColor: Colors.black,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          textStyle: const TextStyle(fontWeight: FontWeight.w700),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: const Color(0xFF112A36),
        labelStyle: const TextStyle(color: Colors.white70),
        hintStyle: const TextStyle(color: Colors.white54),
        prefixIconColor: const Color(0xFFE2B23A),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: Color(0xFF1E3D4B)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: Color(0xFFE2B23A)),
        ),
      ),
      cardTheme: CardTheme(
        color: const Color(0xFF112A36),
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
    );

    return MaterialApp(
      title: 'ZEUS Premium',
      debugShowCheckedModeBanner: false,
      theme: theme,
      home: const _RootShell(),
      routes: {
        '/receipt': (_) => const _Placeholder(title: 'Receipt'),
        '/customer-care': (_) => const _Placeholder(title: 'Customer Care'),
        '/airtime': (_) => const _Placeholder(title: 'Airtime'),
        '/data': (_) => const _Placeholder(title: 'Data'),
        '/bills': (_) => const _Placeholder(title: 'Bill Payment'),
        '/convert': (_) => const _Placeholder(title: 'Currency Convert'),
        '/add-money': (_) => const _Placeholder(title: 'Add Money'),
        '/account-opening': (_) => const _Placeholder(title: 'Account Opening'),
        '/settings': (_) => const _Placeholder(title: 'Settings'),
        '/about': (_) => const _Placeholder(title: 'About'),
      },
    );
  }
}

/// Bottom nav shell with three primary tabs.
/// Swap each tab’s body with your real screens as they’re ready.
class _RootShell extends StatefulWidget {
  const _RootShell({super.key});
  @override
  State<_RootShell> createState() => _RootShellState();
}

class _RootShellState extends State<_RootShell> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    final pages = <Widget>[
      const _HomePage(),
      const _SendPage(),
      const _TransactionsPage(),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('ZEUS — Premium'),
        actions: [
          IconButton(
            tooltip: 'Settings',
            onPressed: () => Navigator.pushNamed(context, '/settings'),
            icon: const Icon(Icons.settings_outlined),
          ),
        ],
      ),
      body: pages[_index],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _index,
        backgroundColor: const Color(0xFF0E2431),
        indicatorColor: const Color(0x33E2B23A),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.account_balance_wallet_outlined), label: 'Home'),
          NavigationDestination(icon: Icon(Icons.send_outlined), label: 'Send'),
          NavigationDestination(icon: Icon(Icons.receipt_long_outlined), label: 'History'),
        ],
        onDestinationSelected: (i) => setState(() => _index = i),
      ),
    );
  }
}

class _HomePage extends StatelessWidget {
  const _HomePage();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text('Total Balance', style: Theme.of(context).textTheme.bodyMedium),
        const SizedBox(height: 8),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('₦861,785,661.39', style: Theme.of(context).textTheme.headlineMedium),
                const SizedBox(height: 6),
                const Text('Multi-currency portfolios: USD, EUR, GBP, GHC, KSH'),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        _walletTile(context, 'Naira Wallet', '₦861,785,661.39', Icons.payments_outlined),
        _walletTile(context, 'Dollar Wallet', 'USD 601,131.66', Icons.attach_money),
        _walletTile(context, 'Euro Wallet', '€681,927.70', Icons.euro),
        _walletTile(context, 'Pound Wallet', '£409,551.03', Icons.currency_pound),
        _walletTile(context, 'Ghana Cedis', 'GHC 57,900,654.81', Icons.currency_exchange),
        _walletTile(context, 'Kenyan Shillings', 'KSh 6,674,791.30', Icons.currency_exchange),

        const SizedBox(height: 20),
        Row(
          children: [
            Expanded(
              child: ElevatedButton.icon(
                onPressed: () => Navigator.pushNamed(context, '/airtime'),
                icon: const Icon(Icons.phone_android),
                label: const Text('Airtime'),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: ElevatedButton.icon(
                onPressed: () => Navigator.pushNamed(context, '/data'),
                icon: const Icon(Icons.wifi),
                label: const Text('Data'),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: ElevatedButton.icon(
                onPressed: () => Navigator.pushNamed(context, '/bills'),
                icon: const Icon(Icons.receipt),
                label: const Text('Bills'),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: ElevatedButton.icon(
                onPressed: () => Navigator.pushNamed(context, '/convert'),
                icon: const Icon(Icons.currency_exchange),
                label: const Text('Convert'),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: ElevatedButton.icon(
                onPressed: () => Navigator.pushNamed(context, '/add-money'),
                icon: const Icon(Icons.add_card),
                label: const Text('Add Money'),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: OutlinedButton.icon(
                style: OutlinedButton.styleFrom(
                  foregroundColor: const Color(0xFFE2B23A),
                  side: const BorderSide(color: Color(0xFFE2B23A)),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                onPressed: () => Navigator.pushNamed(context, '/customer-care'),
                icon: const Icon(Icons.support_agent),
                label: const Text('Customer Care'),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _walletTile(BuildContext context, String title, String trailing, IconData icon) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: Icon(icon, color: const Color(0xFFE2B23A)),
        title: Text(title),
        trailing: Text(trailing, style: const TextStyle(fontWeight: FontWeight.w700)),
      ),
    );
  }
}

class _SendPage extends StatelessWidget {
  const _SendPage();

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final acctCtrl = TextEditingController();
    final bankCtrl = TextEditingController();
    final amountCtrl = TextEditingController();

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Form(
        key: formKey,
        child: ListView(
          children: [
            Text('Send Money', style: Theme.of(context).textTheme.headlineMedium),
            const SizedBox(height: 12),
            TextFormField(
              controller: acctCtrl,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Recipient account'),
              validator: (v) => (v == null || v.trim().length < 10) ? 'Enter valid account' : null,
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: bankCtrl,
              decoration: const InputDecoration(labelText: 'Bank'),
              validator: (v) => (v == null || v.trim().isEmpty) ? 'Choose bank' : null,
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: amountCtrl,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Amount'),
              validator: (v) => (v == null || v.trim().isEmpty) ? 'Enter amount' : null,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Transfer queued (demo).')),
                  );
                }
              },
              child: const Text('Send Now'),
            ),
          ],
        ),
      ),
    );
  }
}

class _TransactionsPage extends StatelessWidget {
  const _TransactionsPage();

  @override
  Widget build(BuildContext context) {
    final tx = <Map<String, String>>[
      {'name': 'David Ogie Musa', 'amt': '₦120,000.00'},
      {'name': 'Jude Ojodomo Benjamin', 'amt': '₦85,700.00'},
      {'name': 'Queen Ajuruchi Benjamin', 'amt': '₦56,210.00'},
      {'name': 'Eunice Oyine Godwin', 'amt': '₦40,000.00'},
      {'name': 'Precious Chinenye Ndukwe', 'amt': '₦12,300.00'},
      {'name': 'Juliet Chinaza Ogaraku', 'amt': '€1,250.00'},
      {'name': 'Gloria Ebube Nworah', 'amt': '£3,100.00'},
      {'name': 'Kelvin Onyemaechi Abugu', 'amt': 'USD 2,000.00'},
      {'name': 'Abel Mairiga Biya', 'amt': 'GHC 9,900.00'},
      {'name': 'Buhari Abubakar Zakariyya', 'amt': 'KSh 77,500.00'},
    ];

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: tx.length,
      itemBuilder: (_, i) {
        final t = tx[i];
        return Card(
          child: ListTile(
            leading: const Icon(Icons.account_circle, color: Color(0xFFE2B23A)),
            title: Text(t['name']!),
            trailing: Text(t['amt']!, style: const TextStyle(fontWeight: FontWeight.w700)),
          ),
        );
      },
    );
  }
}

/// Generic placeholder so routes exist and builds succeed.
/// Replace route targets with your real screens incrementally.
class _Placeholder extends StatelessWidget {
  final String title;
  const _Placeholder({required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(
        child: Text(
          '$title\n(placeholder)',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
    );
  }
}
