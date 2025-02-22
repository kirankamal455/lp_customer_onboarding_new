import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:gap/gap.dart';
import 'package:lp_customer_onboarding/features/documents_upload/controller/pod/document_type_pod.dart';
import 'package:lp_customer_onboarding/features/documents_upload/controller/pod/form_validate_form.dart';

class DocumentTypeDropDownField extends StatelessWidget {
  const DocumentTypeDropDownField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Gap(10),
        const Text(
          "Document Type",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const Gap(15),
        Consumer(
          builder: (context, cref, child) {
            final documentTypes = cref.watch(documentTypesProvider);
            final autoValidate = cref.watch(formValidatePod("DocumentType"));
            return FormBuilderDropdown<String>(
              name: 'DocumentType',
              hint: const Text("Select Document Type"),
              autovalidateMode: autoValidate
                  ? AutovalidateMode.disabled
                  : AutovalidateMode.onUserInteraction,
              onReset: () {
                cref.read(formValidatePod("DocumentType").notifier).update(
                      (state) => true,
                    );
              },
              onChanged: (value) {
                cref.read(formValidatePod("DocumentType").notifier).update(
                      (state) => false,
                    );
              },
              decoration: InputDecoration(
                  fillColor: Colors.grey.shade200,
                  contentPadding: const EdgeInsets.all(17)),
              items: documentTypes
                  .map((document) => DropdownMenuItem<String>(
                        value: document.docValue,
                        child: Text(document.documentname),
                      ))
                  .toList(),
              validator: FormBuilderValidators.required(
                errorText: "Please select a Document Type",
              ),
            );
          },
        ),
      ],
    );
  }
}
