import 'package:flutter/material.dart';
import '../state/app_state.dart';
import '../utils/format.dart';

class DataScreen extends StatefulWidget {
  const DataScreen({super.key});
  static const route = '/data';
  @override
  State<DataScreen> createState() => _DataScreenState();
}

class _DataScreenState extends State<DataScreen> {
  String _provider = 'MTN';
  String _plan = '1.5GB';
  final Map<String,double> _price = {
    '500MB': 300, '1.5GB': 1000, '3GB': 1500, '10GB': 3500,
  };

  @override
  Widget build(BuildContext context) {
    final s = AppState.instance;

    void _buy() {
      final amount = _price[_plan]!;
      if (!s.canData(amount)) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Data limit: ₦20,000 per txn / ₦100,000 daily'),
        ));
        return;
      }
      s.debitNGN(amount, type: 'data', title: '$_provider $_plan', channel: 'Data');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Data successful • ${money('NGN', amount)}')),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Data Purchase')),
      body: ListView(
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
          DropdownButtonFormField<String>(
            value: _plan,
            decoration: const InputDecoration(labelText: 'Plan'),
            items: _price.keys.map((p)=>DropdownMenuItem(value:p, child: Text('$p • ${money('NGN', _price[p]!)}'))).toList(),
            onChanged: (v)=>setState(()=>_plan=v!),
          ),
          const SizedBox(height: 18),
          FilledButton.icon(onPressed: _buy, icon: const Icon(Icons.check), label: const Text('Buy')),
        ],
      ),
    );
  }
}

