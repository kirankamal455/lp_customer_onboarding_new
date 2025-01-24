import 'dart:async';
import 'dart:math';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:lp_customer_onboarding/bootstrap.dart';
import 'package:lp_customer_onboarding/features/custom_video_screen/controller/custom_video_pod.dart';
import 'package:lp_customer_onboarding/features/custom_video_screen/controller/video_submit_btn_pod.dart';
import 'package:lp_customer_onboarding/shared/pods/user_register_pod.dart';
import 'package:lp_customer_onboarding/widgets/action_button.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:video_player/video_player.dart';

class CustomVideoPage extends ConsumerStatefulWidget {
  final Function() onSubmitVideo;
  const CustomVideoPage({required this.onSubmitVideo, super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CustomVideoPageState();
}

class _CustomVideoPageState extends ConsumerState<CustomVideoPage>
    with WidgetsBindingObserver, TickerProviderStateMixin {
  CameraController? controller;
  XFile? imageFile;
  XFile? videoFile;
  VideoPlayerController? videoController;
  VoidCallback? videoPlayerListener;
  bool enableAudio = true;
  late AnimationController _flashModeControlRowAnimationController;
  late AnimationController _exposureModeControlRowAnimationController;
  late AnimationController _focusModeControlRowAnimationController;
  final double _minAvailableZoom = 1.0;
  final double _maxAvailableZoom = 1.0;
  double _currentScale = 1.0;
  double _baseScale = 1.0;
  final DateTime _currentDate = DateTime.now();
  int _counter = 0;

  // Counting pointers (number of user fingers on screen)
  int _pointers = 0;

  String? _formattedDate;

  // Initialize necessary variables and controllers
  @override
  void initState() {
    super.initState();
    _ambiguate(WidgetsBinding.instance)?.addObserver(this);
    _formattedDate = DateFormat.yMMMMd().format(_currentDate);

    // Initialize animation controllers
    _flashModeControlRowAnimationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _exposureModeControlRowAnimationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _focusModeControlRowAnimationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    // Get available cameras and select the front camera
    getCameras();
  }

  getCameras() async {
    try {
      WidgetsFlutterBinding.ensureInitialized();
      cameras = await availableCameras();
      if (cameras.isNotEmpty) {
        onNewCameraSelected(cameras.last); // Use the first available camera
      } else {
        throw Exception('No cameras available.');
      }
    } on CameraException catch (e) {
      logError(e.code, e.description);
    }
  }

  // Auto stop video recording after a set time
  Timer? _timer;
  autoStopRecording() {
    _counter = 7;
    if (_timer != null) {
      _timer!.cancel();
    }
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_counter > 0) {
          _counter--;
        } else {
          if (controller != null &&
              controller!.value.isInitialized &&
              controller!.value.isRecordingVideo) {
            onStopButtonPressed();
          }
          _timer!.cancel();
        }
      });
    });
  }

  // Dispose resources when leaving the page
  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _focusModeControlRowAnimationController.dispose();
    _flashModeControlRowAnimationController.dispose();
    _exposureModeControlRowAnimationController.dispose();
    controller?.dispose();
    super.dispose();
  }

  // Manage camera lifecycle
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    final CameraController? cameraController = controller;

    // App state changed before we got the chance to initialize.
    if (cameraController == null || !cameraController.value.isInitialized) {
      return;
    }

    if (state == AppLifecycleState.inactive) {
      cameraController.dispose();
    } else if (state == AppLifecycleState.resumed) {
      onNewCameraSelected(cameraController.description);
    }
  }

  // Update the state of the video capture button and manage UI changes
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: const Text('face video record'),
      ),
      body: Column(
        children: <Widget>[
          const Spacer(),
          _cameraPreviewWidget(),

          Container(
            width: context.screenWidth * 1,
            decoration: const BoxDecoration(color: Colors.white70),
            padding: const EdgeInsets.all(12),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Consumer(
                    builder: (_, WidgetRef ref, __) {
                      final firstName = ref.watch(userRegisterProvider).fname;
                      return Text(
                        // 'I am ${_customerName.trim()}, and today is the 26th day of March 2021.',
                        'I am  $firstName, and today is the $_formattedDate',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold),
                      );
                    },
                  ),
                ),

                // Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.fiber_manual_record_sharp,
                      color: Colors.redAccent,
                    ),
                    Text('00: 0$_counter'),
                  ],
                ),
                const Gap(10),
                Consumer(
                  builder: (_, WidgetRef ref, __) {
                    final isEnableVideoSubmitBtn = ref.watch(videoSubmitBtnPod);
                    return ActionButton(
                      onPressed: () async {
                        if (controller != null &&
                            controller!.value.isInitialized &&
                            !controller!.value.isRecordingVideo) {
                          onVideoRecordButtonPressed();
                          autoStopRecording();
                        }
                      },
                      buttonText: isEnableVideoSubmitBtn
                          ? 'Restart Recording'
                          : 'Start Recording',
                      buttonEnabled: _counter == 0 ? true : false,
                    );
                  },
                ),
                const Gap(10),
                Consumer(
                  builder: (_, WidgetRef ref, __) {
                    final isEnableVideoSubmitBtn = ref.watch(videoSubmitBtnPod);
                    return ActionButton(
                      onPressed: isEnableVideoSubmitBtn
                          ? () {
                              widget.onSubmitVideo();
                            }
                          : null,
                      buttonText: 'Submit Video',
                      buttonEnabled: isEnableVideoSubmitBtn,
                    );
                  },
                ),
                const Gap(20),
              ],
            ),
          )
          // Expanded(
          //   child: Container(
          //     decoration: BoxDecoration(
          //       color: Colors.black,
          //       border: Border.all(
          //         color:
          //             controller != null && controller!.value.isRecordingVideo
          //                 ? Colors.redAccent
          //                 : Colors.grey,
          //         width: 3.0,
          //       ),
          //     ),
          //     child: Padding(
          //       padding: const EdgeInsets.all(1.0),
          //       child: Center(
          //         child: _cameraPreviewWidget(),
          //       ),
          //     ),
          //   ),
          // ),
          // _captureControlRowWidget(),
          // _modeControlRowWidget(),
          // Padding(
          //   padding: const EdgeInsets.all(5.0),
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.start,
          //     children: <Widget>[
          //       _cameraTogglesRowWidget(),
          //       _thumbnailWidget(),
          //     ],
          //   ),
          // ),
        ],
      ),
    );
  }

  /// Display the preview from the camera (or a message if the preview is not available).
  Widget _cameraPreviewWidget() {
    final CameraController? cameraController = controller;

    if (cameraController == null || !cameraController.value.isInitialized) {
      return const CircularProgressIndicator();
      // const Text(
      //   'Tap a camera',
      //   style: TextStyle(
      //     color: Colors.white,
      //     fontSize: 24.0,
      //     fontWeight: FontWeight.w900,
      //   ),
      // );
    } else {
      return Listener(
        onPointerDown: (_) => _pointers++,
        onPointerUp: (_) => _pointers--,
        child: Container(
          width: 280,
          height: 350,
          decoration: BoxDecoration(
            color: const Color(0xff7c94b6),
            borderRadius: const BorderRadius.all(Radius.elliptical(280, 350)),
            border: Border.all(
              color: controller != null && controller!.value.isRecordingVideo
                  ? Colors.red
                  : context.primaryColor,
              width: 4.0,
            ),
          ),
          child: ClipOval(
            child: SizedBox(
              width: 280,
              height: 360,
              child: Transform(
                alignment: Alignment.center,
                transform: Matrix4.rotationY(pi),
                child: CameraPreview(
                  controller!,
                  child: LayoutBuilder(builder:
                      (BuildContext context, BoxConstraints constraints) {
                    return GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onScaleStart: _handleScaleStart,
                      onScaleUpdate: _handleScaleUpdate,
                      onTapDown: (details) =>
                          onViewFinderTap(details, constraints),
                    );
                  }),
                ),
              ),
            ),
          ),
        ),
      );
    }
  }

  void _handleScaleStart(ScaleStartDetails details) {
    _baseScale = _currentScale;
  }

  Future<void> _handleScaleUpdate(ScaleUpdateDetails details) async {
    // When there are not exactly two fingers on screen don't scale
    if (controller == null || _pointers != 2) {
      return;
    }

    _currentScale = (_baseScale * details.scale)
        .clamp(_minAvailableZoom, _maxAvailableZoom);

    await controller!.setZoomLevel(_currentScale);
  }

  String timestamp() => DateTime.now().millisecondsSinceEpoch.toString();

  void showInSnackBar(String message) {
    // ignore: deprecated_member_use
    // _scaffoldKey.currentState?.showSnackBar(SnackBar(content: Text(message)));
  }

  void onViewFinderTap(TapDownDetails details, BoxConstraints constraints) {
    if (controller == null) {
      return;
    }

    final CameraController cameraController = controller!;

    final offset = Offset(
      details.localPosition.dx / constraints.maxWidth,
      details.localPosition.dy / constraints.maxHeight,
    );
    cameraController.setExposurePoint(offset);
    cameraController.setFocusPoint(offset);
  }

  void onNewCameraSelected(CameraDescription cameraDescription) async {
    if (controller != null) {
      await controller!.dispose();
    }
    final CameraController cameraController = CameraController(
      cameraDescription,
      ResolutionPreset.low,
      enableAudio: enableAudio,
      imageFormatGroup: ImageFormatGroup.jpeg,
    );
    controller = cameraController;

    // If the controller is updated then update the UI.
    cameraController.addListener(() {
      if (mounted) setState(() {});
      if (cameraController.value.hasError) {
        showInSnackBar(
            'Camera error ${cameraController.value.errorDescription}');
      }
    });

    try {
      await cameraController.initialize();
    } on CameraException catch (e) {
      _showCameraException(e);
    }

    if (mounted) {
      setState(() {});
    }
  }

  void onTakePictureButtonPressed() {
    takePicture().then((XFile? file) {
      if (mounted) {
        setState(() {
          imageFile = file;
          videoController?.dispose();
          videoController = null;
        });
        if (file != null) showInSnackBar('Picture saved to ${file.path}');
      }
    });
  }

  void onFlashModeButtonPressed() {
    if (_flashModeControlRowAnimationController.value == 1) {
      _flashModeControlRowAnimationController.reverse();
    } else {
      _flashModeControlRowAnimationController.forward();
      _exposureModeControlRowAnimationController.reverse();
      _focusModeControlRowAnimationController.reverse();
    }
  }

  void onExposureModeButtonPressed() {
    if (_exposureModeControlRowAnimationController.value == 1) {
      _exposureModeControlRowAnimationController.reverse();
    } else {
      _exposureModeControlRowAnimationController.forward();
      _flashModeControlRowAnimationController.reverse();
      _focusModeControlRowAnimationController.reverse();
    }
  }

  void onFocusModeButtonPressed() {
    if (_focusModeControlRowAnimationController.value == 1) {
      _focusModeControlRowAnimationController.reverse();
    } else {
      _focusModeControlRowAnimationController.forward();
      _flashModeControlRowAnimationController.reverse();
      _exposureModeControlRowAnimationController.reverse();
    }
  }

  void onAudioModeButtonPressed() {
    enableAudio = !enableAudio;
    if (controller != null) {
      onNewCameraSelected(controller!.description);
    }
  }

  void onCaptureOrientationLockButtonPressed() async {
    if (controller != null) {
      final CameraController cameraController = controller!;
      if (cameraController.value.isCaptureOrientationLocked) {
        await cameraController.unlockCaptureOrientation();
        showInSnackBar('Capture orientation unlocked');
      } else {
        await cameraController.lockCaptureOrientation();
        showInSnackBar(
            'Capture orientation locked to ${cameraController.value.lockedCaptureOrientation.toString().split('.').last}');
      }
    }
  }

  void onSetFlashModeButtonPressed(FlashMode mode) {
    setFlashMode(mode).then((_) {
      if (mounted) setState(() {});
      showInSnackBar('Flash mode set to ${mode.toString().split('.').last}');
    });
  }

  void onSetExposureModeButtonPressed(ExposureMode mode) {
    setExposureMode(mode).then((_) {
      if (mounted) setState(() {});
      showInSnackBar('Exposure mode set to ${mode.toString().split('.').last}');
    });
  }

  void onSetFocusModeButtonPressed(FocusMode mode) {
    setFocusMode(mode).then((_) {
      if (mounted) setState(() {});
      showInSnackBar('Focus mode set to ${mode.toString().split('.').last}');
    });
  }

  void onVideoRecordButtonPressed() {
    ref.read(videoSubmitBtnPod.notifier).update((state) => false);

    startVideoRecording().then((_) {
      if (mounted) setState(() {});
    });
  }

  void onStopButtonPressed() {
    stopVideoRecording().then((file) {
      if (mounted) setState(() {});
      if (file != null) {
        videoFile = file;

        ref.read(customVideoPod.notifier).state = file;
        ref.read(videoSubmitBtnPod.notifier).update((state) => true);
      }
    });
  }

  void onPauseButtonPressed() {
    pauseVideoRecording().then((_) {
      if (mounted) setState(() {});
      showInSnackBar('Video recording paused');
    });
  }

  void onResumeButtonPressed() {
    resumeVideoRecording().then((_) {
      if (mounted) setState(() {});
      showInSnackBar('Video recording resumed');
    });
  }

  Future<void> startVideoRecording() async {
    final CameraController? cameraController = controller;

    if (cameraController == null || !cameraController.value.isInitialized) {
      showInSnackBar('Error: select a camera first.');
      return;
    }

    if (cameraController.value.isRecordingVideo) {
      // A recording is already started, do nothing.
      return;
    }

    try {
      await cameraController.startVideoRecording();
    } on CameraException catch (e) {
      _showCameraException(e);
      return;
    }
  }

  Future<XFile?> stopVideoRecording() async {
    final CameraController? cameraController = controller;

    if (cameraController == null || !cameraController.value.isRecordingVideo) {
      return null;
    }

    try {
      return cameraController.stopVideoRecording();
    } on CameraException catch (e) {
      _showCameraException(e);
      return null;
    }
  }

  Future<void> pauseVideoRecording() async {
    final CameraController? cameraController = controller;

    if (cameraController == null || !cameraController.value.isRecordingVideo) {
      return;
    }

    try {
      await cameraController.pauseVideoRecording();
    } on CameraException catch (e) {
      _showCameraException(e);
      rethrow;
    }
  }

  Future<void> resumeVideoRecording() async {
    final CameraController? cameraController = controller;

    if (cameraController == null || !cameraController.value.isRecordingVideo) {
      return;
    }

    try {
      await cameraController.resumeVideoRecording();
    } on CameraException catch (e) {
      _showCameraException(e);
      rethrow;
    }
  }

  Future<void> setFlashMode(FlashMode mode) async {
    if (controller == null) {
      return;
    }

    try {
      await controller!.setFlashMode(mode);
    } on CameraException catch (e) {
      _showCameraException(e);
      rethrow;
    }
  }

  Future<void> setExposureMode(ExposureMode mode) async {
    if (controller == null) {
      return;
    }

    try {
      await controller!.setExposureMode(mode);
    } on CameraException catch (e) {
      _showCameraException(e);
      rethrow;
    }
  }

  Future<void> setExposureOffset(double offset) async {
    if (controller == null) {
      return;
    }

    setState(() {});
    try {
      offset = await controller!.setExposureOffset(offset);
    } on CameraException catch (e) {
      _showCameraException(e);
      rethrow;
    }
  }

  Future<void> setFocusMode(FocusMode mode) async {
    if (controller == null) {
      return;
    }

    try {
      await controller!.setFocusMode(mode);
    } on CameraException catch (e) {
      _showCameraException(e);
      rethrow;
    }
  }

  Future<XFile?> takePicture() async {
    final CameraController? cameraController = controller;
    if (cameraController == null || !cameraController.value.isInitialized) {
      showInSnackBar('Error: select a camera first.');
      return null;
    }

    if (cameraController.value.isTakingPicture) {
      // A capture is already pending, do nothing.
      return null;
    }

    try {
      XFile file = await cameraController.takePicture();
      return file;
    } on CameraException catch (e) {
      _showCameraException(e);
      return null;
    }
  }

  void _showCameraException(CameraException e) {
    logError(e.code, e.description);
    showInSnackBar('Error: ${e.code}\n${e.description}');
  }
}

// class CameraApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: CustomVideoScreen(),
//     );
//   }
// }

List<CameraDescription> cameras = [];

// Future<void> main() async {
//   // Fetch the available cameras before initializing the app.
//   try {
//     WidgetsFlutterBinding.ensureInitialized();
//     cameras = await availableCameras();
//   } on CameraException catch (e) {
//     logError(e.code, e.description);
//   }
//   // runApp(CameraApp());
// }

/// This allows a value of type T or T? to be treated as a value of type T?.
///
/// We use this so that APIs that have become non-nullable can still be used
/// with `!` and `?` on the stable branch.
T? _ambiguate<T>(T? value) => value;
IconData getCameraLensIcon(CameraLensDirection direction) {
  switch (direction) {
    case CameraLensDirection.back:
      return Icons.camera_rear;
    case CameraLensDirection.front:
      return Icons.camera_front;
    case CameraLensDirection.external:
      return Icons.camera;
    default:
      throw ArgumentError('Unknown lens direction');
  }
}

void logError(String code, String? message) {
  if (message != null) {
    talker.log('Error: $code\nError Message: $message');
  } else {
    talker.log('Error: $code');
  }
}
