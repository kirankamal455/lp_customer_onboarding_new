import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lp_customer_onboarding/features/update_document_btn/controller/notifier/update_document_btn_notifier.dart';
import 'package:lp_customer_onboarding/features/update_document_btn/state/udate_document_btn_state.dart';

final updateDocumentAsyncNotifierPod =
    AutoDisposeAsyncNotifierProvider<UpdateDocumentBtnNotifier, UpdateDocumentBtnState>(
        UpdateDocumentBtnNotifier.new);
