import 'package:flutter_riverpod/flutter_riverpod.dart';

final editDocPod = StateProvider.autoDispose.family<bool,String>((ref,arg) {
  return false;
});
 

// StateProvider for each field in the Data class
final isValueEmptyCheckPod = StateProvider.autoDispose.family<bool, String>((ref, name) {
  return false;
});

// final isDateOfBirthEmptyPod = StateProvider.autoDispose.family<bool, String>((ref, dateOfBirth) {
//   return dateOfBirth.isEmpty;
// });

// final isGenderEmptyPod = StateProvider.autoDispose.family<bool, String>((ref, gender) {
//   return gender.isEmpty;
// });

// final isDocumentNumberEmptyPod = StateProvider.autoDispose.family<bool, String>((ref, documentNumber) {
//   return documentNumber.isEmpty;
// });

// final isIssueDateEmptyPod = StateProvider.autoDispose.family<bool, String>((ref, issueDate) {
//   return issueDate.isEmpty;
// });

// final isExpiryDateEmptyPod = StateProvider.autoDispose.family<bool, String>((ref, expiryDate) {
//   return expiryDate.isEmpty;
// });
