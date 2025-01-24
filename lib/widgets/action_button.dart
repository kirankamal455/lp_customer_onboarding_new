 import 'package:flutter/material.dart';
import 'package:lp_customer_onboarding/core/styles/text_styles.dart';
import 'package:velocity_x/velocity_x.dart';

import '../widgets/custom_text.dart';

class ActionButton extends StatelessWidget {
  final bool? buttonEnabled;
  final String? buttonText;
  final void Function()? onPressed;
  final String? isLogin;
  const ActionButton(
      {super.key,
      required this.buttonEnabled,
      required this.buttonText,
      required this.onPressed,
      this.isLogin});
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all<Color>(!buttonEnabled!
            ? Theme.of(context).disabledColor
            : isLogin == 'Login'
                ? Colors.white
                : Theme.of(context).primaryColor),
        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18.0),
          ),
        ),
      ),
      onPressed: onPressed,
      child: CustomText(
        textAlign: TextAlign.center,
        text: '$buttonText',
        style: CustomTextStyle.buttonStyle(
            isLogin == 'Login' ? Theme.of(context).primaryColor : Colors.white),
      ),
    ).w(250);
  }
}
