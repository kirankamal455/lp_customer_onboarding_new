import 'dart:async';
import 'dart:developer';

import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:lp_customer_onboarding/data/service/db/db_service_pod.dart';
import 'package:lp_customer_onboarding/init.dart';

import 'package:lp_customer_onboarding/shared/riverpod_ext/riverpod_observer.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:talker_flutter/talker_flutter.dart';

final talker = TalkerFlutter.init(
  settings: TalkerSettings(),
  logger: TalkerLogger(
    output: debugPrint,
  ),
);

Future<void> bootstrap(
  FutureOr<Widget> Function() builder, {
  List<Override> overrides = const [],
  List<ProviderObserver>? observers,
  ProviderContainer? parent,
}) async {
  FlutterError.onError = (details) {
    log(details.exceptionAsString(), stackTrace: details.stack);
  };
  //WidgetsFlutterBinding.ensureInitialized();
  // Add cross-flavor configuration here
  // final appStorage = AppStorage();
  // await appStorage.initAppStorage();
  // HydratedStorage.storage = await HiveHydratedStorage.build(
  //   storageDirectoryPath: kIsWeb ? '' : (await getTemporaryDirectory()).path,
  // );
  await Hive.initFlutter('lp_customer_onboarding');
  await init();

  // final storage = await HydratedStorage.build(
  //   storageDirectory:
  //       kIsWeb ? HydratedStorage.storage : await getTemporaryDirectory(),
  //   encryptionCipher: HydratedAesCipher(encryptionKey),
  // );
  // HydratedRiverpod.initialize(storage: storage);
  final userbox = await getUserBox();
  await SentryFlutter.init((options) {
    options.dsn =
        'https://299affdd32e524080b763900749211e3@o4508652200198144.ingest.us.sentry.io/4508652210225152';
    // Set tracesSampleRate to 1.0 to capture 100% of transactions for tracing.
    // We recommend adjusting this value in production.
    options.tracesSampleRate = 1.0;
    // The sampling rate for profiling is relative to tracesSampleRate
    // Setting to 1.0 will profile 100% of sampled transactions:
    options.profilesSampleRate = 1.0;
  },
      appRunner: () async => runApp(
            ProviderScope(
              overrides: [
                userBoxPod.overrideWith((ref) => userbox),
                ...overrides,
              ],
              observers: [
                MyObserverLogger(
                  talker: talker,
                ),
                ...observers ?? [],
              ],
              parent: parent,
              child: await builder(),
            ),
          ));
}
