import 'package:flutter/material.dart';

class AccountOpeningScreen extends StatefulWidget {
  static const route = '/account-opening';
  const AccountOpeningScreen({super.key});

  @override
  State<AccountOpeningScreen> createState() => _AccountOpeningScreenState();
}

class _AccountOpeningScreenState extends State<AccountOpeningScreen> {
  final _formKey = GlobalKey<FormState>();
  final _bvnCtrl = TextEditingController();
  final _ninCtrl = TextEditingController();
  final _nameCtrl = TextEditingController();
  final _dobCtrl = TextEditingController();
  final _addressCtrl = TextEditingController();
  final _phoneCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();

  bool _selfieUploaded = false;

  void _submit() {
    if (!_formKey.currentState!.validate() || !_selfieUploaded) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("All fields & selfie required")),
      );
      return;
    }
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Account opening request submitted (mocked).")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Open Account')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(controller: _bvnCtrl, decoration: const InputDecoration(labelText: 'BVN'), validator: (v) => v!.length == 11 ? null : 'Enter valid BVN'),
              TextFormField(controller: _ninCtrl, decoration: const InputDecoration(labelText: 'NIN'), validator: (v) => v!.isNotEmpty ? null : 'Enter valid NIN'),
              TextFormField(controller: _nameCtrl, decoration: const InputDecoration(labelText: 'Full Name'), validator: (v) => v!.isNotEmpty ? null : 'Required'),
              TextFormField(controller: _dobCtrl, decoration: const InputDecoration(labelText: 'Date of Birth (YYYY-MM-DD)'), validator: (v) => v!.isNotEmpty ? null : 'Required'),
              TextFormField(controller: _addressCtrl, decoration: const InputDecoration(labelText: 'Address'), validator: (v) => v!.isNotEmpty ? null : 'Required'),
              TextFormField(controller: _phoneCtrl, decoration: const InputDecoration(labelText: 'Phone Number'), validator: (v) => v!.length >= 10 ? null : 'Enter valid phone'),
              TextFormField(controller: _emailCtrl, decoration: const InputDecoration(labelText: 'Email Address'), validator: (v) => v!.contains('@') ? null : 'Enter valid email'),
              const SizedBox(height: 12),
              ElevatedButton(
                onPressed: () => setState(() => _selfieUploaded = true),
                child: Text(_selfieUploaded ? '✅ Selfie Uploaded' : 'Upload Selfie (Mock)'),
              ),
              const SizedBox(height: 20),
              FilledButton(onPressed: _submit, child: const Text("Submit")),
            ],
          ),
        ),
      ),
    );
  }
}
