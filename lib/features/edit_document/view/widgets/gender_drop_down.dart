import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:lp_customer_onboarding/features/documents_upload/controller/pod/form_validate_form.dart';
import 'package:lp_customer_onboarding/features/edit_document/controller/edit_doc_pod.dart';
import 'package:lp_customer_onboarding/features/edit_document/view/widgets/edit_button.dart'; // Corrected import for editDocPod

class GenderDropDownField extends StatelessWidget {
  final String gender;
  const GenderDropDownField({
    super.key,
    required this.gender,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, cref, child) {
        final autoValidate = cref.watch(formValidatePod("Gender"));
        final isEnable = cref.watch(
            editDocPod("Gender")); // Manage enabled state with editDocPod

        return Row(
          children: [
            Flexible(
              child: FormBuilderDropdown<String>(
                name: 'Gender',
                autovalidateMode: AutovalidateMode.onUserInteraction,
                // autovalidateMode: autoValidate
                //     ? AutovalidateMode.disabled
                //     : AutovalidateMode.onUserInteraction,
                enabled: gender.isEmpty
                    ? true
                    : isEnable
                        ? true
                        : false,
                decoration: InputDecoration(
                  labelText: 'Gender',
                  fillColor: gender.isEmpty
                      ? const Color.fromARGB(255, 239, 209, 207)
                      : Colors.grey.shade200,
                  contentPadding: const EdgeInsets.all(16),
                  border:
                      const OutlineInputBorder(), // Optional border for visual clarity
                ),
                items: ["Male", "Female", "Other"]
                    .map((gender) => DropdownMenuItem<String>(
                          value: gender,
                          child: Text(gender),
                        ))
                    .toList(),
                validator: FormBuilderValidators.required(
                  errorText: "Please select a Gender",
                ),
              ),
            ),
            // EditButton(
            //   buttonType: 'Gender',
            //   data: gender,
            // ),
          ],
        );
      },
    );
  }
}
