import 'dart:developer';

import 'package:auto_route/auto_route.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:lp_customer_onboarding/core/router/router.gr.dart';
import 'package:lp_customer_onboarding/core/router/router_pod.dart';
import 'package:lp_customer_onboarding/l10n/l10n.dart';
import 'package:lp_customer_onboarding/shared/helper/global_helper.dart';
import 'package:lp_customer_onboarding/shared/pods/user_register_pod.dart';
import 'package:lp_customer_onboarding/widgets/action_button.dart';
import 'package:lp_customer_onboarding/widgets/screen_layout.dart';

@RoutePage()
class RegistrationNamePage extends ConsumerStatefulWidget {
  const RegistrationNamePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _RegistrationNamePageState();
}

class _RegistrationNamePageState extends ConsumerState<RegistrationNamePage>
    with GlobalHelper {
  final formkey = GlobalKey<FormBuilderState>();
  var date = DateTime.now().subtract(const Duration(days: 18 * 365));
  void submitPersonalDetails() {
    if (formkey.currentState!.saveAndValidate()) {
      final firstName =
          formkey.currentState!.fields["firstName"]?.value as String;
      final lastName =
          formkey.currentState!.fields["LastName"]?.value as String;
      final middleName =
          formkey.currentState!.fields["MiddleName"]?.value ?? "";
      final gender = formkey.currentState!.fields["gender"]?.value ?? "";
      final dob = formkey.currentState!.fields["Dob"]?.value as DateTime;

      String formattedDate = DateFormat('dd-MM-yyyy').format(dob);
      final userRegisterState = ref.read(userRegisterProvider.notifier).state;
      userRegisterState.fname = firstName;
      userRegisterState.lname = lastName;
      userRegisterState.mname = middleName;
      userRegisterState.gender = gender;
      userRegisterState.dob = formattedDate;

      ref.read(autorouterProvider).navigate(const RegistrationAddressRoute());
      log("data ${formkey.currentState?.fields.entries}");
    }
  }

  @override
  void dispose() {
    formkey.currentState?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
            onPressed: () => onBackPressed(),
            icon: const Icon(Icons.arrow_back)),
        backgroundColor: Colors.transparent,
      ),
      body: PopScope(
        canPop: false,
        onPopInvokedWithResult: (didPop, result) => onBackPressed(),
        child: ScreenLayout(
          titleText: l10n?.name_title,
          subtitleText: l10n?.name_subtitle,
          child: Padding(
            padding: const EdgeInsets.only(left: 28, right: 28),
            child: FormBuilder(
              key: formkey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                children: [
                  const SizedBox(height: 60),
                  FormBuilderTextField(
                    name: "firstName",
                    style: Theme.of(context).textTheme.titleMedium,
                    keyboardType: TextInputType.text,
                    textCapitalization: TextCapitalization.sentences,
                    textInputAction: TextInputAction.next,
                    decoration:
                        InputDecoration(labelText: l10n?.name_first_name),
                    inputFormatters: [LengthLimitingTextInputFormatter(25)],
                    validator: FormBuilderValidators.compose(
                      [
                        FormBuilderValidators.required(
                            errorText: l10n!.name_validator_firstname_error_msg)
                      ],
                    ),
                  ),
                  const Gap(20),
                  FormBuilderTextField(
                    name: "MiddleName",
                    style: Theme.of(context).textTheme.titleMedium,
                    keyboardType: TextInputType.text,
                    textCapitalization: TextCapitalization.sentences,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      labelText: l10n.name_middle_name,
                    ),
                    inputFormatters: [LengthLimitingTextInputFormatter(25)],
                  ),
                  const Gap(20),
                  FormBuilderTextField(
                    name: "LastName",
                    style: Theme.of(context).textTheme.titleMedium,
                    keyboardType: TextInputType.text,
                    textCapitalization: TextCapitalization.sentences,
                    onChanged: (value) {},
                    decoration: InputDecoration(labelText: l10n.name_last_name),
                    inputFormatters: [LengthLimitingTextInputFormatter(25)],
                    validator: FormBuilderValidators.compose(
                      [
                        FormBuilderValidators.required(
                            errorText: l10n.name_validator_lastname_error_msg)
                      ],
                    ),
                  ),
                  const Gap(20),
                  FormBuilderDropdown<String>(
                    name: 'gender',
                    decoration: const InputDecoration(
                      labelText: 'Gender',
                      hintText: 'Select Gender',
                    ),
                    items: ["Male", "Female", "other"]
                        .map((gender) => DropdownMenuItem(
                              alignment: AlignmentDirectional.topStart,
                              value: gender,
                              child: Text(gender),
                            ))
                        .toList(),
                    validator: FormBuilderValidators.compose(
                      [
                        FormBuilderValidators.required(
                            errorText: "Please select gender")
                      ],
                    ),
                  ),
                  const Gap(20),
                  FormBuilderDateTimePicker(
                    name: "Dob",
                    format: DateFormat('dd/MM/yyyy'),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    initialDate: date,
                    firstDate: DateTime(1900),
                    lastDate: date,
                    style: Theme.of(context).textTheme.titleMedium,
                    inputType: InputType.date,
                    decoration: InputDecoration(
                      labelText: l10n.dob_text_form,
                      hintText: l10n.dob_text_form_hint,
                    ),
                    validator: (val) {
                      if (val == null) {
                        return 'Please enter Date of Birth';
                      }
                      final age = DateTime.now().difference(val).inDays / 365;
                      if (age < 18) {
                        return 'You must be 18 years old to continue';
                      }
                      return null;
                    },
                  ),
                  const Spacer(),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Consumer(
                      builder: (_, WidgetRef ref, __) {
                        return ActionButton(
                          onPressed: () async {
                            submitPersonalDetails();
                          },
                          buttonText: l10n.util_continue_button,
                          buttonEnabled: true,
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
