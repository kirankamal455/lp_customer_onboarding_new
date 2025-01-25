import 'dart:async';

import 'package:camera/camera.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Provider for video file path
final videoFilePathPod = StateProvider.autoDispose<String>((ref) {
  return ""; // Initial empty string for video file path
});

// Provider for countdown value
final countdownPod = StateProvider.autoDispose<int>((ref) {
  return 4; // Initial countdown value
});

// Provider for instruction index
final instructionIndexPod = StateProvider<int>((ref) {
  return 0;
}, name: 'instructionIndexPod');

// Provider for current instruction string
final currentInstructionPod = StateProvider.autoDispose<String>(
  (ref) {
    return "";
  },
  name: 'currentInstructionPod',
);

final cameraControllerPod =
    FutureProvider.autoDispose<CameraController?>((ref) async {
  CameraController? controller;

  try {
    // Initialize the camera
    final cameras = await availableCameras();
    final frontCamera = cameras.firstWhere(
      (camera) => camera.lensDirection == CameraLensDirection.front,
    );

    controller = CameraController(
      frontCamera,
      ResolutionPreset.low,
    );

    await controller.initialize();

    ref.onDispose(() async {
      if (controller != null) {
        // if (controller.value.isRecordingVideo) {
        await controller.stopVideoRecording();
        // }
      }

      await controller?.dispose();
    });

    return controller;
  } catch (e) {
    rethrow;
  }
});

// Provider for the completion status
final isCompletedPod = StateProvider.autoDispose<bool>((ref) {
  return false; // Initially not completed
});
final audioCheckPod = StateProvider.autoDispose<bool>((ref) {
  return false; // Initially not completed
});
final hideTimerPod = StateProvider.autoDispose<bool>((ref) {
  return false; // Initially not completed
});
// Provider for enabling random text
final isEnableRandomTextPod = StateProvider.autoDispose<bool>((ref) {
  return false; // Initially not enabling random text
});

// Provider for random text
final randomTextPod = StateProvider.autoDispose<String>((ref) {
  return ""; // Initial empty string for random text
});
final upLoadingProgressIndicatorPod = StateProvider.autoDispose<String>((ref) {
  return ""; // Initial empty string for random text
});
// Provider for the timer (Optional, if needed for controlling the timer state)
final timerPod = StateProvider.autoDispose<Timer?>((ref) {
  return null; // Timer can be null initially, meaning no timer is active
});

/// The stream provider that emits the countdown every second.

// final timerStreamProvider = StreamProvider.autoDispose<int>(
//   (ref) {
//     final streamController = StreamController<int>();
//     final subscription =
//         Stream.periodic(const Duration(seconds: 1), (count) => count)
//             .listen((elapsedTime) {
//       streamController.add(elapsedTime);
//     });

//     ref.onCancel(() async {
//       await subscription.cancel();
//       await streamController.close();
//     });
//     ref.onDispose(() async {
//       await subscription.cancel();
//       await streamController.close();
//     });
//     return streamController.stream;
//   },
//   name: 'timerProvider',
// );

class TimerStreamNotifier extends AutoDisposeStreamNotifier<int> {
  late final StreamController<int> _streamController;
  late final StreamSubscription<int> _subscription;

  @override
  Stream<int> build() {
    _streamController = StreamController<int>();
    _subscription =
        Stream.periodic(const Duration(seconds: 1), (count) => count)
            .listen((elapsedTime) {
      _streamController.add(elapsedTime);
    });

    return _streamController.stream;
  }

  // ref.onCancel(() async {
  //   await subscription.cancel();
  //   await streamController.close();
  // });
  // ref.onDispose(() async {
  //   await subscription.cancel();
  //   await streamController.close();
  // });
  Future<void> close() async {
    await _subscription.cancel();
    await _streamController.close();
  }
}

final timerStreamNotifierProvider =
    AutoDisposeStreamNotifierProvider<TimerStreamNotifier, int>(
        TimerStreamNotifier.new);
