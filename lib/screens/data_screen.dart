// lib/screens/data_screen.dart
import 'package:flutter/material.dart';
import '../ui.dart';
import '../state.dart';

class DataScreen extends StatefulWidget {
  static const route = '/data';
  const DataScreen({super.key});
  @override
  State<DataScreen> createState() => _DataScreenState();
}

class _DataScreenState extends State<DataScreen> {
  final phone = TextEditingController();
  final amount = TextEditingController();
  String currency = 'NGN';

  void _buy() {
    final a = double.tryParse(amount.text) ?? 0;
    if (a <= 0) return;
    if (a > AppState.dataPerTxn) { _snack('Max ₦20,000 per transaction'); return; }
    if (AppState.i.todayUsed('data') + a > AppState.dataDaily) { _snack('Daily data limit ₦100,000 reached'); return; }
    if (AppState.i.balances[currency]! < a) { _snack('Insufficient $currency'); return; }
    AppState.i.balances[currency] = AppState.i.balances[currency]! - a;
    AppState.i._addDaily('data', a);
    AppState.i.addTransaction(TransactionItem(title: 'Data • ${phone.text}', currency: currency, amount: -a, time: DateTime.now(), type: 'data'));
    _snack('Data purchased'); Navigator.pop(context);
  }

  void _snack(String m) => ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(m)));

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Data')),
    body: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(children: [
        TextFormField(controller: phone, decoration: const InputDecoration(labelText: 'Phone number')),
        DropdownButtonFormField(value: currency, items: const ['NGN','USD','EUR','GBP','GHC','KSH'].map((e)=>DropdownMenuItem(value:e,child:Text(e))).toList(), onChanged: (v)=>setState(()=>currency=v!), decoration: const InputDecoration(labelText: 'Currency')),
        TextFormField(controller: amount, decoration: const InputDecoration(labelText: 'Amount'), keyboardType: const TextInputType.numberWithOptions(decimal: true)),
        const SizedBox(height: 16),
        PrimaryButton(text: 'Buy Data', onPressed: _buy),
      ]),
    ),
  );
}
