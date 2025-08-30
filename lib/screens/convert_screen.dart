import 'package:flutter/material.dart';

class ConvertScreen extends StatefulWidget {
  static const route = '/convert';
  const ConvertScreen({super.key});

  @override
  State<ConvertScreen> createState() => _ConvertScreenState();
}

class _ConvertScreenState extends State<ConvertScreen> {
  final _formKey = GlobalKey<FormState>();
  final _fromCtrl = TextEditingController();
  final _toCtrl = TextEditingController();
  String _fromCurrency = 'NGN';
  String _toCurrency = 'USD';

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Conversion submitted (mocked).')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Convert Currency')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              DropdownButtonFormField<String>(
                value: _fromCurrency,
                items: const ['NGN', 'USD', 'EUR', 'GBP', 'GHC', 'KSH']
                    .map((c) => DropdownMenuItem(value: c, child: Text(c)))
                    .toList(),
                onChanged: (v) => setState(() => _fromCurrency = v!),
                decoration: const InputDecoration(labelText: 'From'),
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<String>(
                value: _toCurrency,
                items: const ['NGN', 'USD', 'EUR', 'GBP', 'GHC', 'KSH']
                    .map((c) => DropdownMenuItem(value: c, child: Text(c)))
                    .toList(),
                onChanged: (v) => setState(() => _toCurrency = v!),
                decoration: const InputDecoration(labelText: 'To'),
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _fromCtrl,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Amount'),
                validator: (v) => (double.tryParse(v ?? '') ?? 0) > 0 ? null : 'Enter amount',
              ),
              const SizedBox(height: 18),
              FilledButton(onPressed: _submit, child: const Text('Convert')),
            ],
          ),
        ),
      ),
    );
  }
}
