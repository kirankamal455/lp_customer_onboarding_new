import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lp_customer_onboarding/core/local_storage/app_storage.dart';

final appStorageProvider = Provider.autoDispose<AppStorage>(
  (_) {
    throw UnimplementedError();
  },
  name: 'appStorageProvider',
);
