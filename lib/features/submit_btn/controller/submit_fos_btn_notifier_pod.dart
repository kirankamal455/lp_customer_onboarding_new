import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lp_customer_onboarding/features/submit_btn/controller/notifier/submit_fos_btn_notifier.dart';
import 'package:lp_customer_onboarding/features/submit_btn/state/submit_fos_btn_state.dart';

final submitFosAsyncNotifierPod =
    AutoDisposeAsyncNotifierProvider<SubmitFosBtnNotifier, SubmitFOSBtnState>(
        SubmitFosBtnNotifier.new);
