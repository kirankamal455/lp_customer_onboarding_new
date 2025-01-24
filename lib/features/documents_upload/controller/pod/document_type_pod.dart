import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lp_customer_onboarding/data/model/document_type_model.dart';

final documentTypesProvider =
    StateProvider.autoDispose<List<DocumentType>>((ref) {
  return [
    DocumentType(documentname: "National ID Card", docValue: "NID"),
    DocumentType(documentname: "Passport", docValue: "PRT"),
    // DocumentType(documentname: "Residence Permit", docValue: "RPT"),
    //DocumentType(documentname: "Driving License", docValue: "LIC")
  ];
});
