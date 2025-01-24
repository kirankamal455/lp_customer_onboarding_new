import 'dart:convert';

class VerifyUserEmailModel {
  final int errorCode;
  final bool isSuccess;
  final String message;
  VerifyUserEmailModel({
    required this.errorCode,
    required this.isSuccess,
    required this.message,
  });

  VerifyUserEmailModel copyWith({
    int? errorCode,
    bool? isSuccess,
    String? message,
  }) {
    return VerifyUserEmailModel(
      errorCode: errorCode ?? this.errorCode,
      isSuccess: isSuccess ?? this.isSuccess,
      message: message ?? this.message,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'errorCode': errorCode,
      'isSuccess': isSuccess,
      'message': message,
    };
  }

  factory VerifyUserEmailModel.fromMap(Map<String, dynamic> map) {
    return VerifyUserEmailModel(
      errorCode: map['errorCode'].toInt() as int,
      isSuccess: map['isSuccess'] as bool,
      message: map['message'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory VerifyUserEmailModel.fromJson(String source) =>
      VerifyUserEmailModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'VerifyUserEmailModel(errorCode: $errorCode, isSuccess: $isSuccess, message: $message)';

  @override
  bool operator ==(covariant VerifyUserEmailModel other) {
    if (identical(this, other)) return true;

    return other.errorCode == errorCode &&
        other.isSuccess == isSuccess &&
        other.message == message;
  }

  @override
  int get hashCode =>
      errorCode.hashCode ^ isSuccess.hashCode ^ message.hashCode;
}
