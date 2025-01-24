import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lp_customer_onboarding/data/model/document_expiry_check_response_model.dart';
import 'package:lp_customer_onboarding/data/repositories/login/login_repo_pod.dart';

final documentExpiryCheckPod =
    FutureProvider.autoDispose<DocumentExpiryCheckReponseModel>((ref) async {
  final result = await ref.watch(loginRepoPod).documentExpirationCheck();
  return result.when(
    (success) {
      return success;
    },
    (error) async {
      throw error.message;
    },
  );
});
