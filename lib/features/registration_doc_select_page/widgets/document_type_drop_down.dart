import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:gap/gap.dart';
import 'package:lp_customer_onboarding/features/documents_upload/controller/pod/document_type_pod.dart';
import 'package:lp_customer_onboarding/features/documents_upload/controller/pod/form_validate_form.dart';
import 'package:velocity_x/velocity_x.dart';

class DocumentTypeDropDown extends StatelessWidget {
  const DocumentTypeDropDown({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: context.screenHeight * 0.02),
        const Gap(40),
        Consumer(
          builder: (context, cref, child) {
            final documentTypes = cref.watch(documentTypesProvider);
            final autoValidate = cref.watch(formValidatePod("DocumentType"));
            return FormBuilderDropdown<String>(
              name: 'DocumentType',
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
              decoration:
                  const InputDecoration(labelText: 'Select Document Type'),
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
