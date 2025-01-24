import 'package:dio/src/cancel_token.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lp_customer_onboarding/bootstrap.dart';
import 'package:lp_customer_onboarding/const/liveness_data.dart';
import 'package:lp_customer_onboarding/data/model/add_email_response.dart';
import 'package:lp_customer_onboarding/data/model/document_expiry_check_response_model.dart';
import 'package:lp_customer_onboarding/data/model/document_upload_response_model.dart';
import 'package:lp_customer_onboarding/data/model/live_face_response_model.dart';
import 'package:lp_customer_onboarding/data/model/liveness_instruction_model.dart';
import 'package:lp_customer_onboarding/data/model/livenss_instruction_response_model.dart';
import 'package:lp_customer_onboarding/data/model/send_otp_resposne_model.dart';
import 'package:lp_customer_onboarding/data/model/verify_otp_model.dart';
import 'package:lp_customer_onboarding/data/provider/login/i_login_provider.dart';
import 'package:lp_customer_onboarding/data/repositories/login/i_login_repository.dart';
import 'package:lp_customer_onboarding/data/service/db/i_db_service.dart';
import 'package:lp_customer_onboarding/shared/exception/base_exception.dart';
import 'package:lp_customer_onboarding/shared/helper/response_format_checker.dart';
import 'package:multiple_result/multiple_result.dart';

class LoginRepository implements ILoginRepository {
  LoginRepository({required this.dbService, required this.loginProvider});

  final ILoginProvider loginProvider;
  final IDbService dbService;

  @override
  Future<Result<DocumentUploadResponseModel, APIException>> documentUpload({
    required String documentType,
    required XFile filePath,
    required void Function(int progress) currentProgress,
    CancelToken? cancelToken,
  }) async {
    final response = await loginProvider.submitDocument(
      documentType: documentType,
      filePath: filePath,
      currentProgress: currentProgress,
      cancelToken: cancelToken,
    );

    if (response.isFormatValid(key: 'data')) {
      return Success(DocumentUploadResponseModel.fromMap(response.data));
    } else {
      return Error(response.getErrorMessage());
    }
  }

  @override
  Future<Result<SendOTPResponseModel, BaseException>> addUserPhoneNumber(
      {required String phoneNumber, CancelToken? cancelToken}) async {
    final result = await loginProvider.addUserPhoneNumber(
      phoneNumber: phoneNumber,
      cancelToken: cancelToken,
    );

    if (result.statusCode == 200) {
      return Success(SendOTPResponseModel.fromMap(result.data));
    } else if (result.statusCode == 400) {
      talker.error("addUserPhoneNumber 400 Provider Error ; ${result.data}");
      if (result.data["message"] == "Already Exists") {
        return Error(BaseException(
            message:
                "This mobile number is already in use. Please log in or use a different number."));
      } else {
        return Error(result.getErrorMessage());
      }
    } else {
      talker.error("addUserPhoneNumber Provider Error ; ${result.data}");
      return Error(result.getErrorMessage());
    }
  }

  @override
  Future<Result<VerifyOtpModel, BaseException>> verifyMobileOtp(
      {required String verificationCode,
      required String userId,
      CancelToken? cancelToken}) async {
    final result = await loginProvider.verifyUserPhoneNumber(
      verificationCode: verificationCode,
      userId: userId,
      cancelToken: cancelToken,
    );

    if (result.statusCode == 200) {
      return Success(VerifyOtpModel.fromMap(result.data));
    } else if (result.statusCode == 400) {
      return Error(BaseException(message: "Incorrect OTP Entered"));
    } else {
      return Error(BaseException(message: "Error"));
    }
  }

  @override
  Future<Result<String, APIException>> getToken(
      {CancelToken? cancelToken}) async {
    final response = await loginProvider.getToken(cancelToken: cancelToken);

    if (response.statusCode == 200) {
      await dbService.saveToken(token: response.data["accessToken"]);
      return Success(response.data["accessToken"]);
    } else {
      return Error(response.getErrorMessage());
    }
  }

  @override
  Future<Result<AddEmailResponseModel, BaseException>> addEmail(
      {required String email, CancelToken? cancelToken}) async {
    final result = await loginProvider.addUserEmail(
        email: email, cancelToken: cancelToken);
    if (result.statusCode == 200) {
      return Success(AddEmailResponseModel.fromMap(result.data));
    } else {
      return Error(BaseException(message: "error"));
    }
  }

