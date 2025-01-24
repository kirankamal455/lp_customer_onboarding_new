import 'dart:convert';

class LoginResponseModel {
  final String accessToken;
  final String expiryDate;
  final String csrfToken;
  final String userName;
  LoginResponseModel({
    required this.accessToken,
    required this.expiryDate,
    required this.csrfToken,
    required this.userName,
  });

  LoginResponseModel copyWith({
    String? accessToken,
    String? expiryDate,
    String? csrfToken,
    String? userName,
  }) {
    return LoginResponseModel(
      accessToken: accessToken ?? this.accessToken,
      expiryDate: expiryDate ?? this.expiryDate,
      csrfToken: csrfToken ?? this.csrfToken,
      userName: userName ?? this.userName,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'accessToken': accessToken,
      'expiryDate': expiryDate,
      'csrfToken': csrfToken,
      'userName': userName,
    };
  }

  factory LoginResponseModel.fromMap(Map<String, dynamic> map) {
    return LoginResponseModel(
      accessToken: map['accessToken'] as String,
      expiryDate: map['expiryDate'] as String,
      csrfToken: map['csrfToken'] as String,
      userName: map['userName'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory LoginResponseModel.fromJson(String source) => LoginResponseModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'LoginResponseModel(accessToken: $accessToken, expiryDate: $expiryDate, csrfToken: $csrfToken, userName: $userName)';
  }

  @override
  bool operator ==(covariant LoginResponseModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.accessToken == accessToken &&
      other.expiryDate == expiryDate &&
      other.csrfToken == csrfToken &&
      other.userName == userName;
  }

  @override
  int get hashCode {
    return accessToken.hashCode ^
      expiryDate.hashCode ^
      csrfToken.hashCode ^
      userName.hashCode;
  }
}