import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lp_customer_onboarding/core/styles/text_styles.dart';
import 'package:lp_customer_onboarding/features/welcome/view/widgets/color_container.dart';
 
import 'package:lp_customer_onboarding/l10n/l10n.dart';
import 'package:lp_customer_onboarding/widgets/custom_text.dart';
import 'package:velocity_x/velocity_x.dart';

class ThemeBottomSheet extends StatelessWidget {
  const ThemeBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Container(
      height: context.screenHeight * 0.25,
      color: Colors.transparent, //could change this to Color(0xFF737373),
      //so you don't have to change MaterialApp canvasColor
      child: Container(
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10.0),
                  topRight: Radius.circular(10.0))),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: FittedBox(
              child: SizedBox(
                width: context.screenWidth * 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Column(
                        // mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(
                            text: "tittle",
                            textAlign: TextAlign.left,
                            style: CustomTextStyle.modalTitleStyle(),
                          ),
                          CustomText(
                            text: "Subtittle",
                            textAlign: TextAlign.left,
                            style: CustomTextStyle.welcomeScreenStyle(
                                Colors.black),
                          ),
                          const SizedBox(height: 30),
                        ],
                      ),
                    ),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        // Container(
                        //   height: 30,
                        //   width: 30,
                        //   decoration: BoxDecoration(
                        //       gradient: LinearGradient(
                        //         begin: Alignment.topLeft,
                        //         end: Alignment.bottomRight,
                        //         colors: [
                        //           Theme.of(context).primaryColorLight,
                        //           Theme.of(context).primaryColor
                        //         ],
                        //       ),
                        //       shape: BoxShape.circle),
                        // ),

                        ColorContainer(
                            color: Color(0xFFDF0AFC),
                            color1: Color(0xFF5611F8)),
                        ColorContainer(
                            color: Color(0xFF4CAF50),
                            color1: Color(0xFF1D976C)),

                        ColorContainer(
                            color: Color(0xFF25308F),
                            color1: Color(0xFF5066EB)),
                        ColorContainer(
                            color: Color(0xFF1F1C2C),
                            color1: Color(0xFF928DAB)),
                        ColorContainer(
                            color: Color(0xFF1A2980),
                            color1: Color(0xFF26D0CE)),
                        ColorContainer(
                            color: Color(0xFFAA076B),
                            color1: Color(0xFF61045F)),
                        ColorContainer(
                            color: Color(0xFFAA076A),
                            color1: Color(0xFFF09819)),
                        ColorContainer(
                            color: Color(0xFFF21E0A),
                            color1: Color(0xFF6D0D04)),
                      ],
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Consumer(
                        builder: (_, WidgetRef ref, __) {
                          return TextButton(
                            child: CustomText(
                              text: "odd",
                              textAlign: TextAlign.left,
                              style: CustomTextStyle.subtitleStyle(
                                  Theme.of(context).primaryColor),
                            ),
                            onPressed: () {
                              // ref.read(autorouterProvider).pop();
                            },
                          );
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
          )),
    );
  }
}
