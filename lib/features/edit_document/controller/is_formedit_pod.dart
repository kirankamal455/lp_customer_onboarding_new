import 'package:flutter_riverpod/flutter_riverpod.dart';

final isFormEditPod = StateProvider.autoDispose<bool>((ref) {
  return false;
});
