import 'package:flutter/material.dart';
class AddMoneyScreen extends StatelessWidget {
  const AddMoneyScreen({super.key});
  static const route = '/add-money';
  @override
  Widget build(BuildContext context) => Scaffold(appBar: AppBar(title: const Text('Add Money')), body: const Center(child: Text('Card / Transfer / Cash')));
}
