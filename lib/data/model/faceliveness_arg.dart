// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:lp_customer_onboarding/data/model/document_upload_response_model.dart';

class FaceLivenessArg {
  bool isDetailsEdited;
  final DocumentUploadResponseModel documentUploadResponseModel;
  FaceLivenessArg({
    required this.isDetailsEdited,
    required this.documentUploadResponseModel,
  });

  FaceLivenessArg copyWith({
    bool? isDetailsEdited,
    DocumentUploadResponseModel? documentUploadResponseModel,
  }) {
    return FaceLivenessArg(
      isDetailsEdited: isDetailsEdited ?? this.isDetailsEdited,
      documentUploadResponseModel:
          documentUploadResponseModel ?? this.documentUploadResponseModel,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'isDetailsEdited': isDetailsEdited,
      'documentUploadResponseModel': documentUploadResponseModel.toMap(),
    };
  }

  factory FaceLivenessArg.fromMap(Map<String, dynamic> map) {
    return FaceLivenessArg(
      isDetailsEdited: map['isDetailsEdited'] as bool,
      documentUploadResponseModel: DocumentUploadResponseModel.fromMap(
          map['documentUploadResponseModel'] as Map<String, dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory FaceLivenessArg.fromJson(String source) =>
      FaceLivenessArg.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'FaceLivenessArg(isDetailsEdited: $isDetailsEdited, documentUploadResponseModel: $documentUploadResponseModel)';

  @override
  bool operator ==(covariant FaceLivenessArg other) {
    if (identical(this, other)) return true;

    return other.isDetailsEdited == isDetailsEdited &&
        other.documentUploadResponseModel == documentUploadResponseModel;
  }

  @override
  int get hashCode =>
      isDetailsEdited.hashCode ^ documentUploadResponseModel.hashCode;
}
