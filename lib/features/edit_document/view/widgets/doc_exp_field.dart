import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:intl/intl.dart';
import 'package:lp_customer_onboarding/features/edit_document/controller/edit_doc_pod.dart';
import 'package:lp_customer_onboarding/features/edit_document/view/widgets/edit_button.dart'; // Corrected import

class DocExpirationField extends StatelessWidget {
  const DocExpirationField({
    super.key,
    required this.docExp,
  });
  final String docExp;
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        //  final autoValidate = ref.watch(formValidatePod("docexpdate"));
        final isEnable = ref.watch(editDocPod("docexpdate"));

        return Row(
          children: [
            Flexible(
              child: FormBuilderDateTimePicker(
                name: 'docexpdate',
                inputType: InputType.date, format: DateFormat('dd/MM/yyyy'),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                //     ? AutovalidateMode.disabled
                //     : AutovalidateMode.onUserInteraction,
                enabled: docExp.isEmpty
                    ? true
                    : isEnable
                        ? true
                        : false,
                initialDate: DateTime.now()
                    .add(const Duration(days: 1)), // Default to tomorrow
                firstDate: DateTime.now().add(const Duration(
                    days: 1)), // Prevent selecting dates before today
                lastDate: DateTime(2100),
                decoration: InputDecoration(
                  fillColor: docExp.isEmpty
                      ? const Color.fromARGB(255, 239, 209, 207)
                      : Colors.grey.shade200,
                  labelText: 'Document Expiration Date',
                  contentPadding: const EdgeInsets.all(16),
                  border: const OutlineInputBorder(),
                ),
                validator: FormBuilderValidators.required(
                  errorText: "Please select a Document Expiration Date",
                ),
              ),
            ),
            EditButton(
              buttonType: 'docexpdate',
              data: docExp,
            ),
          ],
        );
      },
    );
  }
}
