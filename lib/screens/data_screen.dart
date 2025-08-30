import 'package:flutter/material.dart';
class DataScreen extends StatelessWidget {
  const DataScreen({super.key});
  static const route = '/data';
  @override
  Widget build(BuildContext context) => Scaffold(appBar: AppBar(title: const Text('Data')), body: const Center(child: Text('Buy Data')));
}
