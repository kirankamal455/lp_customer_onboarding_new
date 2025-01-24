import 'package:flutter/material.dart';

class FloatingButton extends StatelessWidget {
  final bool buttonEnabled;
  final String? buttonText;
  final void Function()? onPressed;
  final String? isLogin;
  const FloatingButton(
      {super.key,
      required this.buttonEnabled,
      required this.buttonText,
      required this.onPressed,
      this.isLogin});
  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    return SizedBox(
      // width: ResponsiveWidget.isDesktop(context)
      //     ? screenWidth * 0.2
      //     : ResponsiveWidget.isTablet(context)
      //         ? screenWidth * 0.4
      width: screenWidth * 0.7,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all<Color>(!buttonEnabled
              ? Theme.of(context).disabledColor
              : Theme.of(context).primaryColor),
          shape: WidgetStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18.0),
            ),
          ),
        ),
        onPressed: onPressed,
        child: Text(
          '$buttonText',
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
