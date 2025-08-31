import 'package:flutter/material.dart';
import '../data/billers.dart';
import '../state/app_state.dart';
import '../utils/format.dart';

class BillsScreen extends StatefulWidget {
  const BillsScreen({super.key});
  static const route = '/bills';
  @override
  State<BillsScreen> createState() => _BillsScreenState();
}

class _BillsScreenState extends State<BillsScreen> {
  Biller _selected = billers.first;
  final _amtCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final s = AppState.instance;

    void _pay() {
      final amount = double.tryParse(_amtCtrl.text);
      if (amount == null || amount <= 0) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Enter valid amount')));
        return;
      }
      if (!s.canBills(amount)) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Biller limit: ₦100,000 per txn / ₦500,000 daily'),
        ));
        return;
      }
      s.debitNGN(amount, type: 'bill', title: _selected.name, channel: _selected.category);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Paid ${_selected.name} • ${money('NGN', amount)}')),
      );
      _amtCtrl.clear();
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Bill Payment')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          DropdownButtonFormField<Biller>(
            value: _selected,
            decoration: const InputDecoration(labelText: 'Biller'),
            items: billers.map((b)=>DropdownMenuItem(value:b, child: Text('${b.name}  •  ${b.category}'))).toList(),
            onChanged: (b)=>setState(()=>_selected=b!),
          ),
          const SizedBox(height: 12),
          TextFormField(
            controller: _amtCtrl,
            decoration: const InputDecoration(labelText: 'Amount (NGN)'),
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 18),
          FilledButton.icon(onPressed: _pay, icon: const Icon(Icons.receipt_long), label: const Text('Pay')),
        ],
      ),
    );
  }
}
