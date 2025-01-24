import 'package:flutter_riverpod/flutter_riverpod.dart';

final isPop = StateProvider.autoDispose<bool>((ref) {
  return true;  
});