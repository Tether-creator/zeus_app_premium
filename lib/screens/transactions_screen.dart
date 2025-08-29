import 'package:flutter/material.dart';
import '../ui.dart';
import '../state.dart';
import '../utils/format.dart';

class TransactionsScreen extends StatelessWidget {
  static const route = '/transactions';
  const TransactionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final h = AppState.i.history;

    return Scaffold(
      appBar: AppBar(title: const Text('Transactions')),
      bottomNavigationBar: const BottomNav(index: 1),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: h.length,
        itemBuilder: (c, i) {
          final t = h[i];
          return ZeusCard(
            child: ListTile(
              title: Text(t.title),
              subtitle: Text('${t.type} • ${t.time}'),
              trailing: Text(fmt(t.currency, t.amount), style: const TextStyle(fontWeight: FontWeight.w800)),
            ),
          );
        },
      ),
    );
  }
}
