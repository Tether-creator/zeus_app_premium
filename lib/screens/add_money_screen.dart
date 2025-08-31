import 'package:flutter/material.dart';
import '../state/app_state.dart';

class AddMoneyScreen extends StatefulWidget {
  const AddMoneyScreen({super.key, required this.state});
  final AppState state;
  static const route = '/add-money';

  @override
  State<AddMoneyScreen> createState() => _AddMoneyScreenState();
}

class _AddMoneyScreenState extends State<AddMoneyScreen> {
  final _form = GlobalKey<FormState>();
  final _amount = TextEditingController();
  final _card = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Money')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _form,
          child: Column(
            children: [
              TextFormField(controller: _amount, decoration: const InputDecoration(labelText: 'Amount (NGN)', border: OutlineInputBorder()),
                validator: (v)=> (v==null || double.tryParse(v)==null) ? 'Enter amount' : null),
              const SizedBox(height:12),
              TextFormField(controller: _card, decoration: const InputDecoration(labelText: 'Card (demo)', border: OutlineInputBorder()),
                validator: (v)=> (v==null || v.length<12) ? 'Enter card' : null),
              const Spacer(),
              SizedBox(width: double.infinity, child: FilledButton(
                onPressed: (){
                  if(!_form.currentState!.validate()) return;
                  final amt = double.parse(_amount.text);
                  widget.state.credit('NGN', amt);
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Money added (demo)')));
                  Navigator.pop(context);
                },
                child: const Text('Add'),
              )),
            ],
          ),
        ),
      ),
    );
  }
}