  @override
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
  }) async {
    // try {
    final result = await loginProvider.submitKyc(
      firstName: firstName,
      lastName: lastName,
      dateOfBirth: dateOfBirth,
      postalCode: postalCode,
      country: country,
      state: state,
      city: city,
      street: street,
      locationLattitude: locationLattitude,
      locationLongitude: locationLongitude,
      uploadedKYCIdDocumentType: uploadedKYCIdDocumentType,
      gender: gender,
      documentImage: documentImage,
      faceVideo: faceVideo,
      faceVideoFileName: faceVideoFileName,
      documentImageFileName: documentImageFileName,
      onSendProgress: onSendProgress,
      middleName: middleName,
      documentExpiryDate: documentExpiryDate,
      cancelToken: cancelToken,
    );

    if (result.statusCode == 200) {
      return Success(result.data["isSuccess"]);
    } else {
      return Error(result.getErrorMessage());
    }
    // } catch (e) {
    //   return Error(
    //       APIException(statusMessage: "500", errorMessage: e.toString()));
    // }
  }

  @override
  Future<Result<SendOTPResponseModel, BaseException>> sendLoginOtp(
      {required String phoneNumber, CancelToken? cancelToken}) async {
    final response = await loginProvider.sendLoginOtp(
        phoneNumber: phoneNumber, cancelToken: cancelToken);

    if (response.statusCode == 200) {
      return Success(SendOTPResponseModel.fromMap(response.data));
    } else if (response.statusCode == 400) {
      if (response.data["message"] == "Invalid") {
        return Error(BaseException(message: "User not registered."));
      } else {
        return Error(response.getErrorMessage());
      }
    } else {
      return Error(response.getErrorMessage());
    }
  }

  @override
  Future<Result<bool, APIException>> faceMatchCheck(
      {required String sourceImagePath,
      required String userId,
      CancelToken? cancelToken,
      void Function(int, int)? onSendProgress}) async {
    final response = await loginProvider.faceMatchCheck(
      sourceImagePath: sourceImagePath,
      userId: userId,
      cancelToken: cancelToken,
    );

    if (response.statusCode == 200) {
      return Success(response.data["isFaceMatched"]);
    } else if (response.statusCode == 400) {
      return const Success(false);
    } else {
      return Error(response.getErrorMessage());
    }
  }

  @override
  Future<Result<bool, APIException>> updateDocument({
    required String name,
    required String idDocumentNumber,
    required String dateOfBirth,
    required String documentExpiryDate,
    required String gender,
    required String documentIssueDate,
    required String id,
    CancelToken? cancelToken,
  }) async {
    final response = await loginProvider.updateDocument(
      name: name,
      idDocumentNumber: idDocumentNumber,
      dateOfBirth: dateOfBirth,
      documentExpiryDate: documentExpiryDate,
      gender: gender,
      documentIssueDate: documentIssueDate,
      id: id,
      cancelToken: cancelToken,
    );

    if (response.statusCode == 200) {
      return const Success(true);
    } else {
      return Error(response.getErrorMessage());
    }
  }

  @override
  Future<Result<DocumentExpiryCheckReponseModel, APIException>>
      documentExpirationCheck({CancelToken? cancelToken}) async {
    final response =
        await loginProvider.documentExpirationCheck(cancelToken: cancelToken);

    if (response.statusCode == 200) {
      return Success(DocumentExpiryCheckReponseModel.fromMap(response.data));
    } else {
      return Error(response.getErrorMessage());
    }
  }

  @override
  Future<Result<bool, BaseException>> getCustomerOnboardingMode(
      {CancelToken? cancelToken}) async {
    final response =
        await loginProvider.getCustomerOnboardingMode(cancelToken: cancelToken);

    if (response.statusCode == 200) {
      return Success(response.data["documentIntelligenceEnabled"]);
    } else {
      return Error(response.getErrorMessage());
    }
  }

  @override
  Future<Result<LivenssIntructionsResponseModel, APIException>>
      getLivenessInstructions({CancelToken? cancelToken}) async {
    final response =
        await loginProvider.getLivenessInstructions(cancelToken: cancelToken);

    if (response.statusCode == 200) {
      return Success(LivenssIntructionsResponseModel.fromMap(response.data));
    } else {
      return Error(response.getErrorMessage());
    }
  }

  @override
  Future<Result<LiveFaceResponseModel, APIException>> uploadFacelivenessVideo(
      {required String instructionsList,
      required String processId,
      required String videoPath,
      CancelToken? cancelToken,
      required   String documentImageUrl,
      void Function(int p1, int p2)? onSendProgress}) async {
    final response = await loginProvider.uploadFacelivenessVideo(
        // randomText: randomText,
        // isEnableRandomText: isEnableRandomText,
        videoPath: videoPath,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        instructionsList: instructionsList,
        processId: processId, documentImageUrl: '');

    if (response.statusCode == 200) {
      if (kDebugMode) {
        print("data is ${response.data}");
      }
      return Success(LiveFaceResponseModel.fromMap(response.data));
    } else {
      return Error(response.getErrorMessage());
    }
  }
}
