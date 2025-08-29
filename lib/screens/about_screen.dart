// lib/screens/about_screen.dart
import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  static const route = '/about';
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('About ZEUS')),
    body: const Center(child: Text('ZEUS Premium Banking\nDemo Build', textAlign: TextAlign.center)),
  );
}
