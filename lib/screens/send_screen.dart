import 'package:flutter/material.dart';
class SendScreen extends StatelessWidget {
  const SendScreen({super.key});
  static const route = '/send';
  @override
  Widget build(BuildContext context) => Scaffold(appBar: AppBar(title: const Text('Send')), body: const Center(child: Text('Send flow')));
}
