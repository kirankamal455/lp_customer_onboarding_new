// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class DocumentUploadResponseModel {
  final String processId;
  final String userId;
  final Data data;
  DocumentUploadResponseModel({
    required this.processId,
    required this.userId,
    required this.data,
  });

  DocumentUploadResponseModel copyWith({
    String? processId,
    String? userId,
    Data? data,
  }) {
    return DocumentUploadResponseModel(
      processId: processId ?? this.processId,
      userId: userId ?? this.userId,
      data: data ?? this.data,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'processId': processId,
      'userId': userId,
      'data': data.toMap(),
    };
  }

  factory DocumentUploadResponseModel.fromMap(Map<String, dynamic> map) {
    return DocumentUploadResponseModel(
      processId: map['processId'] as String,
      userId: map['userId'] as String,
      data: Data.fromMap(map['data'] as Map<String,dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory DocumentUploadResponseModel.fromJson(String source) => DocumentUploadResponseModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'DocumentUploadResponseModel(processId: $processId, userId: $userId, data: $data)';

  @override
  bool operator ==(covariant DocumentUploadResponseModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.processId == processId &&
      other.userId == userId &&
      other.data == data;
  }

  @override
  int get hashCode => processId.hashCode ^ userId.hashCode ^ data.hashCode;
}

class Data {
  final String name;
  final String dateOfBirth;
  final String gender;
  final String documentNumber;
  final String issueDate;
  final String expiryDate;
  final String documentUrl;
  Data({
    required this.documentUrl,
    required this.name,
    required this.dateOfBirth,
    required this.gender,
    required this.documentNumber,
    required this.issueDate,
    required this.expiryDate,
  });

  Data copyWith(
      {String? name,
      String? dateOfBirth,
      String? gender,
      String? documentNumber,
      String? issueDate,
      String? expiryDate,
      String? documentUrl}) {
    return Data(
      name: name ?? this.name,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      gender: gender ?? this.gender,
      documentNumber: documentNumber ?? this.documentNumber,
      issueDate: issueDate ?? this.issueDate,
      expiryDate: expiryDate ?? this.expiryDate,
      documentUrl: documentUrl ?? this.documentUrl,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'dateOfBirth': dateOfBirth,
      'gender': gender,
      'documentNumber': documentNumber,
      'issueDate': issueDate,
      'expiryDate': expiryDate,
    };
  }

  factory Data.fromMap(Map<String, dynamic> map) {
    return Data(
      name: map['name'] as String,
      dateOfBirth: map['dateOfBirth'] as String,
      gender: map['gender'] as String,
      documentNumber: map['documentNumber'] as String,
      issueDate: map['issueDate'] as String,
      expiryDate: map['expiryDate'] as String,
      documentUrl: map['documentUrl'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Data.fromJson(String source) =>
      Data.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Data(name: $name, dateOfBirth: $dateOfBirth, gender: $gender, documentNumber: $documentNumber, issueDate: $issueDate, expiryDate: $expiryDate)';
  }

  @override
  bool operator ==(covariant Data other) {
    if (identical(this, other)) return true;

    return other.name == name &&
        other.dateOfBirth == dateOfBirth &&
        other.gender == gender &&
        other.documentNumber == documentNumber &&
        other.issueDate == issueDate &&
        other.expiryDate == expiryDate;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        dateOfBirth.hashCode ^
        gender.hashCode ^
        documentNumber.hashCode ^
        issueDate.hashCode ^
        expiryDate.hashCode;
  }
}
