import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final isDebugModeCheckerPod =
    StateProvider.autoDispose.family<bool, bool>((ref, mode) {
  return kDebugMode ? true : false;
});
