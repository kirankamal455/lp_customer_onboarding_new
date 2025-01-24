// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';

class LiveFaceResponseModel {
  final String Result;
  final bool Status;
  final List<Instruction> Instructions;
  LiveFaceResponseModel({
    required this.Result,
    required this.Status,
    required this.Instructions,
  });

  LiveFaceResponseModel copyWith({
    String? Result,
    bool? Status,
    List<Instruction>? Instructions,
  }) {
    return LiveFaceResponseModel(
      Result: Result ?? this.Result,
      Status: Status ?? this.Status,
      Instructions: Instructions ?? this.Instructions,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'Result': Result,
      'Status': Status,
      'Instructions': Instructions.map((x) => x.toMap()).toList(),
    };
  }

  factory LiveFaceResponseModel.fromMap(Map<String, dynamic> map) {
    return LiveFaceResponseModel(
      Result: map['Result'] as String,
      Status: map['Status'] as bool,
      Instructions: List<Instruction>.from(
        (map['Instructions']).map(
          (x) => Instruction.fromMap(x),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory LiveFaceResponseModel.fromJson(String source) =>
      LiveFaceResponseModel.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'LiveFaceResponseModel(Result: $Result, Status: $Status, Instructions: $Instructions)';

  @override
  bool operator ==(covariant LiveFaceResponseModel other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;

    return other.Result == Result &&
        other.Status == Status &&
        listEquals(other.Instructions, Instructions);
  }

  @override
  int get hashCode => Result.hashCode ^ Status.hashCode ^ Instructions.hashCode;
}

class Instruction {
  final String id;
  final String instruction;
  final String shortform;
  final String text;
  final bool Status;
  Instruction({
    required this.id,
    required this.instruction,
    required this.shortform,
    required this.text,
    required this.Status,
  });

  Instruction copyWith({
    String? id,
    String? instruction,
    String? shortform,
    String? text,
    bool? Status,
  }) {
    return Instruction(
      id: id ?? this.id,
      instruction: instruction ?? this.instruction,
      shortform: shortform ?? this.shortform,
      text: text ?? this.text,
      Status: Status ?? this.Status,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'instruction': instruction,
      'shortform': shortform,
      'text': text,
      'Status': Status,
    };
  }

  factory Instruction.fromMap(Map<String, dynamic> map) {
    return Instruction(
      id: map['id'] as String,
      instruction: map['instruction'] as String,
      shortform: map['shortform'] as String,
      text: map['text'] as String,
      Status: map['Status'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory Instruction.fromJson(String source) =>
      Instruction.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Instruction(id: $id, instruction: $instruction, shortform: $shortform, text: $text, Status: $Status)';
  }

  @override
  bool operator ==(covariant Instruction other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.instruction == instruction &&
        other.shortform == shortform &&
        other.text == text &&
        other.Status == Status;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        instruction.hashCode ^
        shortform.hashCode ^
        text.hashCode ^
        Status.hashCode;
  }
}
