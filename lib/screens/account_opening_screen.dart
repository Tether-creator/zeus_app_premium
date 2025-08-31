import 'package:flutter/material.dart';
import '../ui.dart';

class AccountOpeningScreen extends StatefulWidget {
  static const route = '/open-account';
  const AccountOpeningScreen({super.key});
  @override
  State<AccountOpeningScreen> createState() => _AccountOpeningScreenState();
}

class _AccountOpeningScreenState extends State<AccountOpeningScreen> {
  final form = GlobalKey<FormState>();
  final bvn = TextEditingController();
  final nin = TextEditingController();
  final address = TextEditingController();
  final names = TextEditingController();
  final phone = TextEditingController();
  final email = TextEditingController();
  final dob = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Open Account')),
      body: Form(
        key: form,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            TextFormField(controller: bvn, decoration: const InputDecoration(labelText: 'BVN (11 digits)'),
              maxLength: 11, keyboardType: TextInputType.number,
              validator: (v)=> v!=null && v.length==11 ? null : 'Enter valid BVN'),
            TextFormField(controller: nin, decoration: const InputDecoration(labelText: 'NIN'),
              keyboardType: TextInputType.text, validator: (v)=> (v??'').length>=8?null:'Enter valid NIN'),
            TextFormField(controller: names, decoration: const InputDecoration(labelText: 'Full Names (match BVN)'),
              validator: (v)=> (v??'').split(' ').length>=2?null:'Enter full names'),
            TextFormField(controller: address, decoration: const InputDecoration(labelText: 'Address'),
              validator: (v)=> (v??'').length>=6?null:'Enter address'),
            TextFormField(controller: phone, decoration: const InputDecoration(labelText: 'Phone'),
              keyboardType: TextInputType.phone, validator: (v)=> (v??'').length>=11?null:'Enter phone'),
            TextFormField(controller: email, decoration: const InputDecoration(labelText: 'Email'),
              keyboardType: TextInputType.emailAddress, validator: (v)=> (v??'').contains('@')?null:'Enter email'),
            TextFormField(controller: dob, decoration: const InputDecoration(labelText: 'Date of Birth (YYYY-MM-DD)'),
              validator: (v)=> (v??'').contains('-')?null:'Enter DOB'),
            gap(10),
            ElevatedButton(
              onPressed: (){
                if(form.currentState!.validate()){
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Submitted for verification (BVN facial match to be integrated).')),
                  );
                }
              },
              child: const Text('Submit'),
            )
          ],
        ),
      ),
    );
  }
}
