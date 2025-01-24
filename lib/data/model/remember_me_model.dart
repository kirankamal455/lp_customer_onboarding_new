// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class RememberMeModel {
  final String userName;
  final String password;
  RememberMeModel({
    required this.userName,
    required this.password,
  });

  RememberMeModel copyWith({
    String? userName,
    String? password,
  }) {
    return RememberMeModel(
      userName: userName ?? this.userName,
      password: password ?? this.password,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userName': userName,
      'password': password,
    };
  }

  factory RememberMeModel.fromMap(Map<String, dynamic> map) {
    return RememberMeModel(
      userName: map['userName'] as String,
      password: map['password'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory RememberMeModel.fromJson(String source) =>
      RememberMeModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'RememberMeModel(userName: $userName, password: $password)';

  @override
  bool operator ==(covariant RememberMeModel other) {
    if (identical(this, other)) return true;

    return other.userName == userName && other.password == password;
  }

  @override
  int get hashCode => userName.hashCode ^ password.hashCode;
}
