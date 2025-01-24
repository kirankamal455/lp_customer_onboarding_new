import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:intl/intl.dart';
import 'package:lp_customer_onboarding/features/documents_upload/controller/pod/form_validate_form.dart';
import 'package:lp_customer_onboarding/features/edit_document/controller/edit_doc_pod.dart';
import 'package:lp_customer_onboarding/features/edit_document/view/widgets/edit_button.dart'; // Corrected import

class DobField extends StatelessWidget {
  const DobField({
    super.key,
    required this.dob,
  });
  final String dob;
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final autoValidate = ref
            .watch(formValidatePod("dob")); // Auto-validate state if required
        final isEnable = ref.watch(editDocPod(
            "dob")); // Using editDocPod to manage the enabled state for dob
        print("isEnable:    $isEnable");

        return Row(
          children: [
            Flexible(
              child: FormBuilderDateTimePicker(
                name: 'dob',
                format: DateFormat('dd/MM/yyyy'),
                inputType: InputType.date,
                autovalidateMode: autoValidate
                    ? AutovalidateMode.disabled
                    : AutovalidateMode.onUserInteraction,
                enabled: dob.isEmpty
                    ? true
                    : isEnable
                        ? true
                        : false,
                decoration: InputDecoration(
                  fillColor: dob.isEmpty
                      ? const Color.fromARGB(255, 239, 209, 207)
                      : Colors.grey.shade200,
                  labelText: 'Date of birth',
                  contentPadding: const EdgeInsets.all(16),
                  border: const OutlineInputBorder(),
                ),
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(
                    errorText: "Please select a date of birth",
                  ),
                ]),
              ),
            ),
            // EditButton(
            //   data: dob,
            //   buttonType: 'dob',
            // ),
          ],
        );
      },
    );
  }
}
