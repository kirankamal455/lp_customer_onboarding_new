import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lp_customer_onboarding/data/model/add_email_response.dart';
import 'package:lp_customer_onboarding/data/model/document_expiry_check_response_model.dart';
import 'package:lp_customer_onboarding/data/model/document_upload_response_model.dart';
import 'package:lp_customer_onboarding/data/model/live_face_response_model.dart';
import 'package:lp_customer_onboarding/data/model/liveness_instruction_model.dart';
import 'package:lp_customer_onboarding/data/model/livenss_instruction_response_model.dart';
import 'package:lp_customer_onboarding/data/model/send_otp_resposne_model.dart';
import 'package:lp_customer_onboarding/data/model/verify_otp_model.dart';
import 'package:lp_customer_onboarding/shared/exception/base_exception.dart';
import 'package:multiple_result/multiple_result.dart';

abstract class ILoginRepository {
  Future<Result<DocumentUploadResponseModel, APIException>> documentUpload({
    required String documentType,
    required XFile filePath,
    required void Function(int progress) currentProgress,
    CancelToken? cancelToken,
  });

  Future<Result<SendOTPResponseModel, BaseException>> addUserPhoneNumber({
    required String phoneNumber,
    CancelToken? cancelToken,
  });

  Future<Result<VerifyOtpModel, BaseException>> verifyMobileOtp({
    required String verificationCode,
    required String userId,
    CancelToken? cancelToken,
  });

  Future<Result<String, APIException>> getToken({CancelToken? cancelToken});

  Future<Result<AddEmailResponseModel, BaseException>> addEmail({
    required String email,
    CancelToken? cancelToken,
  });

  Future<Result<SendOTPResponseModel, BaseException>> sendLoginOtp({
    required String phoneNumber,
    CancelToken? cancelToken,
  });

  Future<Result<bool, APIException>> submitKyc({
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

  Future<Result<bool, APIException>> faceMatchCheck(
      {required String sourceImagePath,
      required String userId,
      CancelToken? cancelToken,
      void Function(int, int)? onSendProgress});

  Future<Result<bool, APIException>> updateDocument({
    required String name,
    required String idDocumentNumber,
    required String dateOfBirth,
    required String documentExpiryDate,
    required String gender,
    required String documentIssueDate,
    required String id,
    CancelToken? cancelToken,
  });

  Future<Result<DocumentExpiryCheckReponseModel, APIException>>
      documentExpirationCheck({
    CancelToken? cancelToken,
  });

  Future<Result<bool, BaseException>> getCustomerOnboardingMode({
    CancelToken? cancelToken,
  });

  Future<Result<LiveFaceResponseModel, APIException>> uploadFacelivenessVideo(
      {
      // required String randomText,
      // required bool isEnableRandomText,
      required final String documentImageUrl,
      required final String instructionsList,
      required final String processId,
      required String videoPath,
      CancelToken? cancelToken,
      void Function(int, int)? onSendProgress});

  Future<Result<LivenssIntructionsResponseModel, APIException>>
      getLivenessInstructions({
    CancelToken? cancelToken,
  });
}
