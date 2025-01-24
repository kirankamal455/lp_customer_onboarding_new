import 'package:flutter_riverpod/flutter_riverpod.dart';

final formValidatePod =
    StateProvider.autoDispose.family<bool, String>((ref, key) {
  return false;
});
