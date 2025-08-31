import 'package:flutter/material.dart';
import '../ui.dart';

class AboutScreen extends StatelessWidget {
  static const route = '/about';
  const AboutScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('About ZEUS')),
      body: const ZeusCard(
        child: Text('ZEUS Premium — demo banking UI for investors & QA.'),
      ),
    );
  }
}
