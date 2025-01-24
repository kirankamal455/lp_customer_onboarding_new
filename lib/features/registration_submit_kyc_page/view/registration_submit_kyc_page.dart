import 'package:auto_route/annotations.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lp_customer_onboarding/core/router/router.gr.dart';
import 'package:lp_customer_onboarding/core/router/router_pod.dart';
import 'package:lp_customer_onboarding/features/custom_video_screen/presentation/custom_video_page.dart';
import 'package:lp_customer_onboarding/features/registration_submit_kyc_page/controller/registration_submit_kyc_notifier_pod.dart';
import 'package:lp_customer_onboarding/features/registration_submit_kyc_page/controller/sending_progress_pod.dart';
import 'package:lp_customer_onboarding/features/registration_submit_kyc_page/view/widgets/progress_indicator.dart';
import 'package:lp_customer_onboarding/l10n/l10n.dart';
import 'package:lp_customer_onboarding/shared/helper/global_helper.dart';

@RoutePage()
class RegistrationSubmitKycPage extends ConsumerStatefulWidget {
  const RegistrationSubmitKycPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _RegistrationSubmitKycPageState();
}

class _RegistrationSubmitKycPageState
    extends ConsumerState<RegistrationSubmitKycPage> with GlobalHelper {
  void submitKyc() {
    final l10n = context.l10n;

    showSendingProgress(
      message: "Uploading...",
      child: const SendingProgressIndicator(),
    );
    ref.read(registrationSubmitKycNotifierPod.notifier).submitKyc(
      onSuccess: () {
        hideDialog();
        ref.read(autorouterProvider).replaceAll(
            [RegistrationSuccessRoute(isRegistrationPending: true)]);
      },
      warning: (w) {
        ref.invalidate(sendingProgressPod);

        hideDialog();
        showPopupDialog(
          title: 'Warning!!',
          description: l10n!.dialogue_error26,
          dialogType: DialogType.warning,
          backTimes: 1,
        );
      },
      onError: (errorMessage) {
        hideDialog();
        ref.invalidate(sendingProgressPod);
        showPopupDialog(
          title: 'ERROR',
          description: errorMessage,
          dialogType: DialogType.error,
          backTimes: 1,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return CustomVideoPage(
      onSubmitVideo: () {
        submitKyc();
      },
    );
  }
}
