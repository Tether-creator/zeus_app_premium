import 'package:flutter/material.dart';
import '../data/nigeria_banks.dart';
import '../services/account_lookup.dart';
import '../state/app_state.dart';
import '../utils/format.dart';
import 'receipt_screen.dart';

class SendScreen extends StatefulWidget {
  const SendScreen({super.key});
  static const route = '/send';

  @override
  State<SendScreen> createState() => _SendScreenState();
}

class _SendScreenState extends State<SendScreen> {
  final _form = GlobalKey<FormState>();
  final _acctCtrl = TextEditingController();
  final _amtCtrl = TextEditingController();
  NigeriaBank? _bank;
  String? _name;

  @override
  Widget build(BuildContext context) {
    final s = AppState.instance;

    Future<void> _resolve() async {
      final b = _bank;
      if (b == null) return;
      setState(() => _name = resolveAccountName(_acctCtrl.text, b));
    }

    void _submit() {
      if (!_form.currentState!.validate()) return;
      final amount = double.parse(_amtCtrl.text);
      if (!s.canTransfer(amount)) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Limit exceeded: ₦2,000,000 per transaction / ₦100,000,000 daily')),
        );
        return;
      }
      s.debitNGN(amount, type: 'transfer', title: _name ?? 'Unknown', channel: _bank!.name);
      Navigator.pushNamed(context, ReceiptScreen.route, arguments: {
        'ccy': 'NGN',
        'amt': -amount,
        'to': _name ?? 'Unknown',
        'bank': _bank!.name,
        'ref': 'ZEUS',
      });
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Send Money')),
      body: Form(
        key: _form,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            DropdownButtonFormField<NigeriaBank>(
              decoration: const InputDecoration(labelText: 'Bank'),
              items: nigeriaBanks.map((b) =>
                DropdownMenuItem(value: b, child: Text(b.name))).toList(),
              onChanged: (b) { setState(() => _bank = b); _resolve(); },
              validator: (v) => v == null ? 'Select bank' : null,
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _acctCtrl,
              decoration: const InputDecoration(labelText: 'Account Number (10 digits)'),
              keyboardType: TextInputType.number,
              onChanged: (_) => _resolve(),
              validator: (v) => (v==null || v.length!=10) ? 'Enter 10-digit account' : null,
            ),
            const SizedBox(height: 8),
            if (_name != null)
              Row(children: [
                const Icon(Icons.verified, color: Colors.lightGreen),
                const SizedBox(width: 6),
                Text('Account Name: $_name'),
              ]),
            const SizedBox(height: 16),
            TextFormField(
              controller: _amtCtrl,
              decoration: const InputDecoration(labelText: 'Amount (NGN)'),
              keyboardType: TextInputType.number,
              validator: (v) {
                final a = double.tryParse(v ?? '');
                if (a == null || a <= 0) return 'Enter amount';
                return null;
              },
            ),
            const SizedBox(height: 18),
            FilledButton.icon(
              onPressed: _submit,
              icon: const Icon(Icons.lock),
              label: Text('Send • ${money('NGN', double.tryParse(_amtCtrl.text) ?? 0)}'),
            ),
          ],
        ),
      ),
    );
  }
}
