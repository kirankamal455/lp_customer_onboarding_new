import 'dart:convert';

import 'package:flutter/foundation.dart';

class LivenssIntructionsResponseModel {
  final List<Instructions> data;
  LivenssIntructionsResponseModel({
    required this.data,
  });

  LivenssIntructionsResponseModel copyWith({
    List<Instructions>? data,
  }) {
    return LivenssIntructionsResponseModel(
      data: data ?? this.data,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'data': data.map((x) => x.toMap()).toList(),
    };
  }

  factory LivenssIntructionsResponseModel.fromMap(Map<String, dynamic> map) {
    return LivenssIntructionsResponseModel(
      data: List<Instructions>.from(
        (map['data']).map((x) => Instructions.fromMap(x)),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory LivenssIntructionsResponseModel.fromJson(String source) =>
      LivenssIntructionsResponseModel.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'LivenssIntructionsResponseModel(data: $data)';

  @override
  bool operator ==(covariant LivenssIntructionsResponseModel other) {
    if (identical(this, other)) return true;

    return listEquals(other.data, data);
  }

  @override
  int get hashCode => data.hashCode;
}

class Instructions {
  final String speakWord;
  final int featureId;
  final String featureName;
  final String shortForm;
  final bool isEnabled;
  final int order;
  final String id;
  final String createdDate;
  final String modifiedDate;
  Instructions({
    required this.speakWord,
    required this.featureId,
    required this.featureName,
    required this.shortForm,
    required this.isEnabled,
    required this.order,
    required this.id,
    required this.createdDate,
    required this.modifiedDate,
  });

  Instructions copyWith({
    String? speakWord,
    int? featureId,
    String? featureName,
    String? shortForm,
    bool? isEnabled,
    int? order,
    String? id,
    String? createdDate,
    String? modifiedDate,
  }) {
    return Instructions(
      speakWord: speakWord ?? this.speakWord,
      featureId: featureId ?? this.featureId,
      featureName: featureName ?? this.featureName,
      shortForm: shortForm ?? this.shortForm,
      isEnabled: isEnabled ?? this.isEnabled,
      order: order ?? this.order,
      id: id ?? this.id,
      createdDate: createdDate ?? this.createdDate,
      modifiedDate: modifiedDate ?? this.modifiedDate,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'speakWord': speakWord,
      'featureId': featureId,
      'featureName': featureName,
      'shortForm': shortForm,
      'isEnabled': isEnabled,
      'order': order,
      'id': id,
      'createdDate': createdDate,
      'modifiedDate': modifiedDate,
    };
  }

  factory Instructions.fromMap(Map<String, dynamic> map) {
    return Instructions(
      speakWord: map['speakWord'] as String,
      featureId: map['featureId'].toInt() as int,
      featureName: map['featureName'] as String,
      shortForm: map['shortForm'] as String,
      isEnabled: map['isEnabled'] as bool,
      order: map['order'].toInt() as int,
      id: map['id'] as String,
      createdDate: map['createdDate'] as String,
      modifiedDate: map['modifiedDate'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Instructions.fromJson(String source) =>
      Instructions.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Data(speakWord: $speakWord, featureId: $featureId, featureName: $featureName, shortForm: $shortForm, isEnabled: $isEnabled, order: $order, id: $id, createdDate: $createdDate, modifiedDate: $modifiedDate)';
  }

  @override
  bool operator ==(covariant Instructions other) {
    if (identical(this, other)) return true;

    return other.speakWord == speakWord &&
        other.featureId == featureId &&
        other.featureName == featureName &&
        other.shortForm == shortForm &&
        other.isEnabled == isEnabled &&
        other.order == order &&
        other.id == id &&
        other.createdDate == createdDate &&
        other.modifiedDate == modifiedDate;
  }

  @override
  int get hashCode {
    return speakWord.hashCode ^
        featureId.hashCode ^
        featureName.hashCode ^
        shortForm.hashCode ^
        isEnabled.hashCode ^
        order.hashCode ^
        id.hashCode ^
        createdDate.hashCode ^
        modifiedDate.hashCode;
  }
}
