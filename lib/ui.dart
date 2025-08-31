import 'package:flutter/material.dart';

class ZeusCard extends StatelessWidget {
  final Widget child;
  final EdgeInsets padding;
  const ZeusCard({super.key, required this.child, this.padding = const EdgeInsets.all(16)});
  @override
  Widget build(BuildContext context) => Card(child: Padding(padding: padding, child: child));
}

class SectionTitle extends StatelessWidget {
  final String text;
  const SectionTitle(this.text, {super.key});
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.fromLTRB(16, 14, 16, 8),
    child: Text(text, style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.white)),
  );
}

Widget gap(double h) => SizedBox(height: h);

extension CtxNav on BuildContext {
  Future<T?> go<T>(String route) => Navigator.pushNamed<T>(this, route);
  void back<T extends Object?>([T? result]) => Navigator.pop<T>(this, result);
}
