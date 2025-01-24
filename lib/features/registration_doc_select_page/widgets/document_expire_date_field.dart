import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';

class DocumentExpireDateField extends StatelessWidget {
  const DocumentExpireDateField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Gap(18),
        FormBuilderDateTimePicker(
          name: 'docExpireDate',
          inputType: InputType.date,
          format: DateFormat('dd/MM/yyyy'),
          autovalidateMode: AutovalidateMode.onUserInteraction,
          //fieldHintText: 'dd/MM/yyyy',
          errorInvalidText: 'Invalid date selected',
          initialDate: DateTime.now()
              .add(const Duration(days: 1)), // Default to tomorrow
          firstDate: DateTime.now().add(
              const Duration(days: 1)), // Prevent selecting dates before today
          lastDate:
              DateTime(2100), // Set a reasonable last date limit, e.g., 2100
          decoration: const InputDecoration(
            labelText: 'Select Document Expiration Date',
            contentPadding: EdgeInsets.all(16),
            border: OutlineInputBorder(),
          ),
          validator: FormBuilderValidators.compose([
            FormBuilderValidators.required(
              errorText: "Please select the expiration date",
            ),
            (value) {
              if (value == null || value.isBefore(DateTime.now())) {
                return 'Expiration date must be in the future';
              }
              return null;
            },
          ]),
        ),
      ],
    );
  }
}
