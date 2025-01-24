// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class DocumentExpiryCheckReponseModel {
  final int errorCode;
  final bool isSuccess;
  final bool isDocumentIntelligenceEnabled;
  final String message;
  final String uniqueUserId;
  final String data;
  DocumentExpiryCheckReponseModel({
    required this.errorCode,
    required this.isSuccess,
    required this.isDocumentIntelligenceEnabled,
    required this.message,
    required this.uniqueUserId,
    required this.data,
  });

  DocumentExpiryCheckReponseModel copyWith({
    int? errorCode,
    bool? isSuccess,
    bool? isDocumentIntelligenceEnabled,
    String? message,
    String? uniqueUserId,
    String? data,
  }) {
    return DocumentExpiryCheckReponseModel(
      errorCode: errorCode ?? this.errorCode,
      isSuccess: isSuccess ?? this.isSuccess,
      isDocumentIntelligenceEnabled: isDocumentIntelligenceEnabled ?? this.isDocumentIntelligenceEnabled,
      message: message ?? this.message,
      uniqueUserId: uniqueUserId ?? this.uniqueUserId,
      data: data ?? this.data,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'errorCode': errorCode,
      'isSuccess': isSuccess,
      'isDocumentIntelligenceEnabled': isDocumentIntelligenceEnabled,
      'message': message,
      'uniqueUserId': uniqueUserId,
      'data': data,
    };
  }

  factory DocumentExpiryCheckReponseModel.fromMap(Map<String, dynamic> map) {
    return DocumentExpiryCheckReponseModel(
      errorCode: map['errorCode'] as int,
      isSuccess: map['isSuccess'] as bool,
      isDocumentIntelligenceEnabled: map['isDocumentIntelligenceEnabled'] as bool,
      message: map['message'] as String,
      uniqueUserId: map['uniqueUserId'] as String,
      data: map['data'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory DocumentExpiryCheckReponseModel.fromJson(String source) => DocumentExpiryCheckReponseModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'DocumentExpiryCheckReponseModel(errorCode: $errorCode, isSuccess: $isSuccess, isDocumentIntelligenceEnabled: $isDocumentIntelligenceEnabled, message: $message, uniqueUserId: $uniqueUserId, data: $data)';
  }

  @override
  bool operator ==(covariant DocumentExpiryCheckReponseModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.errorCode == errorCode &&
      other.isSuccess == isSuccess &&
      other.isDocumentIntelligenceEnabled == isDocumentIntelligenceEnabled &&
      other.message == message &&
      other.uniqueUserId == uniqueUserId &&
      other.data == data;
  }

  @override
  int get hashCode {
    return errorCode.hashCode ^
      isSuccess.hashCode ^
      isDocumentIntelligenceEnabled.hashCode ^
      message.hashCode ^
      uniqueUserId.hashCode ^
      data.hashCode;
  }
}
