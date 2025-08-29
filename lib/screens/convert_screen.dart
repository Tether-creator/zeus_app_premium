import 'package:flutter/material.dart';
import '../ui.dart';
import '../state.dart';
import '../services/rates.dart';
import '../utils/format.dart';

class ConvertScreen extends StatefulWidget {
  static const route = '/convert';
  const ConvertScreen({super.key});

  @override
  State<ConvertScreen> createState() => _ConvertScreenState();
}

class _ConvertScreenState extends State<ConvertScreen> {
  final amt = TextEditingController();
  String from = 'NGN';
  String to = 'USD';

  @override
  void dispose() { amt.dispose(); super.dispose(); }

  void _convert() {
    final a = double.tryParse(amt.text) ?? 0;
    if (a <= 0) return;

    final fromBal = AppState.i.balances[from]!;
    if (fromBal < a) {
      _snack('Insufficient $from balance');
      return;
    }

    final out = FxRates.convert(from: from, to: to, amount: a);
    AppState.i.balances[from] = fromBal - a;
    AppState.i.balances[to] = AppState.i.balances[to]! + out;

    AppState.i.addTransaction(TransactionItem(
      title: 'Convert $from → $to',
      currency: to,
      amount: out,
      time: DateTime.now(),
      type: 'convert',
    ));

    _snack('Converted ${fmt(from, a)} → ${fmt(to, out)}');
    setState(() {});
  }

  void _snack(String m) => ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(m)));

  @override
  Widget build(BuildContext context) {
    final currencies = const ['NGN','USD','EUR','GBP','GHC','KSH'];
    return Scaffold(
      appBar: AppBar(title: const Text('Convert Currency')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(children: [
          DropdownButtonFormField(value: from, items: [for (final c in currencies) DropdownMenuItem(value: c, child: Text(c))], onChanged: (v) => setState(() => from = v!), decoration: const InputDecoration(labelText: 'From')),
          DropdownButtonFormField(value: to, items: [for (final c in currencies) DropdownMenuItem(value: c, child: Text(c))], onChanged: (v) => setState(() => to = v!), decoration: const InputDecoration(labelText: 'To')),
          TextFormField(controller: amt, decoration: const InputDecoration(labelText: 'Amount'), keyboardType: const TextInputType.numberWithOptions(decimal: true)),
          const SizedBox(height: 16),
          PrimaryButton(text: 'Convert', onPressed: _convert),
        ]),
      ),
    );
  }
}
