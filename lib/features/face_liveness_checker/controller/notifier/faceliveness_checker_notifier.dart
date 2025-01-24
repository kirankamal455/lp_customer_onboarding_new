import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lp_customer_onboarding/core/router/router.gr.dart';
import 'package:lp_customer_onboarding/core/router/router_pod.dart';
import 'package:lp_customer_onboarding/data/model/facelivenesess_pod_arg_model.dart';
import 'package:lp_customer_onboarding/data/model/livenss_instruction_response_model.dart';
import 'package:lp_customer_onboarding/data/repositories/login/login_repo_pod.dart';
import 'package:lp_customer_onboarding/features/face_liveness_checker/controller/is_pop_pod.dart';
import 'package:lp_customer_onboarding/features/face_liveness_checker/controller/video_path_pod.dart';
import 'package:lp_customer_onboarding/features/face_liveness_checker/state/face_liveness_checker_state.dart';
import 'package:lp_customer_onboarding/features/face_liveness_instruction/controller/face_liveness_instructions_pod.dart';
import 'package:lp_customer_onboarding/shared/riverpod_ext/cancel_extensions.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_compress/video_compress.dart';

final faceLivenessCheckerNotifierPod = AutoDisposeAsyncNotifierProviderFamily<
    FaceLivenessCheckerNotifier,
    FaceLivenessCheckerState,
    FaceLivenessPodArgumentModel>(
  FaceLivenessCheckerNotifier.new,
);

