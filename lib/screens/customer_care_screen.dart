import 'package:flutter/material.dart';

class CustomerCareScreen extends StatelessWidget {
  static const route = '/customer-care';
  const CustomerCareScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Customer Care')),
    body: const Center(
      child: Padding(
        padding: EdgeInsets.all(24),
        child: Text('24/7 Support • Email: support@zeus.app • Phone: +234-800-ZEUS-CARE'),
      ),
    ),
  );
}
