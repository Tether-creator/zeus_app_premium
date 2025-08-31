import 'dart:typed_data';
import 'package:intl/intl.dart';
import 'package:pdf/widgets.dart' as pw;

Future<Uint8List> buildReceiptPdf({
  required String type,
  required String amount,
  required String currency,
  String? name,
  String? bank,
  String? account,
}) async {
  final doc = pw.Document();
  final now = DateFormat('yyyy-MM-dd – HH:mm').format(DateTime.now());

  doc.addPage(
    pw.Page(
      build: (ctx) => pw.Container(
        padding: const pw.EdgeInsets.all(24),
        child: pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text('ZEUS Premium', style: pw.TextStyle(fontSize: 22, fontWeight: pw.FontWeight.bold)),
            pw.SizedBox(height: 8),
            pw.Text('Payment Receipt', style: const pw.TextStyle(fontSize: 16)),
            pw.SizedBox(height: 16),
            _row('Type', type),
            _row('Beneficiary', name ?? '-'),
            _row('Bank', bank ?? '-'),
            _row('Account', account ?? '-'),
            _row('Amount', '$currency $amount'),
            _row('Date', now),
            pw.SizedBox(height: 24),
            pw.Text('Thank you for choosing ZEUS.', style: const pw.TextStyle(fontSize: 12)),
          ],
        ),
      ),
    ),
  );

  return doc.save();
}

pw.Widget _row(String k, String v) => pw.Padding(
  padding: const pw.EdgeInsets.symmetric(vertical: 4),
  child: pw.Row(
    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
    children: [pw.Text(k), pw.Text(v, style: const pw.TextStyle(fontWeight: pw.FontWeight.bold))],
  ),
);
