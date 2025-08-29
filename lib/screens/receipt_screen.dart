import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:printing/printing.dart';
import 'package:share_plus/share_plus.dart';
import '../receipt_pdf.dart';

class ReceiptScreen extends StatefulWidget {
  static const route = '/receipt';
  const ReceiptScreen({super.key});

  @override
  State<ReceiptScreen> createState() => _ReceiptScreenState();
}

class _ReceiptScreenState extends State<ReceiptScreen> {
  late final DateTime _now;
  late final String _txn;

  @override
  void initState() {
    super.initState();
    _now = DateTime.now();
    _txn = 'ZEUS-${_now.millisecondsSinceEpoch}';
  }

  Future<void> _download() async {
    final bytes = await buildReceiptPdf(
      txnId: _txn,
      title: 'Transaction Successful!',
      amountDisplay: 'Demo Amount',
      currency: 'NGN',
      senderName: 'ZEUS USER',
      recipientName: 'Demo Recipient',
      timestamp: _now,
      logoAssetPath: 'assets/images/zeus_logo.png',
    );
    final filename = 'zeus_receipt_${DateFormat('yyyyMMdd_HHmmss').format(_now)}.pdf';

    if (kIsWeb) {
      await Printing.sharePdf(bytes: bytes, filename: filename);
    } else {
      await Share.shareXFiles([XFile.fromData(bytes, name: filename, mimeType: 'application/pdf')], text: 'ZEUS Receipt');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Transaction Receipt')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            Image.asset('assets/images/zeus_logo.png', width: 96),
            const SizedBox(height: 18),
            const Text('Transaction Successful!', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 6),
            Text('ID: ZEUS'),
            const SizedBox(height: 16),
            FilledButton(onPressed: _download, child: Text(kIsWeb ? 'Download / Share PDF' : 'Share PDF')),
          ]),
        ),
      ),
    );
  }
}
