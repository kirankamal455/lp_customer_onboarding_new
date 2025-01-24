import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lp_customer_onboarding/bootstrap.dart';
import 'package:lp_customer_onboarding/core/router/router.gr.dart';
import 'package:lp_customer_onboarding/core/router/router_pod.dart';
import 'package:lp_customer_onboarding/data/model/document_upload_response_model.dart';
import 'package:lp_customer_onboarding/data/model/login_response_model.dart';
import 'package:lp_customer_onboarding/data/repositories/login/login_repo_pod.dart';
import 'package:lp_customer_onboarding/features/submit_btn/state/submit_fos_btn_state.dart';
import 'package:lp_customer_onboarding/shared/riverpod_ext/cancel_extensions.dart';

class SubmitFosBtnNotifier extends AutoDisposeAsyncNotifier<SubmitFOSBtnState> {
  @override
  FutureOr<SubmitFOSBtnState> build() {
    return InitialSubmitFOSBtnState();
  }

  Future<void> submitDocument({
    // required String customerName,
    // required String personName,
    // required String emailID,
    // required String address,
    // required String mobileNumber,
    required String documentType,
    // required String status,
    // required String nextFollowupDate,
    // required String remark,
    required XFile filePath  ,
    required Function(String) onError,
    required Function(String) onLocationPermissionError,
    required Function(String) onLocationServiceError,
    required Function(DocumentUploadResponseModel) onSuccess,
    required Function() tokenExpired,
  }) async {
    try {
      state = AsyncData(SubmitFOSBtnLoadingState(percentage: 0));
      final submitResult = await ref.watch(loginRepoPod).documentUpload(
            // customerName: customerName,
            // personName: personName,
            // emailID: emailID,
            // address: address,
            // mobileNumber: mobileNumber,
            documentType: documentType,
            // status: status,
            // nextFollowupDate: ref.read(followUpPod) ? nextFollowupDate : null,
            // remark: remark,
            // giolocation: "${positon.latitude},${positon.longitude}",
            filePath : filePath ,

            currentProgress: (int progress) {
              state = AsyncData(SubmitFOSBtnLoadingState(percentage: progress));
              talker.verbose(progress);
            },
            cancelToken: ref.cancelToken(),
          );

      submitResult.when(
        (success) {
          onSuccess(success);
          state = AsyncData(SubmitFOSBtnSuccessState());
        },
        (error) {
          if (error.statusCode == 401) {
            tokenExpired();
            ref.read(autorouterProvider).replaceAll([const WelcomeRoute()]);
          } else {
            onError(error.message);
            state = AsyncData(SubmitFOSBtnErrorState(error.toString()));
          }
        },
      );
    } catch (e) {
      talker.error("Submit Document Error ${e.toString()}");
      state = AsyncData(SubmitFOSBtnErrorState(e.toString()));
    }
  }

  bool isTokenExpired(LoginResponseModel loginResponseModel) {
    return DateTime.now()
        .toUtc()
        .isAfter(DateTime.parse(loginResponseModel.expiryDate));
  }
}
