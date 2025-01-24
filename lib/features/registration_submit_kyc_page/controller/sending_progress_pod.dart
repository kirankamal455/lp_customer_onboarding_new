import 'package:flutter_riverpod/flutter_riverpod.dart';

final sendingProgressPod = StateProvider.autoDispose<double>((ref) {
  return 0.0;
});
