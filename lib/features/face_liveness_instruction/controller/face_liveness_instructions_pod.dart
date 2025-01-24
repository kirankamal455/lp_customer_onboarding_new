import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lp_customer_onboarding/data/model/liveness_instruction_model.dart';
import 'package:lp_customer_onboarding/data/model/livenss_instruction_response_model.dart';
import 'package:lp_customer_onboarding/data/repositories/login/login_repo_pod.dart';
import 'package:lp_customer_onboarding/shared/riverpod_ext/cancel_extensions.dart';

final faceLivenessInstructionPod =
    FutureProvider.autoDispose<LivenssIntructionsResponseModel>((ref) async {
  final result = await ref.watch(loginRepoPod).getLivenessInstructions(
        cancelToken: ref.cancelToken(),
      );
  return result.when(
    (success) {
      return success;
    },
    (error) async {
      throw error.message;
    },
  );
});
