import 'package:flutter/material.dart';
import '../ui.dart';

class SettingsScreen extends StatelessWidget {
  static const route = '/settings';
  const SettingsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        children: [
          ZeusCard(child: SwitchListTile(
            title: const Text('Biometrics (Face/Touch ID)'),
            value: true,
            onChanged: (_) {},
          )),
          ZeusCard(child: ListTile(
            title: const Text('Cards'),
            subtitle: const Text('Manage virtual & physical cards'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {},
          )),
        ],
      ),
    );
  }
}
