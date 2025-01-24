 
import 'package:flutter/material.dart';
import 'package:lp_customer_onboarding/core/styles/text_styles.dart';
import 'package:lp_customer_onboarding/widgets/custom_text.dart';

class IconDescription extends StatelessWidget {
  final IconData? iconData;
  final String? description;
  const IconDescription({
    super.key,
    required this.iconData,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(iconData),
        const Spacer(),
        Flexible(
          flex: 15,
          child: CustomText(
            textAlign: TextAlign.center,
            text: description,
            style: CustomTextStyle.subtitleStyle(Colors.black),
          ),
        ),
        const Spacer(),
      ],
    );
  }
}
