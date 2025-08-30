import 'package:flutter/material.dart';
class BillsScreen extends StatelessWidget {
  const BillsScreen({super.key});
  static const route = '/bills';
  @override
  Widget build(BuildContext context) => Scaffold(appBar: AppBar(title: const Text('Bills')), body: const Center(child: Text('Pay Bills')));
}
