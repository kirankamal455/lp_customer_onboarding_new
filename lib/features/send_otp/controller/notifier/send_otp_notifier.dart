import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lp_customer_onboarding/bootstrap.dart';
import 'package:lp_customer_onboarding/data/model/send_otp_resposne_model.dart';
import 'package:lp_customer_onboarding/data/repositories/login/login_repo_pod.dart';
import 'package:lp_customer_onboarding/data/service/db/db_service_pod.dart';
import 'package:lp_customer_onboarding/shared/riverpod_ext/cancel_extensions.dart';

class SendOtpNotifier extends AutoDisposeAsyncNotifier<void> {
  @override
  build() {}

  void sendLoginOtp(
      {required String phoneNumber,
      required void Function(SendOTPResponseModel addUserModel) onSuccess,
      required void Function(String errorMessage) onError,
      required void Function(String warningMessage) warning}) async {
    final result = await ref.watch(loginRepoPod).sendLoginOtp(
          phoneNumber: phoneNumber,
          cancelToken: ref.cancelToken(),
        );

    result.when(
      (usermodel) async {
        if (usermodel.isSuccess) {
          await ref
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

  void sendNewUserOtp(
      {required String phoneNumber,
      required void Function(SendOTPResponseModel addUserModel) onSuccess,
      required void Function(String errorMessage) onError,
      required void Function(String warningMessage) warning}) async {
    final result = await ref
        .watch(loginRepoPod)
        .addUserPhoneNumber(phoneNumber: phoneNumber);

    result.when(
      (usermodel) async {
        if (usermodel.isSuccess) {
          await ref
              .read(dbServicePod)
              .saveUniqueUserId(uniqueUserId: usermodel.uniqueUserId);
          onSuccess(usermodel);
        } else {
          warning(usermodel.message);
        }
      },
      (error) {
        talker.error("sendNewUserOtp error ${error.message}");
        onError(error.message);
      },
    );
  }
}
