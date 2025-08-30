import 'package:flutter/material.dart';
import '../utils/format.dart';
import 'receipt_screen.dart';

class TransactionsScreen extends StatelessWidget {
  const TransactionsScreen({super.key});
  static const route = '/transactions';

  @override
  Widget build(BuildContext context) {
    final txs = [
      {'ccy':'NGN', 'amt': -125000.0, 'to':'Chinedu Okeke', 'bank':'GTBank', 'ref':'ZEUS-TRX-0001'},
      {'ccy':'USD', 'amt': -230.75, 'to':'AWS', 'bank':'Card **** 2451', 'ref':'ZEUS-TRX-0002'},
      {'ccy':'EUR', 'amt': 450.0, 'to':'Fiverr Payout', 'bank':'SEPA', 'ref':'ZEUS-TRX-0003'},
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Transactions')),
      body: ListView.separated(
        itemBuilder: (_, i) {
          final t = txs[i];
          final ccy = t['ccy'] as String;
          final amt = t['amt'] as double;
          return ListTile(
            title: Text('${t['to']}  •  ${t['bank']}'),
            subtitle: Text('${t['ref']}'),
            trailing: Text(money(ccy, amt), style: TextStyle(color: amt < 0 ? Colors.redAccent : Colors.greenAccent)),
            onTap: () => Navigator.pushNamed(_, ReceiptScreen.route, arguments: t),
          );
        },
        separatorBuilder: (_, __) => const Divider(height: 1),
        itemCount: txs.length,
      ),
    );
  }
}
