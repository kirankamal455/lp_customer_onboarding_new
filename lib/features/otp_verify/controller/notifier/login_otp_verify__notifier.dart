import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lp_customer_onboarding/data/model/send_otp_resposne_model.dart';
import 'package:lp_customer_onboarding/data/model/user_model.dart';
import 'package:lp_customer_onboarding/data/repositories/login/login_repo_pod.dart';
import 'package:lp_customer_onboarding/data/service/db/db_service_pod.dart';
import 'package:lp_customer_onboarding/shared/riverpod_ext/cancel_extensions.dart';

class LoginOtpVerifyNotifier extends AutoDisposeAsyncNotifier<void> {
  @override
  build() {}

  void verifyOtp(
      {required String verificationCode,
      required String mobileNumber,
      required void Function() onSuccess,
      required void Function(String errorMessage) onError,
      required void Function() warning}) async {
    final result = await ref.watch(loginRepoPod).verifyMobileOtp(
          verificationCode: verificationCode,
          userId: "",
          cancelToken: ref.cancelToken(),
        );

    result.when(
      (verifyOtpModel) async {
        if (verifyOtpModel.isSuccess) {
          await ref.read(dbServicePod).saveUser(UserModel(
                secureDeviceId: verifyOtpModel.secureDeviceId,
                uniqueUserId: mobileNumber,
              ));

          final token = await ref.watch(loginRepoPod).getToken();
          token.when((token) async {
            await ref.read(dbServicePod).saveToken(token: token);

            // onOTPVerificationNavigate();
            onSuccess();
          }, (error) {
            onError(error.message);
          });
        } else {
          warning();
        }
      },
      (error) {
        onError(error.message);
      },
    );
  }

  void verifyMobileOtp(
      {required String verificationCode,
      required void Function() onSuccess,
      required String mobileNumber,
      required void Function(String errorMessage) onError,
      required void Function() warning}) async {
    final result = await ref
        .watch(loginRepoPod)
        .verifyMobileOtp(verificationCode: verificationCode, userId: "");

    result.when(
      (verifyOtpModel) async {
        if (verifyOtpModel.isSuccess) {
          await ref.read(dbServicePod).saveUser(UserModel(
              secureDeviceId: verifyOtpModel.secureDeviceId,
              uniqueUserId: mobileNumber));

          final token = await ref.watch(loginRepoPod).getToken();
          token.when((token) async {
            await ref.read(dbServicePod).saveToken(token: token);

            onSuccess();
          }, (error) {
            onError(error.message);
          });
        } else {
          warning();
        }
      },
      (error) {
        onError(error.message);
      },
    );
  }

  void resendMobileOTP(
      {required String phoneNumber,
      required void Function(SendOTPResponseModel addUserModel) onSuccess,
      required void Function(String errorMessage) onError,
      required void Function(String warningMessage) warning}) async {
    final result = await ref
        .watch(loginRepoPod)
        .addUserPhoneNumber(phoneNumber: phoneNumber);

    result.when(
      (usermodel) {
        if (usermodel.isSuccess) {
          ref
              .read(dbServicePod)
              .saveUniqueUserId(uniqueUserId: usermodel.uniqueUserId);
          onSuccess(usermodel);
        } else {
          warning(usermodel.message);
        }
      },
      (error) {
        onError(error.message);
      },
    );
  }

  // Future<void> onOTPVerificationNavigate() async {
  //   final autcredentialmodel =
  //       await ref.watch(dbServicePod).getAuthCredentialModel();

  //   // /old user re-login
  //   if (autcredentialmodel != null && autcredentialmodel.authtype != "") {
  //     talker.error(autcredentialmodel.authtype);
  //     talker.error(autcredentialmodel.credential);
  //     if (autcredentialmodel.authtype == 'device') {
  //       // await handleDeviceAuth();
  //     } else if (autcredentialmodel.authtype == 'pin') {
  //       // ref.read(autorouterProvider).navigate(
  //       //     AuthPinVerificationRoute(pintype: PINTYPE.applicationpin));
  //     }
  //   } else {
  //     ref.read(autorouterProvider).replaceAll([const AuthenticationRoute()]);
  //   }
  // }

  // Future<void> handleDeviceAuth() async {
  //   onAuthenticateFingerPrint(
  //     onAuthenticated: () {
  //       talker.good("Authenticated");
  //     },
  //     onError: (error, isWarning) {},
  //     onSuccess: (message) {},
  //   );
  // }

  // Future<void> onAuthenticateFingerPrint({
  //   required void Function() onAuthenticated,
  //   required void Function(String error, bool isWarning) onError,
  //   required void Function(String message) onSuccess,
  // }) async {
  //   final authService = ref.watch(authServicePod);
  //   if (await authService.isDeviceSupportedBiometrics()) {
  //     var result = await authService.authenticateBiometrics();

  //     result.when((success) async {
  //       if (success) {
  //         onSuccess('Authentication Successful');
  //         onAuthenticated();
  //       } else {
  //         onError('Failed to authenticate fingerprint', false);
  //       }
  //     }, (error) {
  //       onError(error.message, true);
  //     });
  //   } else {
  //     onError(
  //       'This device does not support biometrics.So please choose PIN instead',
  //       true,
  //     );
  //   }
  // }
}
