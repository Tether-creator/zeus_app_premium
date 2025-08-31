import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../state/app_state.dart';
import 'receipt_screen.dart';

class SendScreen extends StatefulWidget {
  const SendScreen({super.key, required this.state});
  final AppState state;
  static const route = '/send';

  @override
  State<SendScreen> createState() => _SendScreenState();
}

class _SendScreenState extends State<SendScreen> {
  final _form = GlobalKey<FormState>();
  final _acct = TextEditingController();
  final _amount = TextEditingController();
  String? _bankCode;
  String? _accountName;

  final _fmt = NumberFormat.currency(locale: 'en_NG', symbol: '₦');

  @override
  void initState() {
    super.initState();
    widget.state.loadBanks();
  }

  Future<void> _resolve() async {
    if (_acct.text.length >= 10 && _bankCode != null) {
      final name = await widget.state.resolveAccountName(_acct.text, _bankCode!);
      setState(() => _accountName = name);
    }
  }

  Future<void> _submit() async {
    if (!_form.currentState!.validate()) return;

    final amt = double.parse(_amount.text.replaceAll(',', ''));
    if (amt > AppState.transferPerTxnNgn) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Per-transaction limit is ${_fmt.format(AppState.transferPerTxnNgn)}')),
      );
      return;
    }

    final ok = widget.state.debit('NGN', amt);
    if (!ok) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Insufficient balance')));
      return;
    }

    if (!mounted) return;
    Navigator.of(context).push(MaterialPageRoute(
      builder: (_) => ReceiptScreen(state: widget.state, receipt: ReceiptData(
        title: 'Bank Transfer',
        amount: amt,
        currency: 'NGN',
        beneficiary: _accountName ?? 'Unknown',
        account: _acct.text,
        bank: widget.state.banks.firstWhere((b) => b['code'] == _bankCode!)['name']!,
      )),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Send Money')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _form,
          child: Column(
            children: [
              TextFormField(
                controller: _acct,
                decoration: const InputDecoration(labelText: 'Account number', border: OutlineInputBorder()),
                keyboardType: TextInputType.number,
                onChanged: (_) => _resolve(),
                validator: (v) => (v == null || v.length < 10) ? 'Enter a valid account' : null,
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<String>(
                value: _bankCode,
                items: widget.state.banks
                    .map((b) => DropdownMenuItem(value: b['code'], child: Text(b['name']!)))
                    .toList(),
                onChanged: (v) { setState(() => _bankCode = v); _resolve(); },
                decoration: const InputDecoration(labelText: 'Bank', border: OutlineInputBorder()),
                validator: (v) => v == null ? 'Select bank' : null,
              ),
              const SizedBox(height: 8),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(_accountName == null ? '—' : 'Name: $_accountName'),
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _amount,
                decoration: const InputDecoration(labelText: 'Amount (NGN)', border: OutlineInputBorder()),
                keyboardType: TextInputType.number,
                validator: (v) => (v == null || double.tryParse(v.replaceAll(',', '')) == null) ? 'Enter amount' : null,
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                child: FilledButton.icon(onPressed: _submit, icon: const Icon(Icons.check), label: const Text('Send')),
              )
            ],
          ),
        ),
      ),
    );
  }
}
