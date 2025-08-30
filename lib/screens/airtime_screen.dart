import 'package:flutter/material.dart';
import '../theme.dart';
import '../services/limits.dart';

class AirtimeScreen extends StatefulWidget {
  static const route = '/airtime';
  const AirtimeScreen({super.key});

  @override
  State<AirtimeScreen> createState() => _AirtimeScreenState();
}

class _AirtimeScreenState extends State<AirtimeScreen> {
  final _formKey = GlobalKey<FormState>();
  final _phoneCtrl = TextEditingController();
  final _amountCtrl = TextEditingController();

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    final amt = double.tryParse(_amountCtrl.text) ?? 0;
    if (amt > ZeusLimits.airtimePerTxn) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Per-transaction limit is ₦${ZeusLimits.airtimePerTxn.toInt()}')),
      );
      return;
    }
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Airtime purchase submitted.')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Buy Airtime')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _phoneCtrl,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(labelText: 'Phone Number'),
                validator: (v) => v!.length >= 10 ? null : 'Enter valid number',
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _amountCtrl,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Amount (NGN)'),
                validator: (v) => (double.tryParse(v ?? '') ?? 0) > 0 ? null : 'Enter amount',
              ),
              const SizedBox(height: 18),
              FilledButton(onPressed: _submit, child: const Text('Buy Airtime')),
            ],
          ),
        ),
      ),
    );
  }
}
