import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gap/gap.dart';
import 'package:lp_customer_onboarding/core/enums/faceliveness_check_enums.dart';
import 'package:lp_customer_onboarding/core/router/router_pod.dart';
import 'package:lp_customer_onboarding/data/model/faceliveness_arg.dart';
import 'package:lp_customer_onboarding/data/model/live_face_response_model.dart';
import 'package:lp_customer_onboarding/features/face_liveness_check_oz/controller/notfier/face_liveness_notifier.dart';
import 'package:lp_customer_onboarding/features/face_liveness_checker/controller/notifier/faceliveness_checker_notifier.dart';
import 'package:lp_customer_onboarding/features/face_liveness_checker/view/widgets/check_again_btn.dart';
import 'package:lp_customer_onboarding/features/face_liveness_instruction/controller/face_liveness_instructions_pod.dart';
import 'package:lp_customer_onboarding/l10n/l10n.dart';
import 'package:velocity_x/velocity_x.dart';

class FaceLivenessWarning extends StatelessWidget {
  const FaceLivenessWarning(
      {super.key,
      required this.faceLivenessArg,
      required this.liveFaceResponseModel});

  final FaceLivenessArg faceLivenessArg;
  final LiveFaceResponseModel liveFaceResponseModel;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          // Warning icon with error message
          const Icon(
            Icons.warning_amber_rounded, // Warning icon
            color: Colors.orangeAccent,
            size: 60,
          ),
          const Gap(20), // Space between the icon and the text

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              context.l10n!.declined,
              style: const TextStyle(
                fontSize: 25,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),

          // Padding(
          //   padding: const EdgeInsets.all(8.0),
          //   child: Text(
          //     liveFaceResponseModel.Result,
          //     style: const TextStyle(
          //       fontSize: 14,
          //       color: Colors.black,
          //     ),
          //     textAlign: TextAlign.center,
          //   ),
          // ),

          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 40),
              child: Column(
                children: liveFaceResponseModel.Instructions.map<Widget>(
                    (instruction) => ListTile(
                          title: Text(instruction.instruction),
                          trailing: Icon(
                            instruction.Status
                                ? Icons.check_circle
                                : Icons.cancel,
                            color:
                                instruction.Status ? Colors.green : Colors.red,
                          ),
                        )).toList(),
              ),
            ),
          ),

          const SizedBox(height: 20),

          // Retry button
          const Gap(40),
           const CheckAgainBtn()
        ],
      ),
    );
  }
}