class FaceLivenessCheckerNotifier extends AutoDisposeFamilyAsyncNotifier<
    FaceLivenessCheckerState, FaceLivenessPodArgumentModel> {
  @override
  FutureOr<FaceLivenessCheckerState> build(
      FaceLivenessPodArgumentModel arg) async {
    await _initializeCamera();
    ref.onDispose(() async {
      ref.invalidate(instructionIndexPod);
    });
    return future;
  }

  Future<void> _initializeCamera() async {
    try {
      final instructions = await ref.watch(faceLivenessInstructionPod.future);
      if (instructions.data.isNotEmpty) {
        final cameraController = await ref.watch(cameraControllerPod.future);
        if (kIsWeb) {
          ref.read(videoFilePathPod.notifier).update(
                (state) => 'video/liveness.mp4',
              );
        } else {
          final directory = await getApplicationDocumentsDirectory();
          ref.read(videoFilePathPod.notifier).update(
                (state) => '${directory.path}/liveness_test_video.mp4',
              );
        }
        await cameraController!.startVideoRecording();

        state = AsyncData(FacelivenessCheckerInitSuccessState(
            cameraController: cameraController));
        print("instruction is :$instructions");
        ref.read(isPop.notifier).state = true;
        _updateInstruction(instructions.data);
      } else {
        state =
            AsyncData(FacelivenessCheckerErrorState("Instruction not found"));
      }
    } catch (e) {
      log("camara error: $e");
      state = AsyncData(FacelivenessCheckerErrorState(e.toString()));
    }
  }

  void _updateInstruction(List<Instructions> instructions) {
    ref.listen(timerStreamProvider, (previous, next) {
      final index = ref.read(instructionIndexPod);
      final countdown = ref.read(countdownPod);
      ref.read(hideTimerPod.notifier).state = false;
      print("index is $index");
      print("countdown is $countdown");
      // print("instruction is  ${ref.read(currentInstructionPod.notifier).update(
      //       (state) => arg[index].instruction,
      //     )}");
      if (countdown == 1 &&
          ref.read(instructionIndexPod) < instructions.length) {
        _moveToNextInstruction(instructions);
      } else if (!ref.read(isCompletedPod)) {
        _updateCountdown(instructions);
      }
    });
  }

  // Function to move to the next instruction
  void _moveToNextInstruction(List<Instructions> instructions) {
    // index++;

    ref.read(instructionIndexPod.notifier).update(
          (state) => state + 1,
        );
    final index = ref.read(instructionIndexPod);
    if (index >= instructions.length) {
      _onInstructionsCompleted(instructions);
    } else {
      // Reset the countdown to 4
      ref.read(countdownPod.notifier).update((state) => 4);

      // Increment the instruction index
      //ref.read(instructionIndexPod.notifier).update((state) => state + 1);
      // Update the current instruction
      ref.read(currentInstructionPod.notifier).update(
            (state) => instructions[index].featureName,
          );
    }
  }

  void _updateCountdown(List<Instructions> instructions) {
    // Check if currentInstruction is not empty and countdown is greater than 0
    if (ref.read(currentInstructionPod).isNotEmpty &&
        ref.read(countdownPod) > 0) {
      // Decrease countdown value
      ref.read(countdownPod.notifier).update((state) => state - 1);
    }

    // Get the current instruction index and instruction data
    final index = ref.read(instructionIndexPod);
    final currentInstruction = instructions[index].featureName;

    // Update current instruction text
    ref.read(currentInstructionPod.notifier).state = currentInstruction;

    final isSpeakWords = currentInstruction.contains("Speak the words below");

    ref.read(isEnableRandomTextPod.notifier).state = isSpeakWords;

    if (isSpeakWords) {
      // Set random word if enabled
      ref.read(randomTextPod.notifier).state = instructions[index].speakWord;
      ref.read(audioCheckPod.notifier).state = true;
    }
  }

  // Function to mark the process as completed and stop the timer
  void _onInstructionsCompleted(List<Instructions> instructions) async {
    ref.read(isCompletedPod.notifier).update(
          (state) => true,
        );
    ref
        .read(currentInstructionPod.notifier)
        .update((state) => "Please Wait...");
    ref.read(hideTimerPod.notifier).state = true;
    // _timer.cancel();
    await _stopRecordingAndNavigate(instructions);
  }

  // Function to stop video recording and process the video
  Future<void> _stopRecordingAndNavigate(
      List<Instructions> instructions) async {
    print("Stop recording and process");
    state = AsyncData(FacelivenessCheckerLoadingState());
    ref.read(isPop.notifier).state = false;
    try {
      final cameraController = await ref.watch(cameraControllerPod.future);
      var image = await cameraController!.takePicture();
      final file = await cameraController.stopVideoRecording();
      await _processVideo(file.path, image.path, instructions);
    } catch (e) {
      ref.read(isPop.notifier).state = true;
      state = AsyncData(FacelivenessCheckerErrorState(e.toString()));
    }
  }

  // Function to process the recorded video
  Future<void> _processVideo(String videoPath, String imagePath,
      List<Instructions> instructions) async {
    print("Processing video");

    try {
      String? compressedVideoPath =
          await _compressVideo(videoPath, instructions);

      if (compressedVideoPath == null) {
        state = AsyncData(FacelivenessCheckerErrorState('Compression failed'));
        return;
      }
      print("Video uploading");
      await _uploadVideo(
          compressedVideoPath: compressedVideoPath,
          imagePath: imagePath,
          instructions: instructions);
      print("Video uploaded");
    } catch (e) {
      state = AsyncData(FacelivenessCheckerErrorState(e.toString()));
    }
  }

  // Function to compress the video
  Future<String?> _compressVideo(
      String videoPath, List<Instructions> instructions) async {
    try {
      var mediaInfo = await VideoCompress.compressVideo(
        videoPath,
        quality: VideoQuality.LowQuality,
        deleteOrigin: false,
      );

      return mediaInfo?.file?.path;
    } catch (e) {
      state = AsyncData(FacelivenessCheckerErrorState(e.toString()));
      ref.read(isPop.notifier).state = true;
    }
    return null;
  }

  Future<void> _uploadVideo(
      {required String compressedVideoPath,
      required String imagePath,
      required List<Instructions> instructions}) async {
    // ref.read(upLoadingProgressIndicatorPod.notifier).update(
    //       (state) => "Processing Video",
    //     );

    var instructionsList = {
      "instructions": instructions
          .map((e) => {
                "id": e.id,
                "instruction": e.featureName,
                "shortform": e.shortForm,
                "text": e.speakWord,
              })
          .toList(),
    };

    String jsonString = jsonEncode(instructionsList);

    log("instructionsList : $jsonString");

    final result = await ref.watch(loginRepoPod).uploadFacelivenessVideo(
          instructionsList: jsonString,
          processId: arg.documentUploadResponseModel.userId,
          // randomText: ref.read(randomTextPod),
          // isEnableRandomText: ref.read(audioCheckPod),
          videoPath: compressedVideoPath,
          cancelToken: ref.cancelToken(),
          onSendProgress: (count, total) {
            final percentage = ((count / total) * 100)
                .ceilToDouble()
                .toInt(); // Convert to integer
            print('Upload Progress: $percentage %');
            // ref.read(upLoadingProgressIndicatorPod.notifier).update(
            //       (state) => "Uploading Video $percentage %",
            //     );
          },
          documentImageUrl: arg.documentUploadResponseModel.data.documentUrl,
        );

    result.when(
      (success) {
        if (success.Status == true) {
          verifyFace(imagePath: imagePath);

          // if (success.FaceMatch) {
          //   ref.read(autorouterProvider).replaceAll(
          //       [RegistrationSuccessRoute(isRegistrationPending: false)]);
          // } else {
          //   ref.read(isPop.notifier).state = true;
          //   state = AsyncData(FacelivenessCheckerFaceNotMatchingState());
          // }
        } else {
          state = AsyncData(FacelivenessCheckerFaildState(success));
          ref.read(isPop.notifier).state = true;
        }
      },
      (error) {
        state = AsyncData(FacelivenessCheckerErrorState(error.toString()));
        ref.read(isPop.notifier).state = true;
      },
    );
  }

  Future<void> verifyFace({required String imagePath}) async {
    // state = AsyncData(FacelivenessAnalizingState());
    // state = AsyncData(FaceVerifingLoadingState());
    ref.read(upLoadingProgressIndicatorPod.notifier).update(
          (state) => "Verifying your face... Please wait.",
        );
    final result = await ref.watch(loginRepoPod).faceMatchCheck(
          sourceImagePath: imagePath,
          userId: arg.documentUploadResponseModel.processId,
          cancelToken: ref.cancelToken(),
          onSendProgress: (count, total) {
            final percentage = ((count / total) * 100)
                .ceilToDouble()
                .toInt(); // Convert to integer
            print('Upload Progress: $percentage %');
            // ref.read(upLoadingProgressIndicatorPod.notifier).update(
            //       (state) => "Uploading Face Image $percentage %",
            //     );
          },
        );

    result.when(
      (success) {
        if (success) {
          //state = AsyncData(FaceVerifingSuccessState());
          if (arg.isDetailsEdited == true) {
            ref.read(autorouterProvider).replaceAll(
                [RegistrationSuccessRoute(isRegistrationPending: true)]);
          } else {
            ref.read(autorouterProvider).replaceAll(
                [RegistrationSuccessRoute(isRegistrationPending: false)]);
          }
        } else {
          ref.read(isPop.notifier).state = true;
          state = AsyncData(FacelivenessCheckerFaceNotMatchingState());
        }
      },
      (error) {
        ref.read(isPop.notifier).state = true;
        //log("Face Verify Error: $error");
        state = AsyncData(FacelivenessCheckerErrorState(error.toString()));
      },
    );
  }
}
