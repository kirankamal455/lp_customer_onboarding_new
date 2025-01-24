import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lp_customer_onboarding/data/repositories/login/login_repo_pod.dart';

final customeOnboardingModePod =
    FutureProvider.autoDispose<bool>((ref) async {
  final result = await ref.watch(loginRepoPod).getCustomerOnboardingMode();
  return result.when(
    (success) {
      return success;
    },
    (error) async {
      throw error.message;
    },
  );
});
