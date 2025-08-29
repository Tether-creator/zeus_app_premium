import 'package:flutter/material.dart';
import '../ui.dart';
import '../state.dart';
import '../utils/format.dart';

class AddMoneyScreen extends StatefulWidget {
  static const route = '/add-money';
  const AddMoneyScreen({super.key});

  @override
  State<AddMoneyScreen> createState() => _AddMoneyScreenState();
}

class _AddMoneyScreenState extends State<AddMoneyScreen> {
  String method = 'Card (OTP)';
  String currency = 'NGN';
  final amount = TextEditingController();
  final card = TextEditingController();
  final exp = TextEditingController();
  final cvv = TextEditingController();
  final otp = TextEditingController();
  bool askOtp = false;

  @override
  void dispose() { amount.dispose(); card.dispose(); exp.dispose(); cvv.dispose(); otp.dispose(); super.dispose(); }

  void _submit() {
    final a = double.tryParse(amount.text) ?? 0;
    if (a <= 0) return;

    if (method == 'Card (OTP)' && !askOtp) {
      setState(() => askOtp = true);
      return;
    }

    AppState.i.balances[currency] = AppState.i.balances[currency]! + a;
    AppState.i.addTransaction(TransactionItem(
      title: 'Add Money • $method',
      currency: currency,
      amount: a,
      time: DateTime.now(),
      type: 'add',
    ));

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Added ${fmt(currency, a)}')));
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final currencyItems = const ['NGN','USD','EUR','GBP','GHC','KSH'];
    final methods = const ['Card (OTP)', 'Bank Transfer', 'Cash Deposit'];
    return Scaffold(
      appBar: AppBar(title: const Text('Add Money')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(children: [
          DropdownButtonFormField(value: method, items: [for (final m in methods) DropdownMenuItem(value: m, child: Text(m))], onChanged: (v) => setState(() => method = v!), decoration: const InputDecoration(labelText: 'Method')),
          DropdownButtonFormField(value: currency, items: [for (final c in currencyItems) DropdownMenuItem(value: c, child: Text(c))], onChanged: (v) => setState(() => currency = v!), decoration: const InputDecoration(labelText: 'Currency')),
          TextFormField(controller: amount, decoration: const InputDecoration(labelText: 'Amount'), keyboardType: const TextInputType.numberWithOptions(decimal: true)),
          if (method == 'Card (OTP)') ...[
            const SizedBox(height: 8),
            TextFormField(controller: card, decoration: const InputDecoration(labelText: 'Card number')),
            Row(children: [
              Expanded(child: TextFormField(controller: exp, decoration: const InputDecoration(labelText: 'MM/YY'))),
              const SizedBox(width: 8),
              Expanded(child: TextFormField(controller: cvv, decoration: const InputDecoration(labelText: 'CVV'))),
            ]),
            if (askOtp) TextFormField(controller: otp, decoration: const InputDecoration(labelText: 'Enter OTP')),
          ],
          const SizedBox(height: 16),
          PrimaryButton(text: askOtp ? 'Confirm' : 'Proceed', onPressed: _submit),
        ]),
      ),
    );
  }
}
