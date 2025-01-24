import 'package:flutter/material.dart';

class CircleIconTheme extends StatelessWidget {
  final int iconNumber;
  const CircleIconTheme(this.iconNumber, {super.key});
  Widget setIconForTransactionHistory(
      int iconData, Color colorData, double size) {
    switch (iconData) {
      case 0:
        return Icon(Icons.qr_code_scanner, color: colorData, size: size);
      case 1:
        return Icon(Icons.account_balance_wallet, color: colorData, size: size);
      case 2:
        return Icon(Icons.call_made, color: colorData, size: size);
      case 3:
        return Icon(Icons.call_received, color: colorData, size: size);
      case 4:
        return Icon(Icons.call_split, color: colorData, size: size);
      case 5:
        return Icon(Icons.receipt_long_outlined, color: colorData, size: size);
      default:
        return Icon(Icons.person, color: colorData, size: size);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15.0),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        // borderRadius: BorderRadius.circular(5),
        // border: Border.all(color: Theme.of(context).primaryColor),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Theme.of(context).primaryColorLight,
            Theme.of(context).primaryColor
          ],
        ),
      ),
      child: setIconForTransactionHistory(
          iconNumber,
          // Theme.of(context).primaryColor,
          Colors.white,
          30),
    );
  }
}
