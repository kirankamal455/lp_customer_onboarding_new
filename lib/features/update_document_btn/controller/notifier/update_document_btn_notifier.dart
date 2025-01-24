import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lp_customer_onboarding/core/router/router.gr.dart';
import 'package:lp_customer_onboarding/core/router/router_pod.dart';
import 'package:lp_customer_onboarding/data/model/login_response_model.dart';
import 'package:lp_customer_onboarding/data/repositories/login/login_repo_pod.dart';
import 'package:lp_customer_onboarding/features/update_document_btn/state/udate_document_btn_state.dart';
import 'package:lp_customer_onboarding/shared/riverpod_ext/cancel_extensions.dart';

class UpdateDocumentBtnNotifier
    extends AutoDisposeAsyncNotifier<UpdateDocumentBtnState> {
  @override
  FutureOr<UpdateDocumentBtnState> build() {
    return InitialUpdateDocumentBtnState();
  }

  Future<void> updateDocument({
    //required String documentType,
    required Function(String) onError,
    required Function(bool) onSuccess,
    required Function() tokenExpired,
    required String name,
    required String idDocumentNumber,
    required String dateOfBirth,
    required String documentExpiryDate,
    required String gender,
    // required String issuedCountry,
    // required String nationality,
    required String documentIssueDate,
    required String id,
  }) async {
    try {
      state = AsyncData(SubmitUpdateDocumentBtnLoadingState());
      final submitResult = await ref.watch(loginRepoPod).updateDocument(
            //documentType: documentType,
            name: name,
            idDocumentNumber: idDocumentNumber,
            dateOfBirth: dateOfBirth,
            documentExpiryDate: documentExpiryDate,
            gender: gender,
            // issuedCountry: issuedCountry,
            // nationality: nationality,
            documentIssueDate: documentIssueDate,
            id: id, cancelToken: ref.cancelToken(),
          );

      submitResult.when(
        (success) {
          onSuccess(success);
          state = AsyncData(SubmitUpdateDocumentBtnSuccessState());
        },
        (error) {
          if (error.statusCode == 401) {
            tokenExpired();
            ref.read(autorouterProvider).replaceAll([const WelcomeRoute()]);
          } else {
            onError(error.message);
            state =
                AsyncData(SubmitUpdateDocumentBtnErrorState(error.toString()));
          }
        },
      );
    } catch (e) {
      state = AsyncData(SubmitUpdateDocumentBtnErrorState(e.toString()));
    }
  }

  bool isTokenExpired(LoginResponseModel loginResponseModel) {
    return DateTime.now()
        .toUtc()
        .isAfter(DateTime.parse(loginResponseModel.expiryDate));
  }
}
