import 'package:auto_route/auto_route.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lp_customer_onboarding/core/router/router.gr.dart';
import 'package:lp_customer_onboarding/core/router/router_pod.dart';
import 'package:lp_customer_onboarding/core/styles/text_styles.dart';
import 'package:lp_customer_onboarding/features/otp_verify/controller/login_btn_enable_pod.dart';
import 'package:lp_customer_onboarding/features/otp_verify/controller/login_otp_verify_notifier_pod.dart';
import 'package:lp_customer_onboarding/features/otp_verify/controller/timer_notifer_pod.dart';
import 'package:lp_customer_onboarding/l10n/l10n.dart';
import 'package:lp_customer_onboarding/shared/helper/global_helper.dart';
import 'package:lp_customer_onboarding/widgets/action_button.dart';
import 'package:lp_customer_onboarding/widgets/custom_text.dart';
import 'package:lp_customer_onboarding/widgets/formbuilder_animated_pin_field.dart';
import 'package:lp_customer_onboarding/widgets/screen_layout.dart';
import 'package:slide_countdown/slide_countdown.dart';
import 'package:velocity_x/velocity_x.dart';

@RoutePage()
class OtpVerifyPage extends ConsumerStatefulWidget {
  final String mobileNumber;
  final bool isCustomerRevalidation;
  final bool isNormalMode;
  const OtpVerifyPage(
      {required this.isCustomerRevalidation,
      required this.isNormalMode,
      required this.mobileNumber,
      super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginOtpPageState();
}

class _LoginOtpPageState extends ConsumerState<OtpVerifyPage>
    with GlobalHelper {
  final pinPutController = TextEditingController();
  void verifyOtp() {
    final l10n = context.l10n;
    showLoading(message: "Verify OTP");
    ref.read(loginOtpVerifiyNotifierPod.notifier).verifyMobileOtp(
          verificationCode: pinPutController.text,
          onSuccess: () {
            otpSuccessNaviagation();
            hideDialog();
            clearText();
          },
          warning: () {
            hideDialog();
            clearText();
            showPopupDialog(
              title: 'Warning!!',
              description: l10n?.dialogue_error,
              dialogType: DialogType.warning,
              backTimes: 1,
            );
          },
          onError: (errorMessage) {
            hideDialog();
            clearText();
            showPopupDialog(
              title: '',
              description:
                  errorMessage == "Error" ? l10n?.dialogue_error : errorMessage,
              dialogType: DialogType.error,
              backTimes: 1,
            );
          },
          mobileNumber: widget.mobileNumber,
        );
  }

  void resendMobileOtp() {
    final l10n = context.l10n;
    pinPutController.clear();
    showLoading(message: "Resending OTP");
    ref.read(loginOtpVerifiyNotifierPod.notifier).resendMobileOTP(
          phoneNumber: widget.mobileNumber,
          onSuccess: (successMessage) {
            hideDialog();
            clearText();
            showInfoSnack(
                duration: const Duration(seconds: 5),
                text:
                    "Successfully Resended OTP is : ${successMessage.message}");
          },
          warning: (warningMessage) {
            hideDialog();
            clearText();
            showPopupDialog(
              title: 'Warning!!',
              description: l10n?.dialogue_error26,
              dialogType: DialogType.warning,
              backTimes: 1,
            );
          },
          onError: (errorMessage) {
            hideDialog();
            clearText();
            showPopupDialog(
              title: '',
              description: l10n?.dialogue_error,
              dialogType: DialogType.error,
              backTimes: 1,
            );
          },
        );
  }

  void otpSuccessNaviagation() {
    print("Normale mode${widget.isNormalMode}");
    if (!widget.isNormalMode) {
      if (widget.isCustomerRevalidation) {
        ref.read(autorouterProvider).replaceAll([
          const CustomerRevalidationRoute(),
        ]);
      } else {
        ref
            .read(autorouterProvider)
            .replaceAll([const RegistrationNameRoute()]);
      }
    } else {
      if (widget.isCustomerRevalidation) {
        ref.read(autorouterProvider).replaceAll([
          const CustomerRevalidationRoute(),
        ]);
      } else {
        ref.read(autorouterProvider).replaceAll([
          //   DocumentUploadRoute(selctedName: "Document Upload")
          const DocumentUploadRoute()
        ]);
      }
    }
  }

  void clearText() {
    pinPutController.clear();
  }

  @override
  void dispose() {
    pinPutController.dispose();
    // hideDialog();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
      ),
      body: ScreenLayout(
        titleText: l10n?.otp_title,
        subtitleText: l10n?.otp_subtitle,
        child: SizedBox(
          width: context.screenWidth * 0.8,
          child: Column(
            children: [
              const SizedBox(height: 50),
              FormBuilderAnimatedPinField(
                name: "loginOtp",
                pinputcontroller: pinPutController,
                onChanged: (verificationCode) {
                  if (verificationCode.length >= 6) {
                    ref
                        .read(loginBtnEnablePod.notifier)
                        .update((state) => true);
                  } else {
                    ref
                        .read(loginBtnEnablePod.notifier)
                        .update((state) => false);
                  }
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter OTP';
                  } else if (value.length < 6) {
                    return 'Please enter valid OTP';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 100),
              CustomText(
                  textAlign: TextAlign.center,
                  text: l10n?.otp_description,
                  style: CustomTextStyle.subtitleStyle(Colors.black)),
              const SizedBox(height: 30),
              Consumer(
                builder: (_, WidgetRef ref, __) {
                  return ref.watch(resendOTPtimernotifierPod)
                      ? Container()
                      : const SlideCountdown(
                          duration: Duration(seconds: 60),
                          showZeroValue: false,
                          separatorType: SeparatorType.title,
                          slideDirection: SlideDirection.up,
                        );
                },
              ),
              const SizedBox(height: 30),
              Consumer(
                builder: (_, WidgetRef ref, __) {
                  final isEnableResendBtn =
                      ref.watch(resendOTPtimernotifierPod);
                  return InkWell(
                    onTap: isEnableResendBtn
                        ? () {
                            resendMobileOtp();
                          }
                        : null,
                    child: CustomText(
                      textAlign: TextAlign.center,
                      text: l10n?.otp_resend,
                      style: CustomTextStyle.subtitle2Style(isEnableResendBtn
                          ? Theme.of(context).primaryColor
                          : Colors.grey),
                    ),
                  );
                },
              ),
              const Spacer(),
              Align(
                alignment: Alignment.bottomCenter,
                child: Consumer(
                  builder: (_, WidgetRef ref, __) {
                    final isLoginBtnEnable = ref.watch(loginBtnEnablePod);
                    return ActionButton(
                      key: const Key("veryOtpKey"),
                      onPressed: isLoginBtnEnable
                          ? () async {
                              verifyOtp();
                            }
                          : null,
                      buttonText: l10n?.util_continue_button,
                      buttonEnabled: isLoginBtnEnable,
                    );
                  },
                ),
              ).pOnly(bottom: 30),
            ],
          ),
        ),
      ),
    );
  }
}
