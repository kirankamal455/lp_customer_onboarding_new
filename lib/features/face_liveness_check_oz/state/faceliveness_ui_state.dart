import 'package:lp_customer_onboarding/core/enums/faceliveness_check_enums.dart';

sealed class FacelivenessUiState {}

class FacelivenessInitState extends FacelivenessUiState {}

class FacelivenessRunningState extends FacelivenessUiState {}

class FacelivenessLoadingState extends FacelivenessUiState {}

class FacelivenessSuccessState extends FacelivenessUiState {
  final String imagePath;

  FacelivenessSuccessState(this.imagePath);
}

class FacelivenessErrorState extends FacelivenessUiState {
  final FaceLivenessErrors faceLivenessErrors;

  FacelivenessErrorState(this.faceLivenessErrors);
}

class FacelivenessRegistraionReviewState extends FacelivenessUiState {
  FacelivenessRegistraionReviewState();
}

class FacelivenessWarningErrorState extends FacelivenessUiState {
  final FaceLivenessErrors faceLivenessWarningErrors;

  FacelivenessWarningErrorState(this.faceLivenessWarningErrors);
}

class FacelivenessAnalizingState extends FacelivenessUiState {}

class FacelivenessPermissionErrorState extends FacelivenessUiState {
  final String permissionMessage;

  FacelivenessPermissionErrorState(this.permissionMessage);
}

class FaceVerifingLoadingState extends FacelivenessUiState {}

class FaceVerifingErrorState extends FacelivenessUiState {
  final FaceLivenessErrors faceLivenessErrors;
  FaceVerifingErrorState(this.faceLivenessErrors);
}

class FaceVerifingSuccessState extends FacelivenessUiState {}
