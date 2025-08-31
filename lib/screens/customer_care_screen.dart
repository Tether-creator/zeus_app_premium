import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../ui.dart';

class CustomerCareScreen extends StatelessWidget {
  static const route = '/support';
  const CustomerCareScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const SectionTitle('Contact ZEUS'),
        ZeusCard(child: ListTile(
          leading: const Icon(Icons.email),
          title: const Text('support@zeus.app'),
          onTap: () => launchUrl(Uri.parse('mailto:support@zeus.app')),
        )),
        ZeusCard(child: ListTile(
          leading: const Icon(Icons.call),
          title: const Text('+234 800 000 0000'),
          onTap: () => launchUrl(Uri.parse('tel:+2348000000000')),
        )),
        ZeusCard(child: ListTile(
          leading: const Icon(Icons.chat),
          title: const Text('Live Chat'),
          onTap: () => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Chat coming soon'))),
        )),
      ],
    );
  }
}
