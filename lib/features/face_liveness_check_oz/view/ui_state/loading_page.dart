import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:velocity_x/velocity_x.dart';

class AnalizingResultStateWidget extends StatelessWidget {
  const AnalizingResultStateWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
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

        // Circular progress indicator in the middle (oval shape)
        Center(
            child: Padding(
          padding: const EdgeInsets.only(top: 100),
          child: LoadingAnimationWidget.discreteCircle(
              color: context.primaryColor, size: 200),
          //LoadingAnimationWidget.inkDrop(color: Colors.blue, size: 200),
        )),
        const Spacer(),
        // Bottom text
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 16.0),
          child: Text(
            "Wait for results",
            style: TextStyle(
              color: Colors.black,
              fontSize: 18,
              //fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
