import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:lp_customer_onboarding/features/documents_upload/controller/pod/form_validate_form.dart';

class MobileNumberField extends StatelessWidget {
  const MobileNumberField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final autoValidate = ref.watch(formValidatePod("mobileNumber"));
        return FormBuilderTextField(
          name: 'mobileNumber',
          autovalidateMode: autoValidate
              ? AutovalidateMode.disabled
              : AutovalidateMode.onUserInteraction,
          decoration: const InputDecoration(
            labelText: 'Mobile Number',
          ),
          onReset: () {
            ref.read(formValidatePod("mobileNumber").notifier).update(
                  (state) => true,
                );
          },
          onChanged: (value) {
            ref.read(formValidatePod("mobileNumber").notifier).update(
                  (state) => false,
                );
          },
          keyboardType: TextInputType.phone,
          validator: FormBuilderValidators.compose([
            FormBuilderValidators.required(
              errorText: "Please enter a Mobile Number",
            ),
            FormBuilderValidators.numeric(
              errorText: "Please enter a valid Mobile Number",
            ),
            FormBuilderValidators.maxLength(
              20,
              errorText: "Mobile Number must not exceed 20 characters.",
            ),
            FormBuilderValidators.minLength(
              10,
              errorText: "Mobile Number must be at least 10 digits.",
            ),
            FormBuilderValidators.match(
              RegExp(r'^\+?[1-9]\d{1,14}$'),
              errorText:
                  "Please enter a valid mobile number (e.g., +1234567890)",
            ),
          ]),
        );
      },
    );
  }
}
