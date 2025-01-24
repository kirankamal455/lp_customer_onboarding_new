import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:intl/intl.dart';
import 'package:lp_customer_onboarding/features/edit_document/controller/edit_doc_pod.dart';
import 'package:lp_customer_onboarding/features/edit_document/view/widgets/edit_button.dart'; // Correct import for editDocPod

class IssueDateField extends StatelessWidget {
  final String issueDate;
  const IssueDateField({
    super.key,
    required this.issueDate,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final isEnable = ref.watch(editDocPod("issuesdate"));

        return Row(
          children: [
            Flexible(
              child: FormBuilderDateTimePicker(
                name: 'issuesdate',
                autovalidateMode: AutovalidateMode.onUserInteraction,
                inputType: InputType.date,
                format: DateFormat('dd/MM/yyyy'),
                lastDate: DateTime.now(),
                enabled: issueDate.isEmpty
                    ? true
                    : isEnable
                        ? true
                        : false,
                decoration: InputDecoration(
                  labelText: 'Issue Date',
                  contentPadding: const EdgeInsets.all(16),
                  fillColor: issueDate.isEmpty
                      ? const Color.fromARGB(255, 239, 209, 207)
                      : Colors.grey.shade200,
                  border: const OutlineInputBorder(),
                ),
                validator: FormBuilderValidators.required(
                  errorText: "Please select an Issue Date",
                ),
              ),
            ),
            // EditButton(
            //   data: issueDate,
            //   buttonType: 'issuesdate',
            // ),
          ],
        );
      },
    );
  }
}
