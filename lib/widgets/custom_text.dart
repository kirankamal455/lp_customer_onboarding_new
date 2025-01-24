import 'package:flutter/material.dart';

 

class CustomText extends StatelessWidget {
  final String? text;
  final TextStyle? style;
  final TextAlign? textAlign;

  const CustomText(
      {super.key,
      required this.text,
      required this.style,
      required this.textAlign});

  @override
  Widget build(BuildContext context) {
    return Text(
      '$text',
      style: style,
      textAlign: textAlign,
    );
  }
}
