import 'package:flutter/material.dart';

class CustomerCareScreen extends StatelessWidget {
  static const route = '/customer-care';
  const CustomerCareScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Customer Care")),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          Text("📞 Hotline: +234-800-ZEUS-HELP"),
          SizedBox(height: 12),
          Text("✉️ Email: support@zeusbank.ng"),
          SizedBox(height: 12),
          Text("💬 Live Chat (Mocked in app)"),
        ],
      ),
    );
  }
}
