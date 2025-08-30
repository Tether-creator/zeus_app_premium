import 'package:flutter/material.dart';
import '../state/app_state.dart';
import '../utils/format.dart';

class AirtimeScreen extends StatefulWidget {
  const AirtimeScreen({super.key});
  static const route = '/airtime';
  @override
  State<AirtimeScreen> createState() => _AirtimeScreenState();
}

class _AirtimeScreenState extends State<AirtimeScreen> {
  final _form = GlobalKey<FormState>();
  String _provider = 'MTN';
  final _phoneCtrl = TextEditingController();
  final _amtCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final s = AppState.instance;

    void _buy() {
      if (!_form.currentState!.validate()) return;
      final amount = double.parse(_amtCtrl.text);
      if (!s.canAirtime(amount)) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Airtime limit: ₦20,000 per txn / ₦100,000 daily'),
        ));
        return;
      }
      s.debitNGN(amount, type: 'airtime', title: '$_provider ${_phoneCtrl.text}', channel: 'Airtime');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Airtime successful • ${money('NGN', amount)}')),
      );
      _amtCtrl.clear();
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Airtime Purchase')),
      body: Form(
        key: _form,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            DropdownButtonFormField<String>(
              value: _provider,
              decoration: const InputDecoration(labelText: 'Provider'),
              items: const ['MTN','Airtel','Glo','9mobile']
                .map((p)=>DropdownMenuItem(value:p, child: Text(p))).toList(),
              onChanged: (v)=>setState(()=>_provider=v!),
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _phoneCtrl,
              decoration: const InputDecoration(labelText: 'Phone Number'),
              keyboardType: TextInputType.phone,
              validator: (v)=> (v==null || v.length<10) ? 'Enter valid number' : null,
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _amtCtrl,
              decoration: const InputDecoration(labelText: 'Amount (NGN)'),
              keyboardType: TextInputType.number,
              validator: (v)=> double.tryParse(v??'')==null ? 'Enter amount' : null,
            ),
            const SizedBox(height: 18),
            FilledButton.icon(onPressed: _buy, icon: const Icon(Icons.check), label: const Text('Buy')),
          ],
        ),
      ),
    );
  }
}
