 import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lp_customer_onboarding/features/otp_verify/controller/notifier/timer_notifier.dart';

final resendOTPtimernotifierPod =
    AutoDisposeNotifierProvider<ResendOTPTimerNotifier, bool>(
  ResendOTPTimerNotifier.new,
);
