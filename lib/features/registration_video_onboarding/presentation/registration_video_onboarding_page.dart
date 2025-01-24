import 'package:auto_route/annotations.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lp_customer_onboarding/core/router/router.gr.dart';
import 'package:lp_customer_onboarding/core/router/router_pod.dart';
import 'package:lp_customer_onboarding/core/styles/text_styles.dart';
import 'package:lp_customer_onboarding/l10n/l10n.dart';
import 'package:lp_customer_onboarding/shared/pods/user_register_pod.dart';
import 'package:lp_customer_onboarding/widgets/action_button.dart';
import 'package:lp_customer_onboarding/widgets/custom_text.dart';
import 'package:lp_customer_onboarding/widgets/icon_description.dart';
import 'package:lp_customer_onboarding/widgets/screen_layout.dart';
import 'package:velocity_x/velocity_x.dart';

@RoutePage()
class RegistrationVideoOnboardingPage extends ConsumerWidget {
  const RegistrationVideoOnboardingPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final firstname = ref.watch(userRegisterProvider).fname;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: ScreenLayout(
        titleText: l10n!.video_onbording_screen_title,
        subtitleText:
            'Thanks ${firstname.isEmptyOrNull ? "" : firstname} ,now it is time to take a video of you',
        child: SizedBox(
          width: context.screenWidth * 0.7,
          child: Column(
            children: [
              const SizedBox(height: 60),
              IconDescription(
                  iconData: Icons.lock,
                  description: l10n.video_onbording_screen_icon_desc_label),
              const SizedBox(height: 60),
              CustomText(
                textAlign: TextAlign.center,
                text: l10n.video_onbording_screen_label,
                style: CustomTextStyle.subtitleStyle(Colors.black),
              ),
              const Spacer(),
              Consumer(
                builder: (_, WidgetRef ref, __) {
                  return ActionButton(
                    onPressed: () {
                     ref
                          .read(autorouterProvider)
                         .navigate(const RegistrationSubmitKycRoute());
                    },
                    buttonText: l10n.util_continue_button,
                    buttonEnabled: true,
                  );
                },
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
