// lib/screens/receipt_screen.dart
import 'package:flutter/material.dart';
import '../theme.dart';
import '../services/receipt_pdf.dart';

class ReceiptScreen extends StatelessWidget {
  static const route = '/receipt';
  final ZeusReceiptData receipt;

  const ReceiptScreen({super.key, required this.receipt});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ZeusColors.background,
      appBar: AppBar(title: const Text('Transaction Receipt')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo + success text (your existing UI) …
            const SizedBox(height: 18),
            FilledButton(
              onPressed: () async {
                await ReceiptPdfService.share(receipt);
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Receipt ready — check your download/share dialog.')),
                  );
                }
              },
              child: const Text('Download / Share PDF'),
            ),
          ],
        ),
      ),
    );
  }
}
