import 'package:flutter/material.dart';

class AddMoneyScreen extends StatefulWidget {
  static const route = '/add-money';
  const AddMoneyScreen({super.key});

  @override
  State<AddMoneyScreen> createState() => _AddMoneyScreenState();
}

class _AddMoneyScreenState extends State<AddMoneyScreen> {
  final _formKey = GlobalKey<FormState>();
  final _amountCtrl = TextEditingController();
  String _method = 'Bank Card';

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Add money via $_method submitted (mocked).')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Money')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              DropdownButtonFormField<String>(
                value: _method,
                items: const ['Bank Card (OTP)', 'Bank Transfer', 'Cash Deposit']
                    .map((m) => DropdownMenuItem(value: m, child: Text(m)))
                    .toList(),
                onChanged: (v) => setState(() => _method = v!),
                decoration: const InputDecoration(labelText: 'Funding Method'),
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _amountCtrl,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Amount (NGN)'),
                validator: (v) => (double.tryParse(v ?? '') ?? 0) > 0 ? null : 'Enter amount',
              ),
              const SizedBox(height: 18),
              FilledButton(onPressed: _submit, child: const Text('Add Now')),
            ],
          ),
        ),
      ),
    );
  }
}
