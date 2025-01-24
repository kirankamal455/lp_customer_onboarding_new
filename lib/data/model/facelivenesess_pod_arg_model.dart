// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:convert';

import 'package:lp_customer_onboarding/data/model/document_upload_response_model.dart';

class FaceLivenessPodArgumentModel {
  bool isDetailsEdited;
  final DocumentUploadResponseModel documentUploadResponseModel;
  FaceLivenessPodArgumentModel({
    required this.isDetailsEdited,
    required this.documentUploadResponseModel,
  });

  FaceLivenessPodArgumentModel copyWith({
    bool? isDetailsEdited,
    DocumentUploadResponseModel? documentUploadResponseModel,
  }) {
    return FaceLivenessPodArgumentModel(
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

  factory FaceLivenessPodArgumentModel.fromMap(Map<String, dynamic> map) {
    return FaceLivenessPodArgumentModel(
      isDetailsEdited: map['isDetailsEdited'] as bool,
      documentUploadResponseModel: DocumentUploadResponseModel.fromMap(
          map['documentUploadResponseModel'] as Map<String, dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory FaceLivenessPodArgumentModel.fromJson(String source) =>
      FaceLivenessPodArgumentModel.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'FaceLivenessPodArgumentModel(isDetailsEdited: $isDetailsEdited, documentUploadResponseModel: $documentUploadResponseModel)';

  @override
  bool operator ==(covariant FaceLivenessPodArgumentModel other) {
    if (identical(this, other)) return true;

    return other.isDetailsEdited == isDetailsEdited &&
        other.documentUploadResponseModel == documentUploadResponseModel;
  }

  @override
  int get hashCode =>
      isDetailsEdited.hashCode ^ documentUploadResponseModel.hashCode;
}
