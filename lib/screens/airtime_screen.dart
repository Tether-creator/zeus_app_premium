import 'package:flutter/material.dart';
class AirtimeScreen extends StatelessWidget {
  const AirtimeScreen({super.key});
  static const route = '/airtime';
  @override
  Widget build(BuildContext context) => Scaffold(appBar: AppBar(title: const Text('Airtime')), body: const Center(child: Text('Buy Airtime')));
}
