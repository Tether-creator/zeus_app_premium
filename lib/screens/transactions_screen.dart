import 'package:flutter/material.dart';
import '../state/app_state.dart';
import '../utils/format.dart';
import 'receipt_screen.dart';

class TransactionsScreen extends StatelessWidget {
  const TransactionsScreen({super.key});
  static const route = '/transactions';

  @override
  Widget build(BuildContext context) {
    final txs = AppState.instance.transactions;
    return Scaffold(
      appBar: AppBar(title: const Text('Transactions')),
      body: txs.isEmpty
          ? const Center(child: Text('No transactions yet'))
          : ListView.separated(
              itemCount: txs.length,
              separatorBuilder: (_, __) => const Divider(height: 1),
              itemBuilder: (_, i) {
                final t = txs[i];
                final color = t.amount < 0 ? Colors.redAccent : Colors.greenAccent;
                return ListTile(
                  title: Text(t.title),
                  subtitle: Text('${t.channel}  •  ${t.ref}'),
                  trailing: Text(money(t.ccy, t.amount), style: TextStyle(color: color)),
                  onTap: () => Navigator.pushNamed(_, ReceiptScreen.route, arguments: {
                    'ccy': t.ccy,
                    'amt': t.amount,
                    'to': t.title,
                    'bank': t.channel,
                    'ref': t.ref,
                  }),
                );
              },
            ),
    );
  }
}
