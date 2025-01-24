 import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lp_customer_onboarding/features/registration_submit_kyc_page/controller/notifier/registration_submit_kyc_notifier.dart';

final registrationSubmitKycNotifierPod =
    AutoDisposeAsyncNotifierProvider<RegistrationSubmitKycNotifier, void>(
        RegistrationSubmitKycNotifier.new);
