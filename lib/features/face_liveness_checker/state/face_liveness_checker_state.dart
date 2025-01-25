import 'package:camera/camera.dart';
import 'package:lp_customer_onboarding/core/enums/faceliveness_check_enums.dart';
import 'package:lp_customer_onboarding/data/model/live_face_response_model.dart';

sealed class FaceLivenessCheckerState {}

class FacelivenessCheckerInitState extends FaceLivenessCheckerState {}

//class FacelivenessCheckerRunningState extends FaceLivenessCheckerState {}

class FacelivenessCheckerLoadingState extends FaceLivenessCheckerState {}

class FacelivenessCheckerInitSuccessState extends FaceLivenessCheckerState {
  final CameraController cameraController;

  FacelivenessCheckerInitSuccessState({required this.cameraController});
}

class FacelivenessCheckerErrorState extends FaceLivenessCheckerState {
  final String faceLivenessErrors;

  FacelivenessCheckerErrorState(this.faceLivenessErrors);
}

class FacelivenessCamaraExceptionState extends FaceLivenessCheckerState {
  final String camaraException;

  FacelivenessCamaraExceptionState(this.camaraException);
}

class FacelivenessCheckerFaildState extends FaceLivenessCheckerState {
  final LiveFaceResponseModel liveFaceResponseModel;
  FacelivenessCheckerFaildState(this.liveFaceResponseModel);
}

class FacelivenessCheckerFaceNotMatchingState extends FaceLivenessCheckerState {
  FacelivenessCheckerFaceNotMatchingState();
}

// class FacelivenessCheckerVideoUploadSuccessState
//     extends FaceLivenessCheckerState {
//   final LiveFaceResponseModel liveFaceResponseModel;
//   FacelivenessCheckerVideoUploadSuccessState(
//       {required this.liveFaceResponseModel});
// }
// class FacelivenessRegistraionReviewState extends FaceLivenessCheckerState {
//   FacelivenessRegistraionReviewState();
// }

// class FacelivenessWarningErrorState extends FaceLivenessCheckerState {
//   final FaceLivenessErrors faceLivenessWarningErrors;

//   FacelivenessWarningErrorState(this.faceLivenessWarningErrors);
// }

// class FacelivenessAnalizingState extends FaceLivenessCheckerState {}

// class FacelivenessPermissionErrorState extends FaceLivenessCheckerState {
//   final String permissionMessage;

//   FacelivenessPermissionErrorState(this.permissionMessage);
// }

// class FaceVerifingLoadingState extends FaceLivenessCheckerState {}

// class FaceVerifingErrorState extends FaceLivenessCheckerState {
//   final FaceLivenessErrors faceLivenessErrors;
//   FaceVerifingErrorState(this.faceLivenessErrors);
// }

// class FaceVerifingSuccessState extends FaceLivenessCheckerState {}
