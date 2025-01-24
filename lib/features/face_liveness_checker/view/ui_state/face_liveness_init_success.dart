import 'dart:math';

import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lp_customer_onboarding/features/face_liveness_checker/controller/video_path_pod.dart';
import 'package:velocity_x/velocity_x.dart';

class FaceLivenessIntitSuccess extends StatelessWidget {
  const FaceLivenessIntitSuccess({super.key, required this.cameraController});
  final CameraController? cameraController;
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        "Face Liveness Check".text.black.xl.make().positioned(top: 40),
        Container(
          width: 300,
          height: 400,
          decoration: BoxDecoration(
            color: const Color(0xff7c94b6),
            borderRadius: const BorderRadius.all(Radius.elliptical(300, 400)),
            border: Border.all(
              color: context.primaryColor,
              width: 4.0,
            ),
          ),
          child: ClipOval(
            child: SizedBox(
              width: 280,
              height: 360,
              child: cameraController != null
                  ? Transform(
                      alignment: Alignment.center,
                      transform: Matrix4.rotationY(pi),
                      child: CameraPreview(cameraController!),
                    )
                  : const CircularProgressIndicator(),
            ),
          ),
        ),
        Align(
          alignment: Alignment.center,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Consumer(
                builder: (_, WidgetRef cref, __) {
                  var currentInstruction = cref.watch(currentInstructionPod);
                  return Text(
                    currentInstruction,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  );
                },
              ),
              const SizedBox(height: 20),
              Consumer(
                builder: (_, WidgetRef href, __) {
                  var currentInstruction = href.watch(currentInstructionPod);
                  var countdown = href.watch(countdownPod);
                  return Text(
                    currentInstruction.isNotEmpty ? '$countdown Seconds' : "",
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                    ),
                  );
                },
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
        Consumer(
          builder: (_, WidgetRef tref, __) {
            return Positioned(
              bottom: 50,
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Text(
                  tref.watch(isEnableRandomTextPod)
                      ? tref.watch(randomTextPod)
                      : "",
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
