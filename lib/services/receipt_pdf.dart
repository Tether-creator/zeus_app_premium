// lib/services/receipt_pdf.dart
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class ReceiptPdfService {
  /// Generates a PDF receipt, saves it in the app documents directory,
  /// and returns the absolute file path.
  static Future<String> generateAndSave({
    required Map<String, dynamic> data,
    String fileName = 'zeus_receipt',
  }) async {
    final doc = pw.Document();

    final receiptId = data['id'] ?? _nowIso();
    final amount = data['amount'] ?? '-';
    final currency = data['currency'] ?? '-';
    final to = data['to'] ?? '-';
    final from = data['from'] ?? '-';
    final status = data['status'] ?? 'SUCCESS';
    final date = data['date'] ?? _nowIso();

    doc.addPage(
      pw.Page(
        build: (context) {
          return pw.Padding(
            padding: const pw.EdgeInsets.all(24),
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text('ZEUS — Transaction Receipt', style: pw.TextStyle(fontSize: 20, fontWeight: pw.FontWeight.bold)),
                pw.SizedBox(height: 12),
                _kv('Receipt ID', receiptId.toString()),
                _kv('Status', status.toString()),
                _kv('Date', date.toString()),
                pw.Divider(),
                _kv('From', from.toString()),
                _kv('To', to.toString()),
                _kv('Amount', '$amount $currency'),
                pw.SizedBox(height: 20),
                pw.Text('Thank you for using ZEUS Premium.', style: const pw.TextStyle(fontSize: 12)),
              ],
            ),
          );
        },
      ),
    );

    final bytes = await doc.save();
    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/$fileName-${DateTime.now().millisecondsSinceEpoch}.pdf');
    await file.writeAsBytes(bytes, flush: true);

    if (kDebugMode) {
      // Quick preview when developing (no-op in release).
      await Printing.layoutPdf(onLayout: (_) async => bytes);
    }

    return file.path;
  }

  /// Opens the platform share sheet for the last generated PDF bytes.
  /// Pass the same bytes you saved above if you want to share immediately.
  static Future<void> shareBytes(Uint8List bytes, {String fileName = 'zeus_receipt.pdf'}) async {
    await Printing.sharePdf(bytes: bytes, filename: fileName);
  }

  static pw.Widget _kv(String k, String v) {
    return pw.Padding(
      padding: const pw.EdgeInsets.symmetric(vertical: 4),
      child: pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        children: [pw.Text(k, style: const pw.TextStyle(fontWeight: pw.FontWeight.bold)), pw.Text(v)],
      ),
    );
  }

  static String _nowIso() => DateTime.now().toIso8601String();
}
