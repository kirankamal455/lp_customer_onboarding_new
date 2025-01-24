import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gap/gap.dart';
import 'package:lp_customer_onboarding/data/model/faceliveness_arg.dart';
import 'package:lp_customer_onboarding/features/docs_corner/view/docs_corner_page.dart';
import 'package:lp_customer_onboarding/features/face_liveness_check_oz/controller/notfier/face_liveness_notifier.dart';
import 'package:lp_customer_onboarding/features/face_liveness_checker/controller/notifier/faceliveness_checker_notifier.dart';
import 'package:lp_customer_onboarding/features/face_liveness_checker/view/widgets/check_again_btn.dart';
import 'package:lp_customer_onboarding/features/face_liveness_instruction/controller/face_liveness_instructions_pod.dart';
import 'package:lp_customer_onboarding/gen/assets.gen.dart';
import 'package:lp_customer_onboarding/l10n/l10n.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:lottie/lottie.dart';

class FaceLivenessError extends StatelessWidget {
  const FaceLivenessError({super.key, required this.faceLivenessArg});

  final FaceLivenessArg faceLivenessArg;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Lottie.asset(
            Assets.animations.notFoundLottieAnimation,
            width: 300,
            height: 300,
            fit: BoxFit.fill,
          ),
          const Gap(20),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Text(
                  context.l10n!.error,
                  style: const TextStyle(
                    fontSize: 17,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const Gap(20),
                Padding(
                  padding: const EdgeInsets.only(left: 30, right: 30),
                  child: Text(
                    context.l10n!.errordetailed,
                    style: const TextStyle(
                      fontSize: 13,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
          const Gap(40),
          const CheckAgainBtn()
        ],
      ),
    );
  }
}
