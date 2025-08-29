import 'package:flutter/material.dart';

class ZeusCard extends StatelessWidget {
  final Widget child;
  final EdgeInsets padding;
  final EdgeInsets margin;
  const ZeusCard({super.key, required this.child, this.padding = const EdgeInsets.all(16), this.margin = const EdgeInsets.only(bottom: 12)});

  @override
  Widget build(BuildContext context) {
    return Card(margin: margin, child: Padding(padding: padding, child: child));
  }
}

class PrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  const PrimaryButton({super.key, required this.text, this.onPressed});
  @override
  Widget build(BuildContext context) => FilledButton(onPressed: onPressed, child: Text(text));
}

class WalletTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String trailing;
  final VoidCallback? onTap;
  const WalletTile({super.key, required this.icon, required this.title, required this.trailing, this.onTap});
  @override
  Widget build(BuildContext context) => ZeusCard(
        child: ListTile(
          leading: Icon(icon, color: Colors.white70),
          title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
          trailing: Text(trailing, style: const TextStyle(fontWeight: FontWeight.bold)),
          onTap: onTap,
        ),
      );
}

class BottomNav extends StatelessWidget {
  final int index;
  const BottomNav({super.key, required this.index});
  @override
  Widget build(BuildContext context) {
    void go(int i) {
      switch (i) {
        case 0:
          Navigator.pushNamedAndRemoveUntil(context, '/', (_) => false);
          break;
        case 1:
          Navigator.pushNamed(context, '/transactions');
          break;
        case 2:
          Navigator.pushNamed(context, '/settings');
          break;
      }
    }

    return NavigationBar(
      selectedIndex: index,
      onDestinationSelected: go,
      destinations: const [
        NavigationDestination(icon: Icon(Icons.home_outlined), selectedIcon: Icon(Icons.home), label: 'Home'),
        NavigationDestination(icon: Icon(Icons.receipt_long_outlined), selectedIcon: Icon(Icons.receipt_long), label: 'Transactions'),
        NavigationDestination(icon: Icon(Icons.settings_outlined), selectedIcon: Icon(Icons.settings), label: 'Settings'),
      ],
    );
  }
}
