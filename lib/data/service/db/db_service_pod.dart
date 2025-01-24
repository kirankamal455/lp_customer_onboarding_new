import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:lp_customer_onboarding/data/service/db/db_service.dart';
import 'package:lp_customer_onboarding/data/service/db/i_db_service.dart';

final dbServicePod = Provider.autoDispose<IDbService>(
  (ref) => DbService(userbox: ref.watch(userBoxPod)),
);

final userBoxPod = Provider.autoDispose<Box>(
  (ref) => throw UnimplementedError('User Box is not initialized'),
);
