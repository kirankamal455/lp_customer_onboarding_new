import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lp_customer_onboarding/features/submit_btn/widget/custom_fos_btn.dart';
import 'package:lp_customer_onboarding/features/update_document_btn/controller/update_document_btn_notifier_pod.dart';
import 'package:lp_customer_onboarding/features/update_document_btn/state/udate_document_btn_state.dart';

class UpdateDocumentBtnView extends ConsumerWidget {
  final Function() submit;

  const UpdateDocumentBtnView({super.key, required this.submit});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final updateDocumnetAsyncState = ref.watch(updateDocumentAsyncNotifierPod);
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
        padding: const EdgeInsets.only(right: 20, left: 20, top: 7, bottom: 5),
        child: updateDocumnetAsyncState.when(
          data: (data) {
            return switch (data) {
              InitialUpdateDocumentBtnState() => CustomFosButton(
                  disableButton: false,
                  submit: submit,
                  label: "Submit",
                  isLoading: false,
                  percent: 0,
                  isLinearLoadingindicator: true,
                ),
              SubmitUpdateDocumentBtnLoadingState() => CustomFosButton(
                  disableButton: true,
                  submit: submit,
                  label: "Loading",
                  isLoading: true,
                  percent: 0,
                  isLinearLoadingindicator: true,
                ),
              SubmitUpdateDocumentBtnSuccessState() => CustomFosButton(
                  disableButton: false,
                  submit: submit,
                  label: "Submit",
                  isLoading: false,
                  percent: 0,
                  isLinearLoadingindicator: true,
                ),
              SubmitUpdateDocumentBtnErrorState() => CustomFosButton(
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
