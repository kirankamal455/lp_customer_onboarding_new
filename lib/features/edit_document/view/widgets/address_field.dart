import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:lp_customer_onboarding/features/documents_upload/controller/pod/form_validate_form.dart';
import 'package:lp_customer_onboarding/features/edit_document/controller/edit_doc_pod.dart';
import 'package:lp_customer_onboarding/features/edit_document/view/widgets/edit_button.dart';

class DocumentAddressField extends StatelessWidget {
  const DocumentAddressField({
    super.key,
    required this.address,
  });
  final String address;
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final autoValidate = ref.watch(formValidatePod("address"));
        final isEnable = ref.watch(editDocPod("address"));
        print("isEnable:    $isEnable");
        return Row(
          children: [
            Flexible(
              child: FormBuilderTextField(
                name: 'docaddress',
                autovalidateMode: autoValidate
                    ? AutovalidateMode.disabled
                    : AutovalidateMode.onUserInteraction,
                enabled: isEnable,
                onReset: () {
                  // ref.read(formValidatePod("address").notifier).update(
                  //       (state) => true,
                  //     );
                },
                onChanged: (value) {
                  // ref.read(formValidatePod("address").notifier).update(
                  //       (state) => false,
                  //     );
                },
                decoration: InputDecoration(
                  labelText: 'Address',
                  fillColor: address.isEmpty
                      ? const Color.fromARGB(255, 239, 209, 207)
                      : Colors.grey.shade200,
                  contentPadding: const EdgeInsets.all(16),
                  border: const OutlineInputBorder(),
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
              ),
            ),
            // EditButton(
            //   buttonType: 'docaddress',
            //   data: address,
            // ),
          ],
        );
      },
    );
  }
}
