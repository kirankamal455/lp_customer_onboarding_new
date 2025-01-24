import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gap/gap.dart';
import 'package:lp_customer_onboarding/data/model/faceliveness_arg.dart';
import 'package:lp_customer_onboarding/features/docs_corner/view/docs_corner_page.dart';
import 'package:lp_customer_onboarding/features/face_liveness_check_oz/controller/notfier/face_liveness_notifier.dart';
import 'package:lp_customer_onboarding/features/face_liveness_checker/controller/notifier/faceliveness_checker_notifier.dart';
import 'package:lp_customer_onboarding/features/face_liveness_instruction/controller/face_liveness_instructions_pod.dart';
import 'package:lp_customer_onboarding/gen/assets.gen.dart';
import 'package:lp_customer_onboarding/l10n/l10n.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:lottie/lottie.dart';

class CheckAgainBtn extends StatelessWidget {
  const CheckAgainBtn({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        return ElevatedButton(
          onPressed: () {
            ref.invalidate(faceLivenessCheckerNotifierPod);
            ref.invalidate(faceLivenessInstructionPod);
          },
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: context.primaryColor,
            minimumSize: const Size(200, 50),
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 25),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            elevation: 5,
          ),
          child: ref.watch(faceLivenessInstructionPod).isLoading
              ? const SpinKitThreeBounce(
                  color: Colors.white,
                  size: 20,
                ).w(30)
              : const Text(
                  "Check Again",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2,
                  ),
                ),
        );
      },
    );
  }
}
