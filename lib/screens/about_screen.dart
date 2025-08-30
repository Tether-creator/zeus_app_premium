import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  static const route = '/about';
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("About ZEUS")),
      body: const Padding(
        padding: EdgeInsets.all(16),
        child: Text(
          "ZEUS Premium Banking App\n\n"
          "A modern digital bank with transfers, airtime, data, bill payments, "
          "conversion, and Nigerian-specific banking integrations.\n\n"
          "This build is investor-ready for demo purposes.",
        ),
      ),
    );
  }
}
