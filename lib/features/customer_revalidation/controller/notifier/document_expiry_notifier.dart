import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lp_customer_onboarding/features/customer_revalidation/controller/document_expiry_check_pod.dart';
import 'package:lp_customer_onboarding/features/customer_revalidation/state/document_expiry_state.dart';

final documentExpiryNotifierProvider = AutoDisposeAsyncNotifierProvider<
    DocumentExpiryNotifier,
    DocumentExpiryCheckState>(DocumentExpiryNotifier.new);

class DocumentExpiryNotifier
    extends AutoDisposeAsyncNotifier<DocumentExpiryCheckState> {
  @override
  FutureOr<DocumentExpiryCheckState> build() {
    callApi();
    return future;
  }

  void callApi() async {
    state = const AsyncValue.loading();
    try {
      final result = await ref.watch(documentExpiryCheckPod.future);
      if (!result.isSuccess && result.errorCode == 200) {
        state = AsyncValue.data(DocumentExpiredState(
            docmentType: result.data,
            isDocumentIntelligenceEnabled:
                result.isDocumentIntelligenceEnabled));
      } else if (result.isSuccess && result.errorCode == 200) {
        state =
            AsyncValue.data(DocumentNotExpiredState(docmentType: result.data));
      } else if (result.errorCode == 400 && result.isSuccess == false) {
        //state = AsyncValue.data(DocumentExpiredState());
        state = AsyncValue.data(DocumentExpiryNoDataState());
      } else {
        state = AsyncValue.error(result, StackTrace.current);
      }
    } catch (e) {
      state = AsyncValue.error(e.toString(), StackTrace.current);
    }
  }
}
