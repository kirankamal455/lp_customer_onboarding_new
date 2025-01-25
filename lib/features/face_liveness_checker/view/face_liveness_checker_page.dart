import 'dart:math';
import 'package:auto_route/auto_route.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lp_customer_onboarding/data/model/facelivenesess_pod_arg_model.dart';
import 'package:lp_customer_onboarding/data/model/faceliveness_arg.dart';
import 'package:lp_customer_onboarding/data/model/liveness_instruction_model.dart';
import 'package:lp_customer_onboarding/data/model/livenss_instruction_response_model.dart';
import 'package:lp_customer_onboarding/features/face_liveness_check_oz/controller/notfier/face_liveness_notifier.dart';
import 'package:lp_customer_onboarding/features/face_liveness_checker/controller/is_pop_pod.dart';
import 'package:lp_customer_onboarding/features/face_liveness_checker/controller/notifier/faceliveness_checker_notifier.dart';
import 'package:lp_customer_onboarding/features/face_liveness_checker/controller/video_path_pod.dart';
import 'package:lp_customer_onboarding/features/face_liveness_checker/state/face_liveness_checker_state.dart';
import 'package:lp_customer_onboarding/features/face_liveness_checker/view/ui_state/face_liveness_camara_exception.dart';
import 'package:lp_customer_onboarding/features/face_liveness_checker/view/ui_state/face_liveness_init_success.dart';
import 'package:lp_customer_onboarding/features/face_liveness_checker/view/ui_state/face_verify_error.dart';
import 'package:lp_customer_onboarding/features/face_liveness_checker/view/ui_state/face_liveness_error.dart';
import 'package:lp_customer_onboarding/features/face_liveness_checker/view/ui_state/face_liveness_checker_loading.dart';
import 'package:lp_customer_onboarding/features/face_liveness_checker/view/ui_state/face_liveness_warning.dart';

import 'package:velocity_x/velocity_x.dart';

@RoutePage()
class FaceLivenessCheckerPage extends StatefulWidget {
  final FaceLivenessArg faceLivenessArg;
  //final LivenssIntructionsResponseModel livenessInstructionModel;
  const FaceLivenessCheckerPage({
    super.key,
    required this.faceLivenessArg,
    //required this.livenessInstructionModel
  });

  @override
  State<FaceLivenessCheckerPage> createState() =>
      _FaceLivenessCheckerPageState();
}

class _FaceLivenessCheckerPageState extends State<FaceLivenessCheckerPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (_, WidgetRef ref, __) {
        return PopScope(
            canPop: ref.watch(isPop),
            child: Scaffold(
              // appBar: AppBar(
              //   systemOverlayStyle: const SystemUiOverlayStyle(
              //       statusBarIconBrightness: Brightness.dark),
              //   automaticallyImplyLeading: true,
              //   iconTheme: const IconThemeData(
              //     color: Colors.black,
              //   ),
              //   // title: const Text(
              //   //   "Face Liveness Check",
              //   //   style: TextStyle(color: Colors.white, fontSize: 20),
              //   // ),
              //   backgroundColor: Colors.transparent,
              // ),
              body: SafeArea(
                child: Center(
                  child: Consumer(
                    builder: (_, WidgetRef ref, __) {
                      print("audio check ${ref.watch(audioCheckPod)}");
                      print("random text ${ref.watch(randomTextPod)}");
                      final faceLivenessCheckerNotifierAsync = ref.watch(
                        faceLivenessCheckerNotifierPod(
                          FaceLivenessPodArgumentModel(
                            //  instructions: widget.livenessInstructionModel. data,
                            isDetailsEdited:
                                widget.faceLivenessArg.isDetailsEdited,
                            documentUploadResponseModel: widget
                                .faceLivenessArg.documentUploadResponseModel,
                          ),
                        ),
                      );
                      return faceLivenessCheckerNotifierAsync.when(
                        data: (data) {
                          return switch (data) {
                            FacelivenessCheckerInitState() =>
                              const Text("Init State"),
                            FacelivenessCheckerLoadingState() =>
                              const FaceLivenessCheckerLoading(),
                            FacelivenessCheckerInitSuccessState() =>
                              FaceLivenessIntitSuccess(
                                cameraController: data.cameraController,
                              ),
                            FacelivenessCheckerErrorState() =>
                              FaceLivenessError(
                                  faceLivenessArg: widget.faceLivenessArg),
                            FacelivenessCheckerFaildState() =>
                              FaceLivenessWarning(
                                faceLivenessArg: widget.faceLivenessArg,
                                liveFaceResponseModel:
                                    data.liveFaceResponseModel,
                              ),
                            FacelivenessCheckerFaceNotMatchingState() =>
                              FaceVerifyError(
                                faceLivenessArg: widget.faceLivenessArg,
                              ),
                            FacelivenessCamaraExceptionState() =>
                              const FaceLivenessCamaraPermissionDenied(),
                          };
                        },
                        error: (error, stackTrace) => Text(error.toString()),
                        loading: () => const CircularProgressIndicator()
                            .h(40)
                            .w(40)
                            .centered(),
                      );
                    },
                  ),
                ),
              ),
            ));
      },
    );
  }
}
