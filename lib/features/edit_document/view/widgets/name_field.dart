import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:lp_customer_onboarding/features/documents_upload/controller/pod/form_validate_form.dart';
import 'package:lp_customer_onboarding/features/edit_document/controller/edit_doc_pod.dart';
import 'package:lp_customer_onboarding/features/edit_document/view/widgets/edit_button.dart'; // Ensure correct import

class NameField extends StatelessWidget {
  final String name;
  const NameField({
    super.key,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final autoValidate = ref.watch(formValidatePod("customerName"));
        final isEnable = ref.watch(editDocPod("customerName"));

        return Row(
          children: [
            Flexible(
              child: FormBuilderTextField(
                name: 'name',
                autovalidateMode: AutovalidateMode.onUserInteraction,
                // autovalidateMode: autoValidate
                //     ? AutovalidateMode.disabled
                //     : AutovalidateMode.onUserInteraction,
                enabled: name.isEmpty
                    ? true
                    : isEnable
                        ? true
                        : false,
                decoration: InputDecoration(
                  fillColor: name.isEmpty
                      ? const Color.fromARGB(255, 239, 209, 207)
                      : Colors.grey.shade200,
                  labelText: "Name",
                  contentPadding: const EdgeInsets.all(16),
                  border:
                      const OutlineInputBorder(), // Optional border for clarity
                ),
                onReset: () {
                  // ref.read(formValidatePod("customerName").notifier).update(
                  //       (state) => true,
                  //     );
                },
                onChanged: (value) {
                  // ref.read(formValidatePod("customerName").notifier).update(
                  //       (state) => false,
                  //     );
                },
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(
                    errorText: "Please enter the Name",
                  ),
                  FormBuilderValidators.maxLength(
                    100,
                    errorText: "Customer Name must not exceed 100 characters.",
                  ),
                ]),
              ),
            ),
            // EditButton(
            //   buttonType: 'customerName',
            //   data: name,
            // ),
          ],
        );
      },
    );
  }
}
