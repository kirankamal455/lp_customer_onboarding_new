sealed class UpdateDocumentBtnState {}

class InitialUpdateDocumentBtnState extends UpdateDocumentBtnState {
  InitialUpdateDocumentBtnState();
}

// class FetchLocationLoadingState extends SubmitFOSBtnState {}

class SubmitUpdateDocumentBtnLoadingState extends UpdateDocumentBtnState {
  SubmitUpdateDocumentBtnLoadingState();
}

class SubmitUpdateDocumentBtnSuccessState extends UpdateDocumentBtnState {
  SubmitUpdateDocumentBtnSuccessState();
}

class SubmitUpdateDocumentBtnErrorState extends UpdateDocumentBtnState {
  final String? errorMessage;
  SubmitUpdateDocumentBtnErrorState(this.errorMessage);
}
