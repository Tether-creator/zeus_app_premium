import 'package:flutter/material.dart';
class AccountOpeningScreen extends StatelessWidget {
  const AccountOpeningScreen({super.key});
  static const route = '/account-open';
  @override
  Widget build(BuildContext context) => Scaffold(appBar: AppBar(title: const Text('Open Account')), body: const Center(child: Text('BVN • NIN • KYC • Face ID')));
}
