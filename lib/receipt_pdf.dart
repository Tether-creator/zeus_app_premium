import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'utils/save_bytes/saver.dart';

class ReceiptPdf {
  static Future<List<int>> _buildBytes({
    required String title,
    required Map<String, String> fields,
    List<int>? logoPngBytes, // pass your zeus_logo bytes if you have them
  }) async {
    final doc = pw.Document();
    doc.addPage(
      pw.Page(
        build: (ctx) => pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            if (logoPngBytes != null)
              pw.Center(
                child: pw.Image(pw.MemoryImage(logoPngBytes), width: 80),
              ),
            pw.SizedBox(height: 16),
            pw.Text(title, style: pw.TextStyle(fontSize: 18, fontBold: pw.Font.courierBold())),
            pw.SizedBox(height: 12),
            ...fields.entries.map((e) => pw.Padding(
                  padding: const pw.EdgeInsets.symmetric(vertical: 3),
                  child: pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [pw.Text(e.key), pw.Text(e.value)],
                  ),
                )),
            pw.SizedBox(height: 16),
            pw.Text(
              'This receipt is computer generated.',
              style: pw.TextStyle(fontSize: 9, color: PdfColors.grey600),
            ),
          ],
        ),
      ),
    );
    return await doc.save();
  }

  /// Opens the native print/share UI everywhere.
  static Future<void> share({
    required String title,
    required Map<String, String> fields,
    List<int>? logoPngBytes,
    String filename = 'zeus_receipt.pdf',
  }) async {
    final bytes = await _buildBytes(title: title, fields: fields, logoPngBytes: logoPngBytes);
    // printing handles share/print nicely on all targets
    await Printing.sharePdf(bytes: bytes, filename: filename);
  }

  /// Downloads/saves a PDF in a platform-friendly way.
  static Future<String?> download({
    required String title,
    required Map<String, String> fields,
    List<int>? logoPngBytes,
    String filename = 'zeus_receipt.pdf',
  }) async {
    final bytes = await _buildBytes(title: title, fields: fields, logoPngBytes: logoPngBytes);
    // On web this triggers a browser download; on mobile it writes to tmp and returns the path.
    return await saveBytes(bytes, filename);
  }
}
