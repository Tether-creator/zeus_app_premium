// lib/services/receipt_pdf.dart
import 'dart:typed_data';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class ZeusReceiptData {
  final String txId;
  final String fromName;
  final String toName;
  final String toBank;
  final String toAccount;
  final String currency;
  final double amount;
  final DateTime timestamp;

  ZeusReceiptData({
    required this.txId,
    required this.fromName,
    required this.toName,
    required this.toBank,
    required this.toAccount,
    required this.currency,
    required this.amount,
    required this.timestamp,
  });
}

class ReceiptPdfService {
  static Future<Uint8List> _buildBytes(ZeusReceiptData data) async {
    final doc = pw.Document();

    final money = NumberFormat.currency(
      symbol: data.currency,
      decimalDigits: 2,
    ).format(data.amount);

    final dateStr = DateFormat('yyyy-MM-dd  •  HH:mm').format(data.timestamp);

    doc.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(28),
        build: (context) {
          return pw.Container(
            decoration: pw.BoxDecoration(
              border: pw.Border.all(color: PdfColors.grey300, width: 1),
              borderRadius: pw.BorderRadius.circular(8),
            ),
            padding: const pw.EdgeInsets.all(20),
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                // Header
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Text('ZEUS', style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold)),
                        pw.SizedBox(height: 4),
                        pw.Text('Transaction Receipt', style: const pw.TextStyle(fontSize: 12, color: PdfColors.grey700)),
                      ],
                    ),
                    pw.Container(
                      padding: const pw.EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                      decoration: pw.BoxDecoration(
                        color: PdfColors.green600,
                        borderRadius: pw.BorderRadius.circular(6),
                      ),
                      child: pw.Text('SUCCESS', style: pw.TextStyle(color: PdfColors.white, fontWeight: pw.FontWeight.bold)),
                    ),
                  ],
                ),
                pw.SizedBox(height: 18),
                pw.Divider(color: PdfColors.grey300),

                // Summary amount
                pw.SizedBox(height: 14),
                pw.Text(money, style: pw.TextStyle(fontSize: 22, fontWeight: pw.FontWeight.bold)),
                pw.SizedBox(height: 4),
                pw.Text('ID: ${data.txId}', style: const pw.TextStyle(fontSize: 11, color: PdfColors.grey700)),
                pw.SizedBox(height: 2),
                pw.Text(dateStr, style: const pw.TextStyle(fontSize: 11, color: PdfColors.grey700)),

                pw.SizedBox(height: 18),
                pw.Divider(color: PdfColors.grey300),

                // Parties
                pw.SizedBox(height: 10),
                _kv('Sender', data.fromName),
                _kv('Recipient', data.toName),
                _kv('Bank', data.toBank),
                _kv('Account', data.toAccount),

                pw.SizedBox(height: 18),
                pw.Divider(color: PdfColors.grey300),
                pw.SizedBox(height: 6),
                pw.Text(
                  'This receipt is computer generated and does not require a signature.',
                  style: const pw.TextStyle(fontSize: 9, color: PdfColors.grey600),
                ),
              ],
            ),
          );
        },
      ),
    );

    return doc.save();
  }

  static pw.Widget _kv(String k, String v) {
    return pw.Padding(
      padding: const pw.EdgeInsets.symmetric(vertical: 4),
      child: pw.Row(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.SizedBox(width: 110, child: pw.Text(k, style: pw.TextStyle(fontWeight: pw.FontWeight.bold))),
          pw.Expanded(child: pw.Text(v)),
        ],
      ),
    );
  }

  /// Cross-platform: opens the native share/save dialog.
  /// On Web this triggers a browser download; on Android/iOS it opens the Share sheet.
  static Future<void> share(ZeusReceiptData data) async {
    final bytes = await _buildBytes(data);
    final filename = 'zeus_receipt_${data.txId}.pdf';

    // On all platforms, use printing's share (works on Web too).
    await Printing.sharePdf(bytes: bytes, filename: filename);

    // If you also want to present a print dialog (optional):
    // await Printing.layoutPdf(onLayout: (_) async => bytes, name: filename);
  }
}
