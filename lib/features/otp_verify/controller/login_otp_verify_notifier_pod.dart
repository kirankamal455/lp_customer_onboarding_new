 import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lp_customer_onboarding/features/otp_verify/controller/notifier/login_otp_verify__notifier.dart';

final loginOtpVerifiyNotifierPod =
    AutoDisposeAsyncNotifierProvider<LoginOtpVerifyNotifier, void>(
        LoginOtpVerifyNotifier.new);
