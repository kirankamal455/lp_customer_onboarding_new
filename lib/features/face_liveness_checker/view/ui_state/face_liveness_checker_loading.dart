import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:lp_customer_onboarding/core/router/router_pod.dart';
import 'package:lp_customer_onboarding/features/face_liveness_checker/controller/notifier/faceliveness_checker_notifier.dart';
import 'package:lp_customer_onboarding/features/face_liveness_checker/controller/video_path_pod.dart';
import 'package:velocity_x/velocity_x.dart';

class FaceLivenessCheckerLoading extends StatelessWidget {
  const FaceLivenessCheckerLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Analysis is in \nprogress",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 35,
                        color: Colors.black,
                      ),
                    ),
                    Gap(20),
                    Text(
                      "Please wait a moment",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 18,
                      ),
                    ),
                    Gap(10)
                  ],
                ),
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Consumer(
                builder: (_, WidgetRef ref, __) {
                  return IconButton(
                    onPressed: () {
                      ref.read(autorouterProvider).back();

                      // ref.invalidate(faceLivenessCheckerNotifierPod);
                    },
                    icon: const Icon(
                      Icons.close,
                      size: 30,
                      color: Colors.black,
                    ),
                  );
                },
              ),
            ),
          ],
        ),

        // Circular progress indicator in the middle (oval shape)
        Center(
            child: Padding(
          padding: const EdgeInsets.only(top: 100),
          child: LoadingAnimationWidget.discreteCircle(
              color: context.primaryColor, size: 200),
          //LoadingAnimationWidget.inkDrop(color: Colors.blue, size: 200),
        )),
        const Spacer(),
        Consumer(
          builder: (_, WidgetRef ref, __) {
            final progress = ref.watch(upLoadingProgressIndicatorPod);
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                textAlign: TextAlign.center,
                progress.isEmpty
                    ? "Performing liveness detection\nPlease  wait... "
                    : progress,
                style: const TextStyle(
                  color: Colors.green,
                  fontSize: 18,
                ),
              ),
            );
          },
        ),
        const Gap(50),
        // const Padding(
        //   padding: EdgeInsets.symmetric(vertical: 16.0),
        //   child: Text(
        //     "Wait for results",
        //     style: TextStyle(
        //       color: Colors.black,
        //       fontSize: 18,
        //       //fontWeight: FontWeight.bold,
        //     ),
        //   ),
        // ),
      ],
    );
  }
}
