import 'package:flutter/material.dart';
import '../theme.dart';
import '../services/limits.dart';

class BillsScreen extends StatefulWidget {
  static const route = '/bills';
  const BillsScreen({super.key});

  @override
  State<BillsScreen> createState() => _BillsScreenState();
}

class _BillsScreenState extends State<BillsScreen> {
  final _formKey = GlobalKey<FormState>();
  final _billerCtrl = TextEditingController();
  final _amountCtrl = TextEditingController();

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    final amt = double.tryParse(_amountCtrl.text) ?? 0;
    if (amt > ZeusLimits.billsPerTxn) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Per-transaction limit is ₦${ZeusLimits.billsPerTxn.toInt()}')),
      );
      return;
    }
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Bill payment submitted.')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pay Bills')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _billerCtrl,
                decoration: const InputDecoration(labelText: 'Biller / Service'),
                validator: (v) => v!.isNotEmpty ? null : 'Enter biller name',
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _amountCtrl,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Amount (NGN)'),
                validator: (v) => (double.tryParse(v ?? '') ?? 0) > 0 ? null : 'Enter amount',
              ),
              const SizedBox(height: 18),
              FilledButton(onPressed: _submit, child: const Text('Pay Now')),
            ],
          ),
        ),
      ),
    );
  }
}
