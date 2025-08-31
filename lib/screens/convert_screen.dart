import 'package:flutter/material.dart';
import '../state/app_state.dart';

class ConvertScreen extends StatefulWidget {
  const ConvertScreen({super.key, required this.state});
  final AppState state;
  static const route = '/convert';

  @override
  State<ConvertScreen> createState() => _ConvertScreenState();
}

class _ConvertScreenState extends State<ConvertScreen> {
  String from = 'NGN';
  String to = 'USD';
  final _amount = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final currencies = const ['NGN', 'USD', 'EUR', 'KES'];

    return Scaffold(
      appBar: AppBar(title: const Text('Convert Balance')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            DropdownButtonFormField(value: from, items: currencies.map((c)=>DropdownMenuItem(value:c, child: Text(c))).toList(),
              onChanged: (v)=>setState(()=>from=v!), decoration: const InputDecoration(labelText: 'From', border: OutlineInputBorder())),
            const SizedBox(height: 12),
            DropdownButtonFormField(value: to, items: currencies.map((c)=>DropdownMenuItem(value:c, child: Text(c))).toList(),
              onChanged: (v)=>setState(()=>to=v!), decoration: const InputDecoration(labelText: 'To', border: OutlineInputBorder())),
            const SizedBox(height: 12),
            TextField(controller: _amount, decoration: const InputDecoration(labelText: 'Amount', border: OutlineInputBorder()), keyboardType: TextInputType.number),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: () {
                  final v = double.tryParse(_amount.text) ?? 0;
                  final ok = widget.state.convert(from, to, v);
                  final msg = ok ? 'Converted $v $from → $to' : 'Conversion failed';
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
                },
                child: const Text('Convert'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
