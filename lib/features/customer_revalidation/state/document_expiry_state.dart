sealed class DocumentExpiryCheckState {}

//class DocumentExpiryInitialState extends DocumentExpiryCheckState {}

class DocumentNotExpiredState extends DocumentExpiryCheckState {
  final String docmentType;
  DocumentNotExpiredState({required this.docmentType});
}

class DocumentExpiredState extends DocumentExpiryCheckState {
  final String docmentType;
  final bool isDocumentIntelligenceEnabled;
  DocumentExpiredState({required  this.isDocumentIntelligenceEnabled,  required this.docmentType});
}

class DocumentExpiryNoDataState extends DocumentExpiryCheckState {}
// class DocumentExpirySuccessState extends DocumentExpiryCheckState {
//   final bool isExpired;
//   final String documentName;

//   DocumentExpirySuccessState({
//     required this.isExpired,
//     required this.documentName,
//   });
// }

// class DocumentExpiryFailureState extends DocumentExpiryCheckState {
//   final String errorMessage;

//   DocumentExpiryFailureState({required this.errorMessage});
// }

  

// class DocumentExpiryInvalidState extends DocumentExpiryCheckState {
//   final String reason;

//   DocumentExpiryInvalidState({required this.reason});
// }

