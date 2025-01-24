import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:lp_customer_onboarding/features/documents_upload/controller/pod/form_validate_form.dart';

class EmailField extends StatelessWidget {
  const EmailField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final autoValidate = ref.watch(formValidatePod("email"));
        return FormBuilderTextField(
          name: 'email',
          autovalidateMode: autoValidate
              ? AutovalidateMode.disabled
              : AutovalidateMode.onUserInteraction,
          decoration: const InputDecoration(labelText: 'Email ID'),
          onReset: () {
            ref.read(formValidatePod("email").notifier).update(
                  (state) => true,
                );
          },
          onChanged: (value) {
            ref.read(formValidatePod("email").notifier).update(
                  (state) => false,
                );
          },
          validator: FormBuilderValidators.compose([
            FormBuilderValidators.required(
              errorText: "Please enter the Email ID",
            ),
            FormBuilderValidators.email(
              errorText: "Please enter a valid Email ID",
            ),
            FormBuilderValidators.maxLength(
              100,
              errorText: "Email ID must not exceed 100 characters.",
            ),
          ]),
        );
      },
    );
  }
}
