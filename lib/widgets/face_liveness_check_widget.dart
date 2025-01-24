import 'dart:async';
import 'dart:math';

import 'package:camera/camera.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:lp_customer_onboarding/data/model/live_face_response_model.dart';
 import 'package:lp_customer_onboarding/data/model/liveness_instruction_model.dart';
import 'package:lp_customer_onboarding/data/model/liveness_instruction_model.dart';
import 'package:lp_customer_onboarding/data/model/livenss_instruction_response_model.dart';

import 'package:path_provider/path_provider.dart';
import 'package:video_compress/video_compress.dart';

import 'dart:async';
import 'dart:math';

import 'package:camera/camera.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'package:path_provider/path_provider.dart';
import 'package:video_compress/video_compress.dart';

class CameraPreviewScreen extends StatefulWidget {
  // final List<bool> instructionEnabled;
  final List<Instructions> instructions;
  final List<String> wordsToSpeak;
  final Function(LiveFaceResponseModel) faceVerificationSuccess;
  final Function(String) faceVerificationError;

  const CameraPreviewScreen({
    super.key,
    // required this.instructionEnabled,
    required this.instructions,
    required this.wordsToSpeak,
    required this.faceVerificationSuccess,
    required this.faceVerificationError,
  });

  @override
  State<CameraPreviewScreen> createState() => _CameraPreviewScreenState();
}

class _CameraPreviewScreenState extends State<CameraPreviewScreen> {
  late CameraController _cameraController;
  String _currentInstruction = "";
  late Timer _timer;
  late XFile _videoFile;

  int _countdown = 5;
  final int _speakTimeout = 6;
  bool _hideTimer = false;
  bool _isLoading = true;
  bool _isCompleted = false;
  bool _isEnableRandomText = false;

  String _videoFilePath = '';
  String _randomText = '';
  int _instructionIndex = 0;
  String _apiResult = '';
  final bool _livenessStatus = false;

  final Dio _dio = Dio();

  @override
  void initState() {
    super.initState();

    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    try {
      final cameras = await availableCameras();
      final frontCamera = cameras.firstWhere(
          (camera) => camera.lensDirection == CameraLensDirection.front);

      _cameraController = CameraController(frontCamera, ResolutionPreset.max);
      await _cameraController.initialize();

      final directory = await getApplicationDocumentsDirectory();
      _videoFilePath = '${directory.path}/liveness_test_video.mp4';
      await _cameraController.startVideoRecording();

      setState(() {
        _isLoading = false;
        _randomText =
            widget.wordsToSpeak[Random().nextInt(widget.wordsToSpeak.length)];
      });

      _updateInstruction();
    } catch (e) {
      _handleError('Error initializing camera: $e');
    }
  }

