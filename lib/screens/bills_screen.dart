// lib/screens/bills_screen.dart
import 'package:flutter/material.dart';
import '../ui.dart';
import '../state.dart';

class BillsScreen extends StatefulWidget {
  static const route = '/bills';
  const BillsScreen({super.key});
  @override
  State<BillsScreen> createState() => _BillsScreenState();
}

class _BillsScreenState extends State<BillsScreen> {
  final ref = TextEditingController();
  final amount = TextEditingController();
  String currency = 'NGN';

  void _pay() {
    final a = double.tryParse(amount.text) ?? 0;
    if (a <= 0) return;
    if (a > AppState.billsPerTxn) { _snack('Max ₦100,000 per transaction'); return; }
    if (AppState.i.todayUsed('bills') + a > AppState.billsDaily) { _snack('Daily bills limit ₦500,000 reached'); return; }
    if (AppState.i.balances[currency]! < a) { _snack('Insufficient $currency'); return; }
    AppState.i.balances[currency] = AppState.i.balances[currency]! - a;
    AppState.i._addDaily('bills', a);
    AppState.i.addTransaction(TransactionItem(title: 'Bill • ${ref.text}', currency: currency, amount: -a, time: DateTime.now(), type: 'bills'));
    _snack('Bill paid'); Navigator.pop(context);
  }

  void _snack(String m) => ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(m)));

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Bill Payment')),
    body: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(children: [
        TextFormField(controller: ref, decoration: const InputDecoration(labelText: 'Biller / Reference')),
        DropdownButtonFormField(value: currency, items: const ['NGN','USD','EUR','GBP','GHC','KSH'].map((e)=>DropdownMenuItem(value:e,child:Text(e))).toList(), onChanged: (v)=>setState(()=>currency=v!), decoration: const InputDecoration(labelText: 'Currency')),
        TextFormField(controller: amount, decoration: const InputDecoration(labelText: 'Amount'), keyboardType: const TextInputType.numberWithOptions(decimal: true)),
        const SizedBox(height: 16),
        PrimaryButton(text: 'Pay', onPressed: _pay),
      ]),
    ),
  );
}
