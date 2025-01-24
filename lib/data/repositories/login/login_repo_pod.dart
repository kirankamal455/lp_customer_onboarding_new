import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lp_customer_onboarding/data/provider/login/login_provider_pod.dart';
import 'package:lp_customer_onboarding/data/repositories/login/i_login_repository.dart';
import 'package:lp_customer_onboarding/data/repositories/login/login_repository.dart';
import 'package:lp_customer_onboarding/data/service/db/db_service_pod.dart';

final loginRepoPod = Provider.autoDispose<ILoginRepository>((ref) {
  return LoginRepository(
      loginProvider: ref.watch(loginProviderpod),
      dbService: ref.watch(dbServicePod));
});
