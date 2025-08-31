import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:printing/printing.dart';
import 'package:pdf/widgets.dart' as pw;
import '../state/app_state.dart';

class ReceiptData {
  final String title;
  final double amount;
  final String currency;
  final String beneficiary;
  final String account;
  final String bank;
  ReceiptData({
    required this.title, required this.amount, required this.currency,
    required this.beneficiary, required this.account, required this.bank,
  });
}

class ReceiptScreen extends StatelessWidget {
  const ReceiptScreen({super.key, required this.state, this.receipt});
  final AppState state;
  final ReceiptData? receipt;

  static const route = '/receipt';

  @override
  Widget build(BuildContext context) {
    final fmt = NumberFormat.currency(
      locale: receipt?.currency == 'NGN' ? 'en_NG' : 'en_US',
      symbol: receipt?.currency == 'NGN' ? '₦' : r'$',
    );

    return Scaffold(
      appBar: AppBar(title: const Text('Receipt')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(receipt?.title ?? 'Transaction', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text('Beneficiary: ${receipt?.beneficiary ?? '-'}'),
            Text('Account: ${receipt?.account ?? '-'}'),
            Text('Bank: ${receipt?.bank ?? '-'}'),
            const SizedBox(height: 8),
            Text('Amount: ${fmt.format(receipt?.amount ?? 0)}', style: const TextStyle(fontWeight: FontWeight.w700)),
            const Spacer(),
            Row(
              children: [
                FilledButton.icon(
                  onPressed: () async {
                    await Printing.layoutPdf(onLayout: (format) async {
                      final doc = pw.Document();
                      doc.addPage(
                        pw.Page(
                          build: (ctx) => pw.Column(
                            crossAxisAlignment: pw.CrossAxisAlignment.start,
                            children: [
                              pw.Text('ZEUS Premium Receipt', style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold)),
                              pw.SizedBox(height: 8),
                              pw.Text('Title: ${receipt?.title}'),
                              pw.Text('Beneficiary: ${receipt?.beneficiary}'),
                              pw.Text('Account: ${receipt?.account}'),
                              pw.Text('Bank: ${receipt?.bank}'),
                              pw.Text('Amount: ${fmt.format(receipt?.amount ?? 0)}'),
                              pw.SizedBox(height: 16),
                              pw.Text('Thank you for using ZEUS'),
                            ],
                          ),
                        ),
                      );
                      return doc.save();
                    });
                  },
                  icon: const Icon(Icons.picture_as_pdf),
                  label: const Text('Download PDF'),
                ),
                const SizedBox(width: 12),
                OutlinedButton.icon(
                  onPressed: () => Printing.sharePdf(bytes: pw.Document().save(), filename: 'receipt.pdf'),
                  icon: const Icon(Icons.share),
                  label: const Text('Share'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
