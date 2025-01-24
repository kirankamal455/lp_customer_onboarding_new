import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

class ResendOTPTimerNotifier extends AutoDisposeNotifier<bool> {
  @override
  bool build() {
    startTimer();
    return false;
  }

  void startTimer() {
    state = false;
    Timer(const Duration(seconds: 59), () {
      state = true;
    });
  }
}
