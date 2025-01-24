import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pinput/pinput.dart';

class FormBuilderAnimatedPinField extends StatelessWidget {
  final void Function(String)? onSubmitted;
  final void Function(String)? onChanged;
  final TextEditingController? pinputcontroller;
  final String? Function(String?)? validator;
  final String name;
  final String? initialvalue;
  const FormBuilderAnimatedPinField({
    super.key,
    this.onSubmitted,
    this.onChanged,
    this.pinputcontroller,
    this.validator,
    required this.name,
    this.initialvalue,
  });

  @override
  Widget build(BuildContext context) {
    const fillColor = Color.fromRGBO(243, 246, 249, 0);
    const borderColor = Color.fromRGBO(23, 171, 144, 0.4);
    final defaultPinTheme = PinTheme(
      width: 40,
      height: 40,
      textStyle: const TextStyle(fontSize: 30),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: borderColor),
      ),
    );
    return Pinput(
      obscureText: true,
      length: 6,
      controller: pinputcontroller,
      defaultPinTheme: defaultPinTheme,
      focusedPinTheme: defaultPinTheme.copyWith(
        decoration: defaultPinTheme.decoration!.copyWith(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Theme.of(context).primaryColor),
        ),
      ),
      errorTextStyle: const TextStyle(fontSize: 12, color: Colors.red),
      errorBuilder: (errorText, pin) {
        return Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Center(
              child: Text(
            "$errorText",
            style: const TextStyle(color: Colors.red),
          )),
        );
      },
      submittedPinTheme: defaultPinTheme.copyWith(
        decoration: defaultPinTheme.decoration!.copyWith(
          color: fillColor,
          borderRadius: BorderRadius.circular(19),
          border: Border.all(color: Theme.of(context).primaryColor),
        ),
      ),
      errorPinTheme: defaultPinTheme.copyBorderWith(
        border: Border.all(color: Colors.redAccent),
      ),
      followingPinTheme: defaultPinTheme.copyWith(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
          border: Border.all(
            color: Theme.of(context).primaryColor,
          ),
        ),
      ),
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
      ],
      onSubmitted: onSubmitted,
      onChanged: onChanged,
      validator: validator,
    );
  }
}
