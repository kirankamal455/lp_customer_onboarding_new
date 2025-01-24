import 'dart:convert';

class SendOTPResponseModel {
  final int errorCode;
  final bool isSuccess;
  final String message;
  final String uniqueUserId;
  SendOTPResponseModel({
    required this.errorCode,
    required this.isSuccess,
    required this.message,
    required this.uniqueUserId,
  });

  SendOTPResponseModel copyWith({
    int? errorCode,
    bool? isSuccess,
    String? message,
    String? uniqueUserId,
  }) {
    return SendOTPResponseModel(
      errorCode: errorCode ?? this.errorCode,
      isSuccess: isSuccess ?? this.isSuccess,
      message: message ?? this.message,
      uniqueUserId: uniqueUserId ?? this.uniqueUserId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'errorCode': errorCode,
      'isSuccess': isSuccess,
      'message': message,
      'uniqueUserId': uniqueUserId,
    };
  }

  factory SendOTPResponseModel.fromMap(Map<String, dynamic> map) {
    return SendOTPResponseModel(
      errorCode: map['errorCode'].toInt() as int,
      isSuccess: map['isSuccess'] as bool,
      message: map['message'] as String,
      uniqueUserId: map['uniqueUserId'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory SendOTPResponseModel.fromJson(String source) =>
      SendOTPResponseModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'AddUserModel(errorCode: $errorCode, isSuccess: $isSuccess, message: $message, uniqueUserId: $uniqueUserId)';
  }

  @override
  bool operator ==(covariant SendOTPResponseModel other) {
    if (identical(this, other)) return true;

    return other.errorCode == errorCode &&
        other.isSuccess == isSuccess &&
        other.message == message &&
        other.uniqueUserId == uniqueUserId;
  }

  @override
  int get hashCode {
    return errorCode.hashCode ^
        isSuccess.hashCode ^
        message.hashCode ^
        uniqueUserId.hashCode;
  }
}
