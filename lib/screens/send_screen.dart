import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../theme.dart';
import '../services/bank_lookup.dart';
import '../services/limits.dart';

class SendScreen extends StatefulWidget {
  static const route = '/send';
  const SendScreen({super.key});

  @override
  State<SendScreen> createState() => _SendScreenState();
}

class _SendScreenState extends State<SendScreen> {
  final _formKey = GlobalKey<FormState>();
  final _acctCtrl = TextEditingController();
  final _nameCtrl = TextEditingController();
  final _amountCtrl = TextEditingController();
  String? _bank;
  bool _resolving = false;

  @override
  void dispose() {
    _acctCtrl.dispose();
    _nameCtrl.dispose();
    _amountCtrl.dispose();
    super.dispose();
  }

  Future<void> _resolve() async {
    if (_bank == null || _acctCtrl.text.length != 10) return;
    setState(() => _resolving = true);
    final name = await BankLookupService.resolveAccountName(
      bank: _bank!,
      accountNumber: _acctCtrl.text,
    );
    setState(() {
      _nameCtrl.text = name ?? '';
      _resolving = false;
    });
    if (name == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Could not resolve account name')),
      );
    }
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;

    final amt = double.tryParse(_amountCtrl.text.replaceAll(',', '')) ?? 0;
    // Enforce NGN limits for demo:
    if (amt > ZeusLimits.transferPerTxnNGN) {
      final nf = NumberFormat.decimalPattern();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Per-transaction limit is ₦${nf.format(ZeusLimits.transferPerTxnNGN)}')),
      );
      return;
    }

    // Success UI only — your balance mutation & receipt navigation come here.
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Transfer submitted.')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Send Money')),
      body: FutureBuilder<List<String>>(
        future: BankLookupService.listBanks(),
        builder: (context, snap) {
          final banks = snap.data ?? const <String>[];
          return Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: ListView(
                children: [
                  DropdownButtonFormField<String>(
                    decoration: const InputDecoration(labelText: 'Bank'),
                    items: banks.map((b) => DropdownMenuItem(value: b, child: Text(b))).toList(),
                    value: _bank,
                    onChanged: (v) => setState(() => _bank = v),
                    validator: (v) => v == null ? 'Select bank' : null,
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _acctCtrl,
                    keyboardType: TextInputType.number,
                    maxLength: 10,
                    decoration: InputDecoration(
                      labelText: 'Account number',
                      suffixIcon: IconButton(
                        icon: _resolving
                            ? const SizedBox(
                                height: 20, width: 20, child: CircularProgressIndicator(strokeWidth: 2))
                            : const Icon(Icons.search),
                        onPressed: _resolving ? null : _resolve,
                      ),
                    ),
                    onChanged: (_) {
                      if (_acctCtrl.text.length == 10) _resolve();
                    },
                    validator: (v) => (v?.length ?? 0) == 10 ? null : 'Enter 10-digit account',
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _nameCtrl,
                    readOnly: true,
                    decoration: const InputDecoration(labelText: 'Account name'),
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _amountCtrl,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(labelText: 'Amount (NGN)'),
                    validator: (v) => (double.tryParse(v ?? '') ?? 0) > 0 ? null : 'Enter amount',
                  ),
                  const SizedBox(height: 18),
                  FilledButton(onPressed: _submit, child: const Text('Send Now')),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
