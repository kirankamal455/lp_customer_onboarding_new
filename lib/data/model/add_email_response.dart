import 'dart:convert';

class AddEmailResponseModel {
  final int errorCode;
  final bool isSuccess;
  final String message;
  AddEmailResponseModel({
    required this.errorCode,
    required this.isSuccess,
    required this.message,
  });

  AddEmailResponseModel copyWith({
    int? errorCode,
    bool? isSuccess,
    String? message,
  }) {
    return AddEmailResponseModel(
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

  factory AddEmailResponseModel.fromMap(Map<String, dynamic> map) {
    return AddEmailResponseModel(
      errorCode: map['errorCode'].toInt() as int,
      isSuccess: map['isSuccess'] as bool,
      message: map['message'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory AddEmailResponseModel.fromJson(String source) =>
      AddEmailResponseModel.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'AddEmailResponse(errorCode: $errorCode, isSuccess: $isSuccess, message: $message)';

  @override
  bool operator ==(covariant AddEmailResponseModel other) {
    if (identical(this, other)) return true;

    return other.errorCode == errorCode &&
        other.isSuccess == isSuccess &&
        other.message == message;
  }

  @override
  int get hashCode =>
      errorCode.hashCode ^ isSuccess.hashCode ^ message.hashCode;
}
