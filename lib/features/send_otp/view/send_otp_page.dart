import 'package:auto_route/auto_route.dart';
import 'package:flutter/foundation.dart';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lp_customer_onboarding/core/router/router.gr.dart';
import 'package:lp_customer_onboarding/core/router/router_pod.dart';
import 'package:lp_customer_onboarding/core/styles/gradient_decoration.dart';
import 'package:lp_customer_onboarding/core/styles/text_styles.dart';
import 'package:lp_customer_onboarding/features/send_otp/controller/send_otp_notifier_pod.dart';
import 'package:lp_customer_onboarding/l10n/l10n.dart';
import 'package:lp_customer_onboarding/shared/helper/global_helper.dart';
import 'package:lp_customer_onboarding/widgets/action_button.dart';
import 'package:lp_customer_onboarding/widgets/custom_text.dart';
import 'package:lp_customer_onboarding/widgets/formbuilder_intl_phone_field.dart';
import 'package:lp_customer_onboarding/widgets/opacity_circles.dart';
import 'package:velocity_x/velocity_x.dart';

@RoutePage()
class SendOtpPage extends ConsumerStatefulWidget {
  final bool isCustomerRevalidation;
  final bool isNormalMode;
  const SendOtpPage(
      {required this.isNormalMode,
      required this.isCustomerRevalidation,
      super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _LoginMobilePageState();
}

class _LoginMobilePageState extends ConsumerState<SendOtpPage>
    with GlobalHelper {
  final formKey = GlobalKey<FormBuilderState>();
  void sendLoginOtp() {
    if (formKey.currentState!.validate()) {
      final mobileNumber =
          formKey.currentState!.fields['mobileNumber']?.value as String;
      final sanitizedPhoneNumber = mobileNumber.replaceAll("+", "");

      showLoading(message: "Sending OTP");

      final otpNotifier = widget.isCustomerRevalidation
          ? ref.read(sendOtpNotifierPod.notifier).sendLoginOtp
          : ref.read(sendOtpNotifierPod.notifier).sendNewUserOtp;

      otpNotifier(
        phoneNumber: sanitizedPhoneNumber,
        onSuccess: (successMessage) =>
            _handleOtpSuccess(successMessage.message, mobileNumber),
        warning: (warningMessage) => _handleWarning(),
        onError: (errorMessage) => _handleError(errorMessage),
      );
    }
  }

  void _handleOtpSuccess(String successMessage, String mobileNumber) {
    hideDialog();
    showInfoSnack(
      duration: const Duration(seconds: 5),
      text: "Successfully sent OTP: $successMessage",
    );
    ref.read(autorouterProvider).replaceAll([
      const WelcomeRoute(),
      OtpVerifyRoute(
        mobileNumber: mobileNumber,
        isCustomerRevalidation: widget.isCustomerRevalidation,
        isNormalMode: widget.isNormalMode,
      ),
    ]);
  }

  void _handleWarning() {
    hideDialog();
    showPopupDialog(
      title: 'Warning!!',
      description: context.l10n?.dialogue_error10,
      dialogType: DialogType.warning,
      backTimes: 1,
    );
  }

  void _handleError(String errorMessage) {
    hideDialog();
    showPopupDialog(
      title: '',
      description: errorMessage,
      dialogType: DialogType.error,
      backTimes: 1,
    );
  }

  @override
  void dispose() {
    formKey.currentState?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: Container(
        decoration: GradientDecoration.gradientDecoration(context),
        child:
            CustomScrollView(physics: const ClampingScrollPhysics(), slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: Column(
              children: [
                SizedBox(
                  height: context.screenHeight * 0.3,
                  child: OpacityCircles(
                    screenSize: MediaQuery.of(context).size,
                    child: Image.asset(
                      "assets/images/a.png",
                      height: 170,
                      //  width: MediaQuery.of(context).size.width * 0.3,
                    ),
                  ),
                ),
                SizedBox(
                  height: context.screenHeight * 0.7,
                  child: Column(
                    children: [
                      SizedBox(height: context.screenHeight * 0.05),
                      CustomText(
                        textAlign: TextAlign.center,
                        text: l10n?.welcome_text,
                        style: CustomTextStyle.welcomeScreenStyle(Colors.white),
                      ),
                      SizedBox(height: context.screenHeight * 0.1),
                      SizedBox(
                        width: context.screenWidth * 0.7,
                        child: FormBuilder(
                          key: formKey,
                          //kDebugMode  // Check if in debug mode

                          initialValue: const {
                            'mobileNumber': kDebugMode ? "918113887254" : ""
                          },
                          child: FormBuilderIntlPhoneField(
                            name: "mobileNumber",
                            dropDownTextColor: Colors.white,
                            borderSideColor: Colors.white,
                            phoneNumberColor: Colors.white,
                            errorColor: Colors.white,
                            labelColor: Colors.white,
                            dropDownColor: Colors.white,
                            hintColor: Colors.white,
                            onSubmitted: (p0) {
                              sendLoginOtp();
                            },
                          ),
                        ),
                      ),
                      const Spacer(),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Consumer(
                          builder: (_, WidgetRef ref, __) {
                            return ActionButton(
                              onPressed: () async {
                                sendLoginOtp();
                              },
                              buttonText: l10n?.util_continue_button,
                              buttonEnabled: true,
                              isLogin: 'Login',
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 30),
                    ],
                  ),
                ),
              ],
            ),
          )
        ]),
      ),
    );
  }
}
