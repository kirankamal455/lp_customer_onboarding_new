import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:lp_customer_onboarding/core/router/router.gr.dart';
import 'package:lp_customer_onboarding/core/router/router_pod.dart';
import 'package:lp_customer_onboarding/data/model/faceliveness_arg.dart';
import 'package:lp_customer_onboarding/features/face_liveness_check_oz/controller/notfier/face_liveness_notifier.dart';
import 'package:lp_customer_onboarding/features/face_liveness_instruction/view/widgets/instruction_card.dart';
import 'package:lp_customer_onboarding/features/face_liveness_instruction/view/widgets/instruction_text.dart';

@RoutePage()
class FaceLivenessInstructionPage extends StatelessWidget {
  final FaceLivenessArg faceLivenessArg;

  const FaceLivenessInstructionPage({super.key, required this.faceLivenessArg});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100.withOpacity(1),
      appBar: AppBar(
        title: const Text("Liveness Verification"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Gap(30),
            const Text(
              'Liveness Detection\nInstructions',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
            const Gap(30),
            const InstructionCard(),
            const Spacer(),
            Consumer(
              builder: (_, WidgetRef ref, __) {
                return ElevatedButton(
                  onPressed: () async {
                    ref.read(autorouterProvider).navigate(
                          FaceLivenessCheckerRoute(
                              faceLivenessArg: faceLivenessArg),
                        );
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 12),
                    textStyle: const TextStyle(fontSize: 18),
                  ),
                  child: const Text(
                    'Start Liveness Verification',
                    style: TextStyle(color: Colors.white),
                  ),
                );
              },
            ),const Gap(20),
          ],
        ),
      ),
    );
  }
}
