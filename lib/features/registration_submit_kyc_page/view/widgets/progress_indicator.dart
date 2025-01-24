 import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lp_customer_onboarding/features/registration_submit_kyc_page/controller/sending_progress_pod.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:velocity_x/velocity_x.dart';

class SendingProgressIndicator extends StatelessWidget {
  const SendingProgressIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Consumer(
          builder: (context, ref, child) {
            final progress = ref.watch(sendingProgressPod);
            return CircularPercentIndicator(
              radius: 50,
              lineWidth: 5,
              reverse: false,
              percent: progress / 100,
              center: Text("${progress.ceil().toString()}%",
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 20.0)),
              footer: const Padding(
                padding: EdgeInsets.only(top: 20),
                child: Text(
                  "Uploading...",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17.0),
                ),
              ),
              circularStrokeCap: CircularStrokeCap.square,
              progressColor: context.primaryColor,
            );
          },
        ),
        const SizedBox(height: 8),
      ],
    );
  }
}
