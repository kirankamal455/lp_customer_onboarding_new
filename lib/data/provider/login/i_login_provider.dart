// coverage:ignore-file
import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';

abstract class ILoginProvider {
  Future<Response> addUserPhoneNumber(
      {required String phoneNumber, CancelToken? cancelToken});
  Future<Response> verifyUserPhoneNumber(
      {required String verificationCode,
      required String userId,
      CancelToken? cancelToken});
  Future<Response> getToken({CancelToken? cancelToken});
  Future<Response> addUserEmail(
      {required String email, CancelToken? cancelToken});
  Future<Response> sendLoginOtp(
      {required String phoneNumber, CancelToken? cancelToken});

  Future<Response> submitDocument({
    required String documentType,
    required XFile filePath,
    required void Function(int progress) currentProgress,
    CancelToken? cancelToken,
  });

  Future<Response> submitKyc({
    required String firstName,
    String? middleName,
    required String lastName,
    required String dateOfBirth,
    required String postalCode,
    required String country,
    required String state,
    required String city,
    required String street,
    required String locationLattitude,
    required String locationLongitude,
    required String uploadedKYCIdDocumentType,
    required String gender,
    required String documentImage,
    required String faceVideo,
    required String faceVideoFileName,
    required String documentImageFileName,
    required String documentExpiryDate,
    void Function(int, int)? onSendProgress,
    CancelToken? cancelToken,
  });

  Future<Response> faceMatchCheck(
      {required String sourceImagePath,
      required String userId,
      CancelToken? cancelToken,
      void Function(int, int)? onSendProgress});

  Future<Response> updateDocument({
    required String name,
    required String idDocumentNumber,
    required String dateOfBirth,
    required String documentExpiryDate,
    required String gender,
    required String documentIssueDate,
    required String id,
    CancelToken? cancelToken,
  });

  Future<Response> documentExpirationCheck({CancelToken? cancelToken});
  Future<Response> getCustomerOnboardingMode({CancelToken? cancelToken});
  Future<Response> uploadFacelivenessVideo(
      {
      // required final String randomText,
      // required final bool isEnableRandomText,
      required final String videoPath,
      required final String instructionsList,
      required final String processId,
      CancelToken? cancelToken,
      void Function(int, int)? onSendProgress});

  Future<Response> getLivenessInstructions({CancelToken? cancelToken});
}
