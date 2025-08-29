import 'package:flutter/material.dart';
import '../ui.dart';
import '../state.dart';
import '../services/nigeria_banks.dart';
import '../services/rates.dart';
import '../utils/format.dart';

class SendScreen extends StatefulWidget {
  static const route = '/send';
  const SendScreen({super.key});

  @override
  State<SendScreen> createState() => _SendScreenState();
}

class _SendScreenState extends State<SendScreen> {
  final _form = GlobalKey<FormState>();
  final acct = TextEditingController();
  final name = TextEditingController();
  final amount = TextEditingController();
  String bank = NigeriaBanks.banks.first;
  String currency = 'NGN';

  @override
  void dispose() {
    acct.dispose();
    name.dispose();
    amount.dispose();
    super.dispose();
  }

  void _resolve() {
    setState(() {
      name.text = NigeriaBanks.resolveAccountName(accountNumber: acct.text.trim(), bank: bank);
    });
  }

  String? _v(String? v) => (v == null || v.trim().isEmpty) ? 'Required' : null;

  void _send() {
    if (!_form.currentState!.validate()) return;

    final amt = double.tryParse(amount.text.replaceAll(',', '')) ?? 0;
    if (amt <= 0) return;

    // Limits (convert to NGN for checks)
    final ngnVal = FxRates.convert(from: currency, to: 'NGN', amount: amt);
    if (ngnVal > AppState.transferPerTxn) {
      _snack('Max ₦2,000,000 per transaction');
      return;
    }
    if (AppState.i.todayUsed('transfer') + ngnVal > AppState.transferDaily) {
      _snack('Daily transfer limit ₦100,000,000 reached');
      return;
    }

    // Balance check & debit
    final bal = AppState.i.balances[currency]!;
    if (bal < amt) {
      _snack('Insufficient $currency balance');
      return;
    }
    AppState.i.balances[currency] = bal - amt;
    AppState.i._addDaily('transfer', ngnVal);

    // Add history
    AppState.i.addTransaction(TransactionItem(
      title: 'To ${name.text} • $bank',
      currency: currency,
      amount: -amt,
      time: DateTime.now(),
      type: 'transfer',
    ));

    _snack('Sent ${fmt(currency, amt)} to ${name.text}');
    Navigator.pushNamed(context, '/receipt');
    setState(() {});
  }

  void _snack(String m) => ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(m)));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Send Money')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _form,
          child: Column(
            children: [
              TextFormField(controller: acct, decoration: const InputDecoration(labelText: 'Recipient account'), keyboardType: TextInputType.number, maxLength: 10, validator: _v, onChanged: (_) => _resolve()),
              DropdownButtonFormField<String>(value: bank, items: [for (final b in NigeriaBanks.banks) DropdownMenuItem(value: b, child: Text(b))], onChanged: (v) { bank = v!; _resolve(); }, decoration: const InputDecoration(labelText: 'Bank')),
              TextFormField(controller: name, decoration: const InputDecoration(labelText: 'Recipient name'), readOnly: true),
              DropdownButtonFormField<String>(
                value: currency,
                items: const [
                  DropdownMenuItem(value: 'NGN', child: Text('NGN (₦)')),
                  DropdownMenuItem(value: 'USD', child: Text('USD ($)')),
                  DropdownMenuItem(value: 'EUR', child: Text('EUR (€)')),
                  DropdownMenuItem(value: 'GBP', child: Text('GBP (£)')),
                  DropdownMenuItem(value: 'GHC', child: Text('GHC (GH₵)')),
                  DropdownMenuItem(value: 'KSH', child: Text('KES (KSh)')),
                ],
                onChanged: (v) => setState(() => currency = v!),
                decoration: const InputDecoration(labelText: 'Currency'),
              ),
              TextFormField(controller: amount, decoration: const InputDecoration(labelText: 'Amount'), keyboardType: const TextInputType.numberWithOptions(decimal: true), validator: _v),
              const SizedBox(height: 16),
              PrimaryButton(text: 'Send Now', onPressed: _send),
            ],
          ),
        ),
      ),
    );
  }
}
