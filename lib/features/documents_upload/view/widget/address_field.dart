import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:lp_customer_onboarding/features/documents_upload/controller/pod/form_validate_form.dart';

class AddressField extends StatelessWidget {
  const AddressField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final autoValidate = ref.watch(formValidatePod("address"));
        return FormBuilderTextField(
          name: 'address',
          autovalidateMode: autoValidate
              ? AutovalidateMode.disabled
              : AutovalidateMode.onUserInteraction,
          onReset: () {
            ref.read(formValidatePod("address").notifier).update(
                  (state) => true,
                );
          },
          onChanged: (value) {
            ref.read(formValidatePod("address").notifier).update(
                  (state) => false,
                );
          },
          decoration: const InputDecoration(
            labelText: 'Address',
            border: OutlineInputBorder(),
          ),
          validator: FormBuilderValidators.compose([
            FormBuilderValidators.required(
              errorText: "Please enter the Address",
            ),
            FormBuilderValidators.maxLength(
              2000,
              errorText: "Address must not exceed 2000 characters.",
            ),
          ]),
          maxLines: 3,
          minLines: 1,
        );
      },
    );
  }
}
