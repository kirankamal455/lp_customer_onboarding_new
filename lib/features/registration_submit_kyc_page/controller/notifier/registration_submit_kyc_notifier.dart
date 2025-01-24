import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lp_customer_onboarding/bootstrap.dart';
import 'package:lp_customer_onboarding/data/repositories/login/login_repo_pod.dart';
import 'package:lp_customer_onboarding/features/custom_video_screen/controller/custom_video_pod.dart';
import 'package:lp_customer_onboarding/features/registration_submit_kyc_page/controller/sending_progress_pod.dart';
import 'package:lp_customer_onboarding/shared/pods/user_register_pod.dart';
import 'package:lp_customer_onboarding/shared/riverpod_ext/cancel_extensions.dart';

class RegistrationSubmitKycNotifier extends AutoDisposeAsyncNotifier<void> {
  @override
  build() {}

  void submitKyc(
      {required void Function() onSuccess,
      required void Function(String errorMessage) onError,
      required void Function(String warningMessage) warning,
      void Function(int, int)? onSendProgress}) async {
    final video = ref.watch(customVideoPod);
    final kycDetails = ref.watch(userRegisterProvider);
    // talker.good(video!.path);
    talker.debug(kycDetails);
    try {
      final result = await ref.watch(loginRepoPod).submitKyc(
            firstName: kycDetails.fname,
            lastName: kycDetails.lname,
            middleName: kycDetails.mname,
            dateOfBirth: kycDetails.dob,
            postalCode: kycDetails.address.postalCode,
            country: kycDetails.address.country,
            state: kycDetails.address.state,
            city: kycDetails.address.city,
            street: kycDetails.address.street,
            locationLattitude: kycDetails.address.lattittude,
            locationLongitude: kycDetails.address.longitude,
            uploadedKYCIdDocumentType: kycDetails.photoidtype,
            gender: kycDetails.gender,
            documentImage: kycDetails.photoidimagepath,
            faceVideo: video!.path,
            faceVideoFileName: video.name,
            documentImageFileName: "image.jpg",
            cancelToken: ref.cancelToken(),
            onSendProgress: (count, total) {
              final percentage = ((count / total) * 100).ceilToDouble();
              ref
                  .read(sendingProgressPod.notifier)
                  .update((state) => percentage);
            },
            documentExpiryDate: kycDetails.documentExpiryDate,
          );

      result.when(
        (success) {
          if (success) {
            onSuccess();
          } else {
            onError("Unable to register");
          }
        },
        (error) {
          onError(error.message);
        },
      );
    } catch (e) {
      onError(e.toString());
    }
  }
}
