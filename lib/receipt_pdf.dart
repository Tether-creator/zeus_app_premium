import 'dart:typed_data';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';

Future<Uint8List> buildReceiptPdf({
  required String txnId,
  required String title,
  required String amountDisplay,
  required String currency,
  required String senderName,
  required String recipientName,
  required DateTime timestamp,
  required String logoAssetPath,
}) async {
  final doc = pw.Document();
  final logo = await imageFromAssetBundle(logoAssetPath);

  doc.addPage(
    pw.Page(
      pageFormat: PdfPageFormat.a4,
      build: (ctx) {
        return pw.Padding(
          padding: const pw.EdgeInsets.all(24),
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Row(mainAxisAlignment: pw.MainAxisAlignment.spaceBetween, children: [
                pw.Row(children: [
                  pw.Image(logo, width: 46),
                  pw.SizedBox(width: 12),
                  pw.Text('ZEUS', style: pw.TextStyle(fontSize: 22, fontWeight: pw.FontWeight.bold)),
                ]),
                pw.BarcodeWidget(
                  data: txnId,
                  width: 120,
                  height: 36,
                  barcode: pw.Barcode.qrCode(),
                ),
              ]),
              pw.SizedBox(height: 24),
              pw.Text(title, style: pw.TextStyle(fontSize: 20, fontWeight: pw.FontWeight.bold)),
              pw.SizedBox(height: 8),
              pw.Text('Transaction ID: $txnId'),
              pw.Text('Date: $timestamp'),
              pw.Divider(),
              _kv('Sender', senderName),
              _kv('Recipient', recipientName),
              _kv('Currency', currency),
              _kv('Amount', amountDisplay),
              pw.SizedBox(height: 12),
              pw.Divider(),
              pw.Align(
                alignment: pw.Alignment.centerRight,
                child: pw.Text('This receipt is computer generated and requires no signature.',
                    style: pw.TextStyle(fontSize: 9, color: PdfColors.grey600)),
              ),
            ],
          ),
        );
      },
    ),
  );

  return doc.save();
}

pw.Widget _kv(String k, String v) => pw.Padding(
      padding: const pw.EdgeInsets.symmetric(vertical: 4),
      child: pw.Row(mainAxisAlignment: pw.MainAxisAlignment.spaceBetween, children: [
        pw.Text(k, style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
        pw.Expanded(child: pw.Text(v, textAlign: pw.TextAlign.right)),
      ]),
    );
