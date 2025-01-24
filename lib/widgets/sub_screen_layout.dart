import 'package:flutter/material.dart';
import 'package:lp_customer_onboarding/core/styles/gradient_decoration.dart';
import 'package:lp_customer_onboarding/core/styles/text_styles.dart';
import 'package:velocity_x/velocity_x.dart';

import '../widgets/custom_text.dart';
import './screen_layout_opacity_circles.dart';

class SubScreenLayout extends StatelessWidget {
  final Widget? child;
  final String? titleText;
  final String? subtitleText;
  const SubScreenLayout(
      {super.key,
      required this.child,
      required this.titleText,
      required this.subtitleText});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: context.screenHeight * 0.25,
            decoration:
                GradientDecoration.gradientDecorationWithRadius(context),
            child: ScreenLayoutOpacityCircles(
              child: Container(
                color: Colors.white,
                width: context.screenWidth * 0.9,
                padding:
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                child: Column(
                  children: [
                    CustomText(
                      textAlign: TextAlign.center,
                      text: titleText,
                      style: CustomTextStyle.titleStyle(Colors.black),
                    ),
                    const SizedBox(height: 10),
                    CustomText(
                      textAlign: TextAlign.center,
                      text: subtitleText,
                      style: CustomTextStyle.subtitleStyle(Colors.black),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: context.screenHeight * 0.75, child: child)
        ],
      ),
    );
  }
}
