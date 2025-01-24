// coverage:ignore-file

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lp_customer_onboarding/data/provider/login/i_login_provider.dart';
import 'package:lp_customer_onboarding/data/provider/login/login_provider.dart';
import 'package:lp_customer_onboarding/data/service/db/db_service_pod.dart';
import 'package:lp_customer_onboarding/shared/api_client/dio/dio_client_provider.dart';

final loginProviderpod = Provider.autoDispose<ILoginProvider>((ref) {
  return LoginProvider(
    dio: ref.watch(dioProvider),
    dbService: ref.watch(dbServicePod),
  );
});
