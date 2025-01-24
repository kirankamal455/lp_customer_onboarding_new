import 'package:flutter/material.dart';

class AmountText extends StatelessWidget {
  const AmountText(this.amount, {super.key});
  final double amount;
  @override
  Widget build(BuildContext context) {
    return Text(
      '\u{20AC}${amount.toStringAsFixed(2).replaceAll('-', '')}',
      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
    );
  }
}
