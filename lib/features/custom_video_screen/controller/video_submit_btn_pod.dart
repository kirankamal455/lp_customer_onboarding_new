import 'package:flutter_riverpod/flutter_riverpod.dart';

final videoSubmitBtnPod = StateProvider.autoDispose<bool>((ref) {
  return false;
});
