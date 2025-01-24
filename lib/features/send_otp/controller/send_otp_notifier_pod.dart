import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lp_customer_onboarding/features/send_otp/controller/notifier/send_otp_notifier.dart';

final sendOtpNotifierPod =
    AutoDisposeAsyncNotifierProvider<SendOtpNotifier, void>(
        SendOtpNotifier.new);
