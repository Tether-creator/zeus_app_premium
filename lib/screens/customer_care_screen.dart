import 'package:flutter/material.dart';
class CustomerCareScreen extends StatelessWidget {
  const CustomerCareScreen({super.key});
  static const route = '/customer-care';
  @override
  Widget build(BuildContext context) => Scaffold(appBar: AppBar(title: const Text('Customer Care')), body: const Center(child: Text('Chat / Call / FAQ')));
}
