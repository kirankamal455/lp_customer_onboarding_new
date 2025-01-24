// // ignore_for_file: public_member_api_docs, sort_constructors_first
// import 'dart:convert';

// import 'package:flutter/foundation.dart';

// class LivenessInstructionModel {
//   final List<Instruction> instructions;
//   LivenessInstructionModel({
//     required this.instructions,
//   });

//   LivenessInstructionModel copyWith({
//     List<Instruction>? instructions,
//   }) {
//     return LivenessInstructionModel(
//       instructions: instructions ?? this.instructions,
//     );
//   }

//   Map<String, dynamic> toMap() {
//     return <String, dynamic>{
//       'instructions': instructions.map((x) => x.toMap()).toList(),
//     };
//   }

//   factory LivenessInstructionModel.fromMap(Map<String, dynamic> map) {
//     return LivenessInstructionModel(
//       instructions: List<Instruction>.from(
//         (map['instructions']).map<Instruction>(
//           (x) => Instruction.fromMap(x as Map<String, dynamic>),
//         ),
//       ),
//     );
//   }

//   String toJson() => json.encode(toMap());

//   factory LivenessInstructionModel.fromJson(String source) =>
//       LivenessInstructionModel.fromMap(
//           json.decode(source) as Map<String, dynamic>);

//   @override
//   String toString() => 'InstructionModel(instructions: $instructions)';

//   @override
//   bool operator ==(covariant LivenessInstructionModel other) {
//     if (identical(this, other)) return true;

//     return listEquals(other.instructions, instructions);
//   }

//   @override
//   int get hashCode => instructions.hashCode;
// }

// class Instruction {
//   final String instruction;
//   bool enabled;
//   final int order;
//   final String shortform;
//   final String speakword;
//   Instruction({
//     required this.instruction,
//     required this.enabled,
//     required this.order,
//     required this.shortform,
//     required this.speakword,
//   });

//   Instruction copyWith({
//     String? instruction,
//     bool? enabled,
//     int? order,
//     String? shortform,
//     String? speakword,
//   }) {
//     return Instruction(
//       instruction: instruction ?? this.instruction,
//       enabled: enabled ?? this.enabled,
//       order: order ?? this.order,
//       shortform: shortform ?? this.shortform,
//       speakword: speakword ?? this.speakword,
//     );
//   }

//   Map<String, dynamic> toMap() {
//     return <String, dynamic>{
//       'instruction': instruction,
//       'enabled': enabled,
//       'order': order,
//       'shortform': shortform,
//       'speakword': speakword,
//     };
//   }

//   factory Instruction.fromMap(Map<String, dynamic> map) {
//     return Instruction(
//       instruction: map['instruction'] as String,
//       enabled: map['enabled'] as bool,
//       order: map['order'] as int,
//       shortform: map['shortform'] as String,
//       speakword: map['speakword'] as String,
//     );
//   }

//   String toJson() => json.encode(toMap());

//   factory Instruction.fromJson(String source) =>
//       Instruction.fromMap(json.decode(source) as Map<String, dynamic>);

//   @override
//   String toString() {
//     return 'Instruction(instruction: $instruction, enabled: $enabled, order: $order, shortform: $shortform, speakword: $speakword)';
//   }

//   @override
//   bool operator ==(covariant Instruction other) {
//     if (identical(this, other)) return true;

//     return other.instruction == instruction &&
//         other.enabled == enabled &&
//         other.order == order &&
//         other.shortform == shortform &&
//         other.speakword == speakword;
//   }

//   @override
//   int get hashCode {
//     return instruction.hashCode ^
//         enabled.hashCode ^
//         order.hashCode ^
//         shortform.hashCode ^
//         speakword.hashCode;
//   }
// }
