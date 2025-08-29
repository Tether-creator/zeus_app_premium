import 'package:flutter/material.dart';
import '../ui.dart';

class AccountOpeningScreen extends StatefulWidget {
  static const route = '/open-account';
  const AccountOpeningScreen({super.key});

  @override
  State<AccountOpeningScreen> createState() => _AccountOpeningScreenState();
}

class _AccountOpeningScreenState extends State<AccountOpeningScreen> {
  final _form = GlobalKey<FormState>();
  final bvn = TextEditingController();
  final nin = TextEditingController();
  final address = TextEditingController();
  final fullname = TextEditingController();
  final phone = TextEditingController();
  final email = TextEditingController();
  DateTime? dob;
  bool selfieOk = false;

  String? _req(String? v) => (v == null || v.trim().isEmpty) ? 'Required' : null;

  void _pickDob() async {
    final now = DateTime.now();
    final d = await showDatePicker(context: context, firstDate: DateTime(now.year - 100), lastDate: now, initialDate: DateTime(now.year - 18));
    if (d != null) setState(() => dob = d);
  }

  void _submit() {
    if (!_form.currentState!.validate() || dob == null || !selfieOk) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Complete all KYC fields')));
      return;
    }
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Account created (demo)!')));
    Navigator.pop(context);
  }

  @override
  void dispose() { bvn.dispose(); nin.dispose(); address.dispose(); fullname.dispose(); phone.dispose(); email.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Open Account')),
    body: SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Form(
        key: _form,
        child: Column(children: [
          TextFormField(controller: fullname, decoration: const InputDecoration(labelText: 'Full name (match BVN)'), validator: _req),
          TextFormField(controller: email, decoration: const InputDecoration(labelText: 'Email'), validator: _req),
          TextFormField(controller: phone, decoration: const InputDecoration(labelText: 'Phone number'), validator: _req),
          TextFormField(controller: bvn, decoration: const InputDecoration(labelText: 'BVN (11 digits)'), maxLength: 11, keyboardType: TextInputType.number, validator: _req),
          TextFormField(controller: nin, decoration: const InputDecoration(labelText: 'NIN (11 digits)'), maxLength: 11, keyboardType: TextInputType.number, validator: _req),
          TextFormField(controller: address, decoration: const InputDecoration(labelText: 'Residential address'), validator: _req),
          const SizedBox(height: 8),
          ListTile(
            contentPadding: EdgeInsets.zero,
            title: Text(dob == null ? 'Date of Birth' : 'DOB: ${dob!.toLocal()}'),
            trailing: IconButton(icon: const Icon(Icons.cake), onPressed: _pickDob),
          ),
          SwitchListTile(
            value: selfieOk,
            onChanged: (v) => setState(() => selfieOk = v),
            title: const Text('Facial verification matches BVN (demo)'),
          ),
          const SizedBox(height: 16),
          PrimaryButton(text: 'Create Account', onPressed: _submit),
        ]),
      ),
    ),
  );
}