  void _updateInstruction() {
    _hideTimer = true;

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _hideTimer = false;

      if (_countdown == 1 && _instructionIndex < widget.instructions.length) {
        _moveToNextInstruction();
      } else if (!_isCompleted) {
        _updateCountdown();
      }
    });
  }

  void _moveToNextInstruction() {
    setState(() {
      _instructionIndex++;
      // _skipToNextEnabledInstruction();

      if (_instructionIndex >= widget.instructions.length) {
        _onInstructionsCompleted();
      } else {
        _countdown = 4;
        _currentInstruction =
            widget.instructions[_instructionIndex]. featureName;
      }
    });
  }

  // void _skipToNextEnabledInstruction() {
  //   while (_instructionIndex < widget.instructions.length &&
  //       !widget.instructions[_instructionIndex].enabled) {
  //     _instructionIndex++;
  //   }
  // }

  void _onInstructionsCompleted() {
    setState(() {
      _isCompleted = true;
      _currentInstruction = "Please Wait...";
      _hideTimer = true;
      _timer.cancel();
      _stopRecordingAndNavigate();
    });
  }

  void _updateCountdown() {
    setState(() {
      _countdown--;
      //_skipToNextEnabledInstruction();
      _currentInstruction = widget.instructions[_instructionIndex].featureName;
      print("instruction index : $_currentInstruction");
      if (_currentInstruction.contains("Speak the words below")) {
        print("instruction  Executed");
        _isEnableRandomText = true;
      } else {
        _isEnableRandomText = false;
      }
    });
  }

  Future<void> _stopRecordingAndNavigate() async {
    try {
      final file = await _cameraController.stopVideoRecording();
      setState(() {
        _videoFile = file;
      });
      _processVideo();
    } catch (e) {
      _handleError('Error stopping video recording: $e');
    }
  }

  Future<void> _processVideo() async {
    setState(() {
      _isLoading = true;
      _apiResult = '';
    });

    try {
      String? compressedVideoPath = await _compressVideo(_videoFile.path);
      if (compressedVideoPath == null) {
        setState(() {
          _isLoading = false;
        });
        return;
      }

      await _uploadVideo(compressedVideoPath);
    } catch (e) {
      _handleError('Error processing video: $e');
    }
  }

  Future<String?> _compressVideo(String videoPath) async {
    try {
      var mediaInfo = await VideoCompress.compressVideo(
        videoPath,
        quality: VideoQuality.LowQuality,
        deleteOrigin: false,
      );

      if (mediaInfo != null) {
        return mediaInfo.file?.path;
      } else {
        throw Exception('Video compression failed');
      }
    } catch (e) {
      _handleError('Error compressing video: $e');
      return null;
    }
  }

  Future<void> _uploadVideo(String compressedVideoPath) async {
    var headers = {
      'Content-Type': 'multipart/form-data',
      'Accept': 'application/json',
    };

    var data = FormData.fromMap({
      'file': [await MultipartFile.fromFile(compressedVideoPath)],
    });

    try {
      var url =
          'https://api.faceonlive.dev-lplusltd.com/FaceLiveDetection/VideoUpload?ReferenceText=$_randomText&NeedAudioCheck=$_isEnableRandomText';

      print("Url is :$url");
      var response = await _dio.post(
        url,
        options: Options(headers: headers),
        data: data,
        onSendProgress: (count, total) {
          double progress = (count / total) * 100;
          print('Upload Progress: ${progress.toStringAsFixed(2)}%');
        },
      );

      if (response.statusCode == 200) {
        setState(() {
          _isLoading = false;
        });
        widget.faceVerificationSuccess(
            LiveFaceResponseModel.fromMap(response.data));
      } else {
        _handleError('Error: ${response.statusMessage}');
      }
    } catch (e) {
      _handleError('Error uploading video: $e');
    }
  }

  void _handleError(String errorMessage) {
    print(errorMessage);
    setState(() {
      _isLoading = false;
      widget.faceVerificationError(errorMessage);
    });
  }

  @override
  void dispose() {
    super.dispose();
    _cameraController.dispose();
    _timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Stack(
              alignment: Alignment.center,
              children: [
                const Align(
                  alignment: Alignment.topCenter,
                  child: Text(
                    "Face Liveness Check",
                    style: TextStyle(color: Colors.black, fontSize: 20),
                  ),
                ),
                Container(
                  width: 300,
                  height: 400,
                  decoration: BoxDecoration(
                    color: const Color(0xff7c94b6),
                    borderRadius:
                        const BorderRadius.all(Radius.elliptical(300, 400)),
                    border: Border.all(
                      color: Colors.green,
                      width: 4.0,
                    ),
                  ),
                  child: ClipOval(
                    child: SizedBox(
                      width: 280,
                      height: 360,
                      child: CameraPreview(_cameraController),
                    ),
                  ),
                ),
                // Center(
                //   child: ClipOval(
                //     child: SizedBox(
                //       width: 280,
                //       height: 360,
                //       child: CameraPreview(_cameraController),
                //     ),
                //   ),
                // ),
                Align(
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(_currentInstruction,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.white)),
                      const SizedBox(height: 20),
                      _hideTimer
                          ? const SizedBox.shrink()
                          : Text(
                              '$_countdown seconds',
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red),
                            ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
                Positioned(
                  bottom: 50,
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Text(
                      _isEnableRandomText ? _randomText : "",
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
