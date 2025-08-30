import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import '../utils/format.dart';

class ReceiptScreen extends StatelessWidget {
  const ReceiptScreen({super.key});
  static const route = '/receipt';

  Future<Uint8List> _buildPdf(Map data) async {
    final pdf = pw.Document();
    final ccy = data['ccy'] as String;
    final amt = data['amt'] as double;
    pdf.addPage(
      pw.Page(
        build: (c) => pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text('ZEUS Premium Receipt', style: pw.TextStyle(fontSize: 20, fontWeight: pw.FontWeight.bold)),
            pw.SizedBox(height: 8),
            pw.Text('Reference: ${data['ref']}'),
            pw.Text('Beneficiary: ${data['to']}'),
            pw.Text('Channel: ${data['bank']}'),
            pw.SizedBox(height: 12),
            pw.Text('Amount: ${money(ccy, amt)}'),
            pw.SizedBox(height: 24),
            pw.Text('Thank you for using ZEUS.', style: const pw.TextStyle(fontSize: 12)),
          ],
        ),
      ),
    );
    return pdf.save();
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map? ?? {};
    return Scaffold(
      appBar: AppBar(title: const Text('Receipt')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(
              child: PdfPreview(
                build: (_) => _buildPdf(args),
                canChangePageFormat: false,
                canChangeOrientation: false,
                allowPrinting: true,
                allowSharing: true,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
