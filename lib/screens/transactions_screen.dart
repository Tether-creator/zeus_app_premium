import 'package:flutter/material.dart';
import '../theme.dart';

class TransactionsScreen extends StatelessWidget {
  static const route = '/transactions';
  const TransactionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final items = _demoTransactions();
    return Scaffold(
      appBar: AppBar(title: const Text('Transactions')),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemBuilder: (_, i) {
          final tx = items[i];
          final color = tx['amount'].toString().startsWith('-')
              ? ZeusColors.error
              : ZeusColors.success;
          return Card(
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: ZeusColors.divider,
                child: const Icon(Icons.account_circle, color: ZeusColors.onSurface),
              ),
              title: Text(tx['name'], style: const TextStyle(fontWeight: FontWeight.w600)),
              subtitle: Text('${tx['currency']} • ${tx['time']}'),
              trailing: Text(
                tx['amount'],
                style: TextStyle(
                  color: color,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          );
        },
        separatorBuilder: (_, __) => const SizedBox(height: 10),
        itemCount: items.length,
      ),
    );
  }

  List<Map<String, String>> _demoTransactions() => [
        {'name': 'David Ogie Musa', 'currency': 'NGN', 'time': 'Today • 09:40', 'amount': '-₦35,000.00'},
        {'name': 'Jude Ojodomo Benjamin', 'currency': 'USD', 'time': 'Today • 08:10', 'amount': '-$120.00'},
        {'name': 'Queen Ajuruchi Benjamin', 'currency': 'EUR', 'time': 'Yesterday', 'amount': '+€4,100.00'},
        {'name': 'Eunice Oyine Godwin', 'currency': 'GBP', 'time': 'Yesterday', 'amount': '-£250.00'},
        {'name': 'Precious Chinenye Ndukwe', 'currency': 'GHC', 'time': '2d ago', 'amount': '+GHC 12,500.00'},
        {'name': 'Juliet Chinaza Ogaraku', 'currency': 'KSH', 'time': '2d ago', 'amount': '-KSh 33,000.00'},
        {'name': 'Gloria Ebube Nworah', 'currency': 'NGN', 'time': '3d ago', 'amount': '+₦500,000.00'},
        {'name': 'Kelvin Onyemaechi Abugu', 'currency': 'USD', 'time': '3d ago', 'amount': '-$75.00'},
        {'name': 'Abel Mairiga Biya', 'currency': 'EUR', 'time': '4d ago', 'amount': '+€820.00'},
        {'name': 'Buhari Abubakar Zakariyya', 'currency': 'GBP', 'time': '4d ago', 'amount': '-£90.00'},
      ];
}
