import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lp_customer_onboarding/features/submit_btn/controller/submit_fos_btn_notifier_pod.dart';
import 'package:lp_customer_onboarding/features/submit_btn/state/submit_fos_btn_state.dart';
import 'package:lp_customer_onboarding/features/submit_btn/widget/custom_fos_btn.dart';

class SubmitFosBtnView extends ConsumerWidget {
  final Function() submit;

  const SubmitFosBtnView({super.key, required this.submit});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final submitState = ref.watch(submitFosAsyncNotifierPod);
    return Container(
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(
            color: Colors.grey,
            width: 0.3,
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(right: 20, left: 20, top: 7, bottom: 25),
        child: submitState.when(
          data: (data) {
            return switch (data) {
              InitialSubmitFOSBtnState() => CustomFosButton(
                  disableButton: false,
                  submit: submit,
                  label: "Submit",
                  isLoading: false,
                  percent: 0,
                  isLinearLoadingindicator: true,
                ),
              // FetchLocationLoadingState() => CustomFosButton(
              //     disableButton: true,
              //     submit: submit,
              //     label: "Fetching Location",
              //     isLoading: false,
              //     percent: 0,
              //   ),
              SubmitFOSBtnLoadingState() => CustomFosButton(
                  disableButton: true,
                  submit: submit,
                  label: "Loading",
                  isLoading: true,
                  percent: data.percentage,
                  isLinearLoadingindicator: true,
                ),
              SubmitFOSBtnSuccessState() => CustomFosButton(
                  disableButton: false,
                  submit: submit,
                  label: "Submit",
                  isLoading: false,
                  percent: 0,
                  isLinearLoadingindicator: true,
                ),
              SubmitFOSBtnErrorState() => CustomFosButton(
                  disableButton: false,
                  submit: submit,
                  label: "Retry",
                  isLoading: false,
                  percent: 0,
                  isLinearLoadingindicator: true,
                ),
            };
          },
          error: (error, stackTrace) => CustomFosButton(
            disableButton: false,
            submit: submit,
            label: "Retry",
            isLoading: false,
            percent: 0,
            isLinearLoadingindicator: true,
          ),
          loading: () => CustomFosButton(
            disableButton: false,
            submit: submit,
            label: "Loading",
            isLoading: true,
            percent: 0,
            isLinearLoadingindicator: true,
          ),
        ),
      ),
    );
  }
}
