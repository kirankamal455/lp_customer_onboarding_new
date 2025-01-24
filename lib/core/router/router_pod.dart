import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lp_customer_onboarding/core/router/router.dart';
import 'package:lp_customer_onboarding/data/service/db/db_service_pod.dart';

final navigatorKey = GlobalKey<NavigatorState>();

final autorouterProvider = Provider.autoDispose(
  (ref) => AppRouter(iUserDbService: ref.read(dbServicePod)),
  name: 'autorouterProvider',
);
