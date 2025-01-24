// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UserModel {
  final String secureDeviceId;
  final String uniqueUserId;
  UserModel({
    required this.secureDeviceId,
    required this.uniqueUserId,
  });

  UserModel copyWith({
    String? secureDeviceId,
    String? uniqueUserId,
  }) {
    return UserModel(
      secureDeviceId: secureDeviceId ?? this.secureDeviceId,
      uniqueUserId: uniqueUserId ?? this.uniqueUserId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'secureDeviceId': secureDeviceId,
      'uniqueUserId': uniqueUserId,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      secureDeviceId: map['secureDeviceId'] as String,
      uniqueUserId: map['uniqueUserId'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'UserModel(secureDeviceId: $secureDeviceId, uniqueUserId: $uniqueUserId)';

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;

    return other.secureDeviceId == secureDeviceId &&
        other.uniqueUserId == uniqueUserId;
  }

  @override
  int get hashCode => secureDeviceId.hashCode ^ uniqueUserId.hashCode;
}
