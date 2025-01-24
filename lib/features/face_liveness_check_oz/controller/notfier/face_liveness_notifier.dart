// // ignore_for_file: public_member_api_docs, sort_constructors_first
// import 'dart:async';
// import 'dart:developer';

// import 'package:flutter/services.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:ozsdk/ozsdk.dart';

// import 'package:lp_customer_onboarding/bootstrap.dart';
// import 'package:lp_customer_onboarding/core/enums/faceliveness_check_enums.dart';
// import 'package:lp_customer_onboarding/core/router/router.gr.dart';
// import 'package:lp_customer_onboarding/core/router/router_pod.dart';
// import 'package:lp_customer_onboarding/data/repositories/login/login_repo_pod.dart';
// import 'package:lp_customer_onboarding/features/face_liveness_check_oz/controller/liveness_stream_pod.dart';
// import 'package:lp_customer_onboarding/features/face_liveness_check_oz/view/ui_state/faceliveness_ui_state.dart';

 

// final faceLivenessStreamProvider = StreamProvider<List<Media>>((ref) {
//   return OZSDK.livenessResult;
// });

// final faceLivenessProvider = AutoDisposeAsyncNotifierProviderFamily<
//     FaceLivenessNotifier, FacelivenessUiState, FaceLivenessArg>(
//   FaceLivenessNotifier.new,
// );

// class FaceLivenessNotifier extends AutoDisposeFamilyAsyncNotifier<
//     FacelivenessUiState, FaceLivenessArg> {
//   FaceLivenessNotifier() : super();

//   String imagePath = "";

//   @override
//   Future<FacelivenessUiState> build(arg) async {
//     await initSDK();
//     listenToLivenessStream();
//     return FacelivenessInitState();
//   }

//   Future<void> initSDK() async {
//     try {
//       final isSuccess = await OZSDK.initSDK(["assets/license.json"]);

//       if (isSuccess) {
//         await OZSDK.setUICustomization(
//           UICustomization(
//             centerHintCustomization: CenterHintCustomization(
//               textSize: 22,
//               centerBackground: false,
//             ),
//             hideStatusBar: true,
//             versionLabelCustomization: VersionLabelCustomization(
//               textAlpha: 0,
//               textSize: 2,
//             ),
//             faceFrameCustomization: FaceFrameCustomization(
//               strokeFaceAlignedColor: "green",
//               strokeFaceNotAlignedColor: "red",
//               strokeWidth: 4,
//               geometryType: GeometryType.oval,
//             ),
//           ),
//         );
//       } else {
//         talker.error("SDK initialization failed");
//         state =
//             AsyncData(FacelivenessErrorState(FaceLivenessErrors.sdkInitFailed));
//       }
//     } catch (e) {
//       talker.error("SDK initialization error: $e");
//       state =
//           AsyncData(FacelivenessErrorState(FaceLivenessErrors.sdkInitFailed));
//     }
//   }

//   void startLiveness() async {
//     state = AsyncData(FacelivenessLoadingState());

//     try {
//       OZSDK.startLiveness(
//         [
//           VerificationAction.smile,
//           VerificationAction.eyeBlink,
//           VerificationAction.headLeft,
//           VerificationAction.headRight,
//           VerificationAction.headUp,
//           VerificationAction.headDown,
//         ],
//         false,
//       );
//     } catch (e) {
//       log("Error starting liveness: $e");
//       talker.error("Error starting liveness: $e");
//       state = AsyncData(
//           FacelivenessErrorState(FaceLivenessErrors.startLivenessError));
//     }
//   }

//   void runAnalysis(List<Media> media) async {
//     try {
//       final analysis = Analysis(
//         Type.quality,
//         Mode.onDevice,
//         media,
//         {},
//       );
//       state = AsyncData(FacelivenessAnalizingState());
//       final result = await OZSDK.analyze([analysis]);

//       if (result.first.resolution == Resolution.success) {
//         imagePath = media
//             .where((m) => m.tag.toString() == "MediaTag.videoSelfieSmile")
//             .toList()
//             .first
//             .bestShotPath
//             .toString();

//         state = AsyncData(FacelivenessSuccessState(imagePath));
//         await verifyFace();
//       } else if (result.first.resolution == Resolution.declined) {
//         talker.error("Error analyzing media : ${result.first.resolution} ");
//         state = AsyncData(
//             FacelivenessWarningErrorState(FaceLivenessErrors.analysisDeclined));
//       } else if (result.first.resolution == Resolution.failed) {
//         talker.error("Error analyzing media : ${result.first.resolution} ");
//         state = AsyncData(
//             FacelivenessWarningErrorState(FaceLivenessErrors.analysisDeclined));
//       } else {
//         talker.error("Error analyzing media : ${result.first.resolution} ");
//         state = AsyncData(
//             FacelivenessErrorState(FaceLivenessErrors.somethingWentWrong));
//       }
//     } catch (e) {
//       log("analyzing media Error: $e");
//       talker.error("  analyzing media Error: $e");
//       state = AsyncData(
//           FacelivenessErrorState(FaceLivenessErrors.somethingWentWrong));
//     }
//   }

//   void listenToLivenessStream() {
//     ref.listen(livenessStreamProvider, (previous, next) {
//       next.when(
//         data: (data) {
//           runAnalysis(data);
//         },
//         error: (error, stackTrace) {
//           talker.error("liveness platform exception : $error ");
//           if (error is PlatformException) {
//             log("Error: ${error.message.toString()}");
//             if (error.message.toString() == "USER_CANCELLED") {
//               state = AsyncData(FacelivenessInitState());
//             } else {
//               state = AsyncData(FacelivenessErrorState(
//                   FaceLivenessErrors.somethingWentWrong));
//             }
//           }
//         },
//         loading: () {},
//       );
//     });
//   }

//   Future<void> verifyFace() async {
//     state = AsyncData(FacelivenessAnalizingState());
//     // state = AsyncData(FaceVerifingLoadingState());
//     final result = await ref.watch(loginRepoPod).faceMatchCheck(
//           sourceImagePath: imagePath,
//           userId: arg.userId,
//         );

//     result.when(
//       (success) {
//         if (success) {
//           //state = AsyncData(FaceVerifingSuccessState());
//           if (arg.isDetailsEdited = true) {
//             ref.read(autorouterProvider).replaceAll([
//               RegistrationSuccessRoute(
//                   isRegistrationPending: false)
//             ]);
//           } else {
//             ref.read(autorouterProvider).replaceAll([
//               RegistrationSuccessRoute(
//                   isRegistrationPending: true)
//             ]);
//           }
//         } else {
//           state = AsyncData(
//               FacelivenessWarningErrorState(FaceLivenessErrors.faceNotFound));
//         }
//       },
//       (error) {
//         log("Face Verify Error: $error");
//         state = AsyncData(
//             FaceVerifingErrorState(FaceLivenessErrors.somethingWentWrong));
//       },
//     );
//   }
// }
