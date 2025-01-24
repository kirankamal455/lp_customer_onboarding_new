import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:lp_customer_onboarding/features/documents_upload/controller/pod/form_validate_form.dart';

class PersonNameFieild extends StatelessWidget {
  const PersonNameFieild({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final autoValidate = ref.watch(formValidatePod("personName"));
        return FormBuilderTextField(
          name: 'personName',
          autovalidateMode: autoValidate
              ? AutovalidateMode.disabled
              : AutovalidateMode.onUserInteraction,
          decoration: InputDecoration(
            fillColor: Colors.grey.shade200,
            labelText: "Person Name",
            contentPadding: const EdgeInsets.all(10),
          ),
          onReset: () {
            ref.read(formValidatePod("personName").notifier).update(
                  (state) => true,
                );
          },
          onChanged: (value) {
            ref.read(formValidatePod("personName").notifier).update(
                  (state) => false,
                );
          },
          validator: FormBuilderValidators.compose([
            FormBuilderValidators.required(
              errorText: "Please enter the Person Name",
            ),
            FormBuilderValidators.maxLength(
              100,
              errorText: "Person Name must not exceed 100 characters.",
            ),
          ]),
        );
      },
    );
  }
}
