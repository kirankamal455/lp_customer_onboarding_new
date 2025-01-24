import 'package:auto_route/annotations.dart';
import 'package:flutter/foundation.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lp_customer_onboarding/core/router/router.gr.dart';
import 'package:lp_customer_onboarding/core/router/router_pod.dart';
import 'package:lp_customer_onboarding/core/styles/gradient_decoration.dart';
import 'package:lp_customer_onboarding/core/styles/text_styles.dart';
import 'package:lp_customer_onboarding/features/welcome/controller/customer_onboarding_mode_pod.dart';
import 'package:lp_customer_onboarding/features/welcome/controller/debug_mode_check_pod.dart';
import 'package:lp_customer_onboarding/gen/assets.gen.dart';
import 'package:lp_customer_onboarding/l10n/l10n.dart';
import 'package:lp_customer_onboarding/shared/helper/global_helper.dart';
import 'package:lp_customer_onboarding/widgets/action_button.dart';
import 'package:lp_customer_onboarding/widgets/custom_text.dart';
import 'package:lp_customer_onboarding/widgets/opacity_circles.dart';
import 'package:velocity_x/velocity_x.dart';

@RoutePage()
class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> with GlobalHelper {
  bool isReleaseMode = false;
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          kDebugMode
              ? Switch(
                  value: isReleaseMode,
                  onChanged: (value) {
                    setState(() {
                      isReleaseMode = value;
                    });
                    print("Mode: $isReleaseMode");
                  },
                  activeColor: Colors.white,
                )
              : const SizedBox.shrink(),
          // ThemeSettingsButton(onSelected: (p0) {
          //   showCustomBottomSheet(
          //     context: context,
          //     builder: (BuildContext bc) {
          //       return const ThemeBottomSheet();
          //     },
          //   );
          // })
        ],
      ),
      body: [
        OpacityCircles(
          screenSize: context.screenSize,
          child: Image.asset(
            Assets.images.a.path,
            width: 180,
          ),
        ).h(context.screenHeight * 0.3),
        [
          10.heightBox,
          CustomText(
            textAlign: TextAlign.center,
            text: l10n?.welcome_text,
            style: CustomTextStyle.welcomeScreenStyle(Colors.white),
          ),
          SizedBox(
            height: context.screenHeight * 0.1,
          ),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: const BoxDecoration(
                shape: BoxShape.circle, color: Colors.white),
            child: Icon(
              Icons.person_2_outlined,
              size: 55,
              color: Theme.of(context).primaryColor,
            ),
          ),
          SizedBox(
            height: context.screenHeight * 0.12,
          ),
          Consumer(
            builder: (context, cref, child) {
              final getCustomerOnboardingMode =
                  cref.watch(customeOnboardingModePod);
              return getCustomerOnboardingMode.when(
                data: (selectedMode) => Column(
                  children: [
                    Consumer(builder: (_, WidgetRef ref, __) {
                      final mode =
                          ref.watch(isDebugModeCheckerPod(selectedMode));
                      return SizedBox(
                        width: 265,
                        height: 40,
                        child: ActionButton(
                          onPressed: () async {
                            ref.read(autorouterProvider).navigate(
                                  SendOtpRoute(
                                      isCustomerRevalidation: true,
                                      isNormalMode: selectedMode

                                      //  kDebugMode
                                      //     ? isReleaseMode
                                      //     : selectedMode,
                                      //isNormalMode: isNormalMode,
                                      ),
                                );
                          },
                          buttonText: l10n?.welcome_existing_customer,
                          buttonEnabled: true,
                          isLogin: 'Login',
                        ),
                      );
                    }),
                    10.heightBox,
                    Consumer(
                      builder: (_, WidgetRef ref, __) {
                        return SizedBox(
                          width: 265,
                          height: 40,
                          child: ActionButton(
                            onPressed: () async {
                              ref.read(autorouterProvider).navigate(
                                    SendOtpRoute(
                                        isCustomerRevalidation: false,
                                        isNormalMode: selectedMode

                                        //  kDebugMode
                                        //     ? isReleaseMode
                                        //     : selectedMode,
                                        ),
                                  );
                            },
                            buttonText: l10n?.welcome_new_customer,
                            buttonEnabled: true,
                            isLogin: 'Login',
                          ),
                        );
                      },
                    ),
                  ],
                ),
                error: (error, stackTrace) => Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    "Something went wrong".text.white.make(),
                    const SizedBox(height: 20),
                    Consumer(
                      builder: (_, WidgetRef ref, __) {
                        return ElevatedButton(
                          onPressed: () {
                            ref.invalidate(customeOnboardingModePod);
                          },
                          style: ElevatedButton.styleFrom(
                            foregroundColor: context.primaryColor,
                            backgroundColor: Colors.white, // Black text color
                          ),
                          child: 'Retry'
                              .text
                              .black
                              .make(), // Text color set to black
                        ).w(130).h(45);
                      },
                    ),
                  ],
                ),
                loading: () => const CircularProgressIndicator(
                  color: Colors.white,
                ),
                skipLoadingOnRefresh: false,
                skipLoadingOnReload: false,
              );
            },
          ),

          30.heightBox,
          // [
          //   const Expanded(
          //     child: Divider(
          //       color: Colors.white,
          //       thickness: 1,
          //     ),
          //   ),
          //   l10n!.welcome_languages.text
          //       .textStyle(CustomTextStyle.subtitleStyle(
          //           Theme.of(context).colorScheme.surface))
          //       .make()
          //       .pOnly(left: 4, right: 4),
          //   const Expanded(
          //     child: Divider(
          //       color: Colors.white,
          //       thickness: 1,
          //     ),
          //   ),
          // ].hStack().w(300),
          //  [
          // Consumer(
          //   builder: (_, WidgetRef ref, __) {
          //     return TextButton(
          //       onPressed: () {
          //         // ref.read(localePod.notifier).changeLocale(
          //         //     context: context, locale: const Locale('en'));
          //       },
          //       child: Text('English',
          //           style: CustomTextStyle.subtitleStyle(
          //               Theme.of(context).colorScheme.surface)),
          //     );
          //   },
          // ),
          // Text('/',
          //     style: CustomTextStyle.subtitleStyle(
          //         Theme.of(context).colorScheme.surface)),
          // Consumer(
          //   builder: (_, WidgetRef ref, __) {
          //     return TextButton(
          //       onPressed: () {
          //         // ref.read(localePod.notifier).changeLocale(
          //         //     context: context, locale: const Locale('ar'));
          //       },
          //       child: Text('عربي',
          //           style: CustomTextStyle.subtitleStyle(
          //               Theme.of(context).colorScheme.surface)),
          //     );
          //   },
          // ),
          // ].hStack(
          //   alignment: MainAxisAlignment.center,
          //   ),
        ].vStack(),
      ]
          .vStack(crossAlignment: CrossAxisAlignment.center)
          .box
          .withDecoration(GradientDecoration.gradientDecoration(context))
          .make(),
    );
  }
}
