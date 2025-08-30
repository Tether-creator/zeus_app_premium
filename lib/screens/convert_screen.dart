import 'package:flutter/material.dart';
import '../state/app_state.dart';

class ConvertScreen extends StatefulWidget {
  const ConvertScreen({super.key});
  static const route = '/convert';
  @override
  State<ConvertScreen> createState() => _ConvertScreenState();
}

class _ConvertScreenState extends State<ConvertScreen> {
  String _from = 'NGN';
  String _to = 'USD';
  final _amtCtrl = TextEditingController();
  final Map<String,double> rate = { 'NGNUSD': 1/1500, 'USDNGN': 1500, 'NGNEUR': 1/1650, 'EURNGN': 1650, 'USDEUR': 0.9, 'EURUSD': 1.11 };

  @override
  Widget build(BuildContext context) {
    final s = AppState.instance;

    void _convert() {
      final a = double.tryParse(_amtCtrl.text);
      if (a == null || a <= 0) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Enter amount')));
        return;
      }
      final r = rate['$_from$_to'] ?? 1;
      s.convert(from: _from, to: _to, amount: a, rate: r);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Conversion done')));
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Convert Funds')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Row(children: [
            Expanded(child: _ccyDrop(_from, (v)=>setState(()=>_from=v!))),
            const Padding(padding: EdgeInsets.symmetric(horizontal: 8), child: Icon(Icons.swap_horiz)),
            Expanded(child: _ccyDrop(_to, (v)=>setState(()=>_to=v!))),
          ]),
          const SizedBox(height: 12),
          TextField(
            controller: _amtCtrl,
            decoration: const InputDecoration(labelText: 'Amount'),
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 18),
          FilledButton.icon(onPressed: _convert, icon: const Icon(Icons.check), label: const Text('Convert')),
        ],
      ),
    );
  }

  Widget _ccyDrop(String value, ValueChanged<String?> onChanged) {
    return DropdownButtonFormField<String>(
      value: value,
      items: const ['NGN','USD','EUR'].map((c)=>DropdownMenuItem(value: c, child: Text(c))).toList(),
      onChanged: onChanged,
      decoration: const InputDecoration(labelText: 'Currency'),
    );
  }
}
