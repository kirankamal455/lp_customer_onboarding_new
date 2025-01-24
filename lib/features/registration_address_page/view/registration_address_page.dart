import 'package:auto_route/annotations.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:gap/gap.dart';
import 'package:lp_customer_onboarding/core/router/router.gr.dart';
import 'package:lp_customer_onboarding/core/router/router_pod.dart';
import 'package:lp_customer_onboarding/l10n/l10n.dart';
import 'package:lp_customer_onboarding/shared/pods/user_register_pod.dart';
import 'package:lp_customer_onboarding/widgets/action_button.dart';
import 'package:lp_customer_onboarding/widgets/screen_layout.dart';

@RoutePage()
class RegistrationAddressPage extends ConsumerStatefulWidget {
  const RegistrationAddressPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _RegistrationAddressPageState();
}

class _RegistrationAddressPageState
    extends ConsumerState<RegistrationAddressPage> {
  final _formkey = GlobalKey<FormBuilderState>();

  void submit() {
    if (_formkey.currentState!.validate()) {
      final address1 = _formkey.currentState!.fields["Addreess"]!.value;
      //final address2 = _formkey.currentState!.fields["Addreess2"]!.value;
      final city = _formkey.currentState!.fields["city"]!.value;
      final postcode = _formkey.currentState!.fields["postcode"]!.value;
      final country = _formkey.currentState!.fields["country"]!.value;
      final state = _formkey.currentState!.fields["state"]!.value;
      final userRegisterState =
          ref.read(userRegisterProvider.notifier).state.address;
      userRegisterState.addressline1 = address1;
      userRegisterState.addressline2 = "";
      userRegisterState.city = city;
      userRegisterState.postalCode = postcode;
      userRegisterState.country = country;
      userRegisterState.longitude = "5888394934.45";
      userRegisterState.lattittude = "3434343445.54";
      userRegisterState.state = state;
      userRegisterState.street = address1;

      ref.read(autorouterProvider).navigate(const EKYCOnboardingRoute());
    }
  }

  @override
  void dispose() {
    _formkey.currentState?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0.1,
        backgroundColor: Colors.transparent,
      ),
      body: ScreenLayout(
        titleText: l10n!.address_title,
        subtitleText: l10n.address_subtitle,
        child: Padding(
          padding: const EdgeInsets.only(left: 28, right: 28),
          child: Center(
            child: FormBuilder(
              key: _formkey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                children: [
                  Expanded(
                    child: ListView(
                      physics: const NeverScrollableScrollPhysics(),
                      padding: const EdgeInsets.symmetric(vertical: 40),
                      children: [
                        FormBuilderTextField(
                          name: "Addreess",
                          // key: TestKeys.address1TextFieldKey,
                          decoration:
                              const InputDecoration(labelText: "Address"),
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.name,
                          textCapitalization: TextCapitalization.sentences,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(35)
                          ],
                          validator: FormBuilderValidators.compose(
                            [
                              FormBuilderValidators.required(
                                  errorText: l10n.dob_validator_error_msg),
                            ],
                          ),
                        ),
                        // const Gap(20),
                        // FormBuilderTextField(
                        //   // key: TestKeys.address2TextFieldKey,
                        //   name: "Addreess2",
                        //   decoration:
                        //       InputDecoration(labelText: l10n.address_line_2),
                        //   textInputAction: TextInputAction.next,
                        //   keyboardType: TextInputType.name,
                        //   textCapitalization: TextCapitalization.sentences,
                        //   inputFormatters: [
                        //     LengthLimitingTextInputFormatter(55)
                        //   ],
                        //   validator: FormBuilderValidators.compose(
                        //     [
                        //       FormBuilderValidators.required(
                        //           errorText: l10n.address_line2_error_msg),
                        //     ],
                        //   ),
                        // ),
                        const Gap(20),
                        FormBuilderTextField(
                          //  key: TestKeys.cityTextFieldKey,
                          name: "city",
                          decoration:
                              InputDecoration(labelText: l10n.address_city),
                          textInputAction: TextInputAction.next,
                          textCapitalization: TextCapitalization.sentences,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(25)
                          ],
                          keyboardType: TextInputType.name,
                          validator: FormBuilderValidators.compose(
                            [
                              FormBuilderValidators.required(
                                  errorText: l10n.address_city_error_msg),
                            ],
                          ),
                        ),
                        const Gap(20),
                        FormBuilderTextField(
                          // key: TestKeys.postCodeTextFieldKey,
                          name: "state",
                          decoration: const InputDecoration(labelText: "State"),
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.text,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(20)
                          ],
                          validator: FormBuilderValidators.compose(
                            [
                              FormBuilderValidators.required(
                                  errorText: "Please enter State"),
                            ],
                          ),
                        ),
                        const Gap(20),
                        FormBuilderTextField(
                          // key: TestKeys.countryNameTextFieldKey,
                          name: "country",
                          decoration:
                              InputDecoration(labelText: l10n.address_country),
                          textInputAction: TextInputAction.done,
                          keyboardType: TextInputType.name,
                          textCapitalization: TextCapitalization.sentences,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(25)
                          ],
                          validator: FormBuilderValidators.compose(
                            [
                              FormBuilderValidators.required(
                                  errorText: l10n.address_country_error_msg),
                            ],
                          ),
                        ),
                        const Gap(20),
                        FormBuilderTextField(
                          // key: TestKeys.postCodeTextFieldKey,
                          name: "postcode",
                          decoration:
                              InputDecoration(labelText: l10n.address_zipcode),
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.text,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(8)
                          ],
                          validator: FormBuilderValidators.compose(
                            [
                              FormBuilderValidators.required(
                                  errorText: l10n.address_zipcode_error_msg),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 40),
                      child: Consumer(
                        builder: (_, WidgetRef ref, __) {
                          return ActionButton(
                            // key: TestKeys.addressSubmitBtnKey,
                            onPressed: () {
                              submit();
                            },
                            buttonText: l10n.util_continue_button,
                            buttonEnabled: true,
                          );
                        },
                      ),
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
