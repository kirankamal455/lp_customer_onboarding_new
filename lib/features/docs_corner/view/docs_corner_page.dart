import 'dart:io';

import 'package:auto_route/annotations.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lp_customer_onboarding/core/router/router.gr.dart';
import 'package:lp_customer_onboarding/core/router/router_pod.dart';
import 'package:lp_customer_onboarding/core/styles/text_styles.dart';
import 'package:lp_customer_onboarding/features/registration_doc_select_page/controller/croped_image_pod.dart';
import 'package:lp_customer_onboarding/l10n/l10n.dart';
import 'package:lp_customer_onboarding/widgets/action_button.dart';
import 'package:lp_customer_onboarding/widgets/custom_text.dart';
import 'package:lp_customer_onboarding/widgets/screen_layout.dart';
import 'package:velocity_x/velocity_x.dart';

@RoutePage()
class DocsCornerPage extends StatelessWidget {
  const DocsCornerPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: ScreenLayout(
        titleText: l10n!.docsCorner_title,
        subtitleText: l10n.docsCorner_subtitle,
        child: SizedBox(
          width: context.screenWidth * 0.9,
          child: Column(
            children: [
              const SizedBox(height: 50),
              Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                width: context.screenWidth * 0.9,
                height: context.screenHeight * 0.3,
                child: Consumer(
                  builder: (_, WidgetRef ref, __) {
                    final cropedImage = ref.watch(cropedImagePod);
                    return Image.file(
                      File(cropedImage!.path),
                      fit: BoxFit.fill,
                    );
                  },
                ),
              ),
              const SizedBox(height: 60),
              CustomText(
                textAlign: TextAlign.center,
                text: l10n.docsCorner_label,
                style: CustomTextStyle.subtitleStyle(Colors.black),
              ),
              const Spacer(),
              Consumer(
                builder: (_, WidgetRef ref, __) {
                  return ActionButton(
                    onPressed: () async {
                      ref
                          .read(autorouterProvider)
                          .navigate(const RegistrationVideoOnboardingRoute());
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
