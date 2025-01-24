import 'package:flutter_riverpod/flutter_riverpod.dart';

final followUpPod = StateProvider.autoDispose<bool>((ref) {
  return false;
});
