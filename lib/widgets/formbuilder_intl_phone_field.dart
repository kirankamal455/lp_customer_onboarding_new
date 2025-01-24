import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class FormBuilderIntlPhoneField extends StatelessWidget {
  final String name;
  final void Function(String)? onSubmitted;
  final Color hintColor;
  final Color dropDownColor;
  final Color errorColor;
  final Color labelColor;
  final Color phoneNumberColor;
  final Color borderSideColor;
  final Color dropDownTextColor;
  final TextEditingController? controller;
  const FormBuilderIntlPhoneField({
    super.key,
    required this.name,
    this.onSubmitted,
    required this.hintColor,
    required this.dropDownColor,
    required this.errorColor,
    required this.labelColor,
    required this.phoneNumberColor,
    required this.borderSideColor,
    this.controller,
    required this.dropDownTextColor,
  });

  @override
  Widget build(BuildContext context) {
    return FormBuilderField<String>(
      name: name,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: FormBuilderValidators.compose([
        FormBuilderValidators.required(errorText: "Enter the Mobile Number")
      ]),
      builder: (field) => IntlPhoneField(
        initialValue: field.value,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        style: TextStyle(color: phoneNumberColor),
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        textInputAction: TextInputAction.done,
        onSubmitted: onSubmitted,
        dropdownTextStyle: TextStyle(color: dropDownTextColor),
        dropdownIcon: Icon(
          Icons.arrow_drop_down,
          color: dropDownColor,
        ),
        decoration: InputDecoration(
          labelText: 'Mobile Number',
          errorText: field.errorText,
          errorStyle: TextStyle(color: errorColor),
          counterStyle: const TextStyle(
            color: Colors.white,
          ),
          border: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white)),
          labelStyle: TextStyle(color: labelColor, fontSize: 18),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
        ),
        initialCountryCode: "IN",
        onChanged: (phone) {
          final number = phone.countryCode + phone.number;
          field.didChange(number);
        },
      ),
    );
  }
}
