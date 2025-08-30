import 'package:flutter/material.dart';
class ConvertScreen extends StatelessWidget {
  const ConvertScreen({super.key});
  static const route = '/convert';
  @override
  Widget build(BuildContext context) => Scaffold(appBar: AppBar(title: const Text('Convert')), body: const Center(child: Text('FX Convert')));
}
