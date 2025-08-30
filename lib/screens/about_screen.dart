import 'package:flutter/material.dart';
class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});
  static const route = '/about';
  @override
  Widget build(BuildContext context) => Scaffold(appBar: AppBar(title: const Text('About ZEUS')), body: const Center(child: Text('Version 1.0.0')));
}
