import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:lp_customer_onboarding/bootstrap.dart';
 

final internetCheckerPod = StreamProvider.autoDispose<InternetConnectionStatus>(
  (ref) {
    talker.debug('internet checker started');
    final internetchecker = InternetConnectionChecker.createInstance(
      checkInterval: const Duration(seconds: 15),
    );
    final statuschange = internetchecker.onStatusChange;
    return statuschange.distinct();
  },
  name: 'internetCheckerPod',
);
