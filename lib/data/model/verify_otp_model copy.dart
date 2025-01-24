import 'dart:convert';

class VerifyOtpModel {
  final int errorCode;
  final bool isSuccess;
  final String secureDeviceId;
  final String uniqueUserId;
  VerifyOtpModel({
    required this.errorCode,
    required this.isSuccess,
    required this.secureDeviceId,
    required this.uniqueUserId,
  });

  VerifyOtpModel copyWith({
    int? errorCode,
    bool? isSuccess,
    String? secureDeviceId,
    String? uniqueUserId,
  }) {
    return VerifyOtpModel(
      errorCode: errorCode ?? this.errorCode,
      isSuccess: isSuccess ?? this.isSuccess,
      secureDeviceId: secureDeviceId ?? this.secureDeviceId,
      uniqueUserId: uniqueUserId ?? this.uniqueUserId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'errorCode': errorCode,
      'isSuccess': isSuccess,
      'secureDeviceId': secureDeviceId,
      'uniqueUserId': uniqueUserId,
    };
  }

  factory VerifyOtpModel.fromMap(Map<String, dynamic> map) {
    return VerifyOtpModel(
      errorCode: map['errorCode'].toInt() as int,
      isSuccess: map['isSuccess'] as bool,
      secureDeviceId: map['secureDeviceId'] ?? "",
      uniqueUserId: map['uniqueUserId'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory VerifyOtpModel.fromJson(String source) =>
      VerifyOtpModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'VerifyOtpModel(errorCode: $errorCode, isSuccess: $isSuccess, secureDeviceId: $secureDeviceId, uniqueUserId: $uniqueUserId)';
  }

  @override
  bool operator ==(covariant VerifyOtpModel other) {
    if (identical(this, other)) return true;

    return other.errorCode == errorCode &&
        other.isSuccess == isSuccess &&
        other.secureDeviceId == secureDeviceId &&
        other.uniqueUserId == uniqueUserId;
  }

  @override
  int get hashCode {
    return errorCode.hashCode ^
        isSuccess.hashCode ^
        secureDeviceId.hashCode ^
        uniqueUserId.hashCode;
  }
}
