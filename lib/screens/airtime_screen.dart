// lib/screens/airtime_screen.dart
import 'package:flutter/material.dart';
import '../ui.dart';
import '../state.dart';

class AirtimeScreen extends StatefulWidget {
  static const route = '/airtime';
  const AirtimeScreen({super.key});
  @override
  State<AirtimeScreen> createState() => _AirtimeScreenState();
}

class _AirtimeScreenState extends State<AirtimeScreen> {
  final phone = TextEditingController();
  final amount = TextEditingController();
  String currency = 'NGN';

  void _buy() {
    final a = double.tryParse(amount.text) ?? 0;
    if (a <= 0) return;
    if (a > AppState.airtimePerTxn) { _snack('Max ₦20,000 per transaction'); return; }
    if (AppState.i.todayUsed('airtime') + a > AppState.airtimeDaily) { _snack('Daily airtime limit ₦100,000 reached'); return; }
    if (AppState.i.balances[currency]! < a) { _snack('Insufficient $currency'); return; }
    AppState.i.balances[currency] = AppState.i.balances[currency]! - a;
    AppState.i._addDaily('airtime', a);
    AppState.i.addTransaction(TransactionItem(title: 'Airtime • ${phone.text}', currency: currency, amount: -a, time: DateTime.now(), type: 'airtime'));
    _snack('Airtime purchased');
    Navigator.pop(context);
  }

  void _snack(String m) => ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(m)));

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Airtime')),
    body: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(children: [
        TextFormField(controller: phone, decoration: const InputDecoration(labelText: 'Phone number')),
        DropdownButtonFormField(value: currency, items: const ['NGN','USD','EUR','GBP','GHC','KSH'].map((e)=>DropdownMenuItem(value:e,child:Text(e))).toList(), onChanged: (v)=>setState(()=>currency=v!), decoration: const InputDecoration(labelText: 'Currency')),
        TextFormField(controller: amount, decoration: const InputDecoration(labelText: 'Amount'), keyboardType: const TextInputType.numberWithOptions(decimal: true)),
        const SizedBox(height: 16),
        PrimaryButton(text: 'Buy Airtime', onPressed: _buy),
      ]),
    ),
  );
}
