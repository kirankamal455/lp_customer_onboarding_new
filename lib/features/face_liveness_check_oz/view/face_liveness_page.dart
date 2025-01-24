// import 'package:auto_route/auto_route.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:lp_customer_onboarding/core/enums/enums.dart';
// import 'dart:io';
// import 'package:dio/dio.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:lp_customer_onboarding/features/face_liveness_check_oz/controller/notfier/face_liveness_notifier.dart';
// import 'package:lp_customer_onboarding/features/face_liveness_check_oz/view/ui_state/faceliveness_ui_state.dart';
// import 'package:lp_customer_onboarding/features/face_liveness_check_oz/view/widgets/face_verify_error_state.dart';
// import 'package:lp_customer_onboarding/features/face_liveness_check_oz/view/widgets/faceliveness_error_state.dart';
// import 'package:lp_customer_onboarding/features/face_liveness_check_oz/view/widgets/faceliveness_init_state.dart';
// import 'package:lp_customer_onboarding/features/face_liveness_check_oz/view/widgets/faceliveness_success_state.dart';
// import 'package:lp_customer_onboarding/features/face_liveness_check_oz/view/widgets/faceliveness_warning_error_state.dart';
// import 'package:lp_customer_onboarding/features/face_liveness_check_oz/view/widgets/init_loading_state.dart';
// import 'package:lp_customer_onboarding/features/face_liveness_check_oz/view/widgets/loading_page.dart';
// import 'package:lp_customer_onboarding/shared/helper/global_helper.dart';

// @RoutePage()
// class FaceLivenessPage extends StatefulWidget {
//   final FaceLivenessArg faceLivenessArg;
//   const FaceLivenessPage({
//     super.key,
//     required this.faceLivenessArg,
//   });

//   @override
//   State<FaceLivenessPage> createState() => _FaceLivenessPageState();
// }

// class _FaceLivenessPageState extends State<FaceLivenessPage> with GlobalHelper {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Face Liveness Verification'),
//         actions: [
//           // IconButton(
//           //     onPressed: () => onResetForm(), icon: const Icon(Icons.clear)),
//           IconButton(
//             onPressed: () {
//               onBackPressed();
//             },
//             icon: const Icon(Icons.logout),
//           )
//         ],
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Center(
//           child: Consumer(
//             builder: (_, WidgetRef ref, __) {
//               final facelivenessAsyncPod =
//                   ref.watch(faceLivenessProvider(widget.faceLivenessArg));
//               return facelivenessAsyncPod.when(
//                 data: (data) {
//                   switch (data.runtimeType) {
//                     case const (FacelivenessInitState):
//                       return FacelivenessInitStateWidget(
//                         faceLivenessArg: widget.faceLivenessArg,
//                       );
//                     case const (FacelivenessSuccessState):
//                       return const FaceLivenessSuccessStateWidget();
//                     case const (FacelivenessErrorState):
//                       return FaceLivenessErrorStateWidget(
//                         faceLivenessArg: widget.faceLivenessArg,
//                         faceLivenessErrors:
//                             (data as FacelivenessErrorState).faceLivenessErrors,
//                       );
//                     case const (FacelivenessLoadingState):
//                       return const InitLoadingPage();
//                     case const (FacelivenessAnalizingState):
//                       return const AnalizingResultStateWidget();
//                     case const (FaceVerifingErrorState):
//                       return FaceVerifyError(
//                         faceLivenessArg: widget.faceLivenessArg,
//                         faceLivenessErrors:
//                             (data as FaceVerifingErrorState).faceLivenessErrors,
//                       );

//                     case const (FacelivenessWarningErrorState):
//                       return FaceLivenessWarningErrorStateWidget(
//                         faceLivenessArg: widget.faceLivenessArg,
//                         faceLivenessErrors:
//                             (data as FacelivenessWarningErrorState)
//                                 .faceLivenessWarningErrors,
//                       );
//                     default:
//                       return Center(child: Text('Unexpected state. $data'));
//                   }
//                 },
//                 error: (error, stackTrace) {
//                   return Center(
//                     child: Text('Error: $error'),
//                   );
//                 },
//                 loading: () {
//                   return const Center(
//                     child: CircularProgressIndicator(),
//                   );
//                 },
//               );
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }
