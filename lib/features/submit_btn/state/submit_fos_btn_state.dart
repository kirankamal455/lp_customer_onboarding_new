sealed class SubmitFOSBtnState {}

class InitialSubmitFOSBtnState extends SubmitFOSBtnState {
  InitialSubmitFOSBtnState();
}

// class FetchLocationLoadingState extends SubmitFOSBtnState {}

class SubmitFOSBtnLoadingState extends SubmitFOSBtnState {
  final int percentage;
  SubmitFOSBtnLoadingState({required this.percentage});
}

class SubmitFOSBtnSuccessState extends SubmitFOSBtnState {
  SubmitFOSBtnSuccessState();
}

class SubmitFOSBtnErrorState extends SubmitFOSBtnState {
  final String? errorMessage;
  SubmitFOSBtnErrorState(this.errorMessage);
}
