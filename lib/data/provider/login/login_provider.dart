// coverage:ignore-file

import 'dart:convert';
import 'dart:developer';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lp_customer_onboarding/bootstrap.dart';
import 'package:lp_customer_onboarding/const/app_urls.dart';
import 'package:lp_customer_onboarding/data/provider/login/i_login_provider.dart';
import 'package:lp_customer_onboarding/data/service/db/i_db_service.dart';

class LoginProvider implements ILoginProvider {
  LoginProvider({required this.dbService, required this.dio});
  final IDbService dbService;
  final Dio dio;

  @override
  Future<Response> addUserPhoneNumber(
      {required String phoneNumber, CancelToken? cancelToken}) async {
    return await dio.post(
      AppURLs.addUserPhoneNumber,
      data: {"phoneNumber": phoneNumber},
      cancelToken: cancelToken,
    );
  }

  @override
  Future<Response> verifyUserPhoneNumber(
      {required String verificationCode,
      required String userId,
      CancelToken? cancelToken}) async {
    final result = await dbService.getsaveUniqueUserId();
    final userId1 = result.tryGetSuccess();
    return await dio.post(
      AppURLs.verifyUserPhoneNumber,
      data: {"UserId": userId1, "VerificationCode": verificationCode},
      cancelToken: cancelToken,
    );
  }

  @override
  Future<Response> getToken({CancelToken? cancelToken}) async {
    final result = await dbService.getUser();
    final username = result.tryGetSuccess()?.uniqueUserId;
    return await dio.get(
      "${AppURLs.getToken}?PhoneNumber=$username",
      cancelToken: cancelToken,
    );
  }

  @override
  Future<Response> addUserEmail(
      {required String email, CancelToken? cancelToken}) async {
    final result = await dbService.getToken();
    final token = result.tryGetSuccess();
    return await dio.post(
      AppURLs.addUserEmail,
      data: {"Email": email},
      options: Options(
        headers: {"Authorization": "Bearer $token"},
      ),
      cancelToken: cancelToken,
    );
  }

  @override
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
  }) async {
    final result = await dbService.getToken();
    final token = result.tryGetSuccess();

    var data = FormData.fromMap({
      "KycIdDocumentPage": await MultipartFile.fromFile(
        documentImage,
      ),
      "FaceVideoRecord": await MultipartFile.fromFile(
        faceVideo,
      ),
      'DocExpiryDate': documentExpiryDate,
      'FirstName': firstName,
      'MiddleName': middleName ?? '',
      'LastName': lastName,
      'DateOfBirth': dateOfBirth,
      'PostalCode': postalCode,
      'Country': country,
      'State': state,
      'City': city,
      'Street': street,
      'LocationLattitude': locationLattitude,
      'LocationLongitude': locationLongitude,
      'UploadedKYCIdDocumentType': uploadedKYCIdDocumentType,
      'Gender': gender,
    });
    return await dio.post(
      AppURLs.addKycInfo,
      data: data,
      options: Options(
        headers: {"Authorization": "Bearer $token"},
      ),
      onSendProgress: onSendProgress,
      cancelToken: cancelToken,
    );
  }

  @override
  Future<Response> sendLoginOtp(
      {required String phoneNumber, CancelToken? cancelToken}) async {
    return await dio.post(
      AppURLs.sendLoginOtp,
      data: {"phoneNumber": phoneNumber},
      cancelToken: cancelToken,
    );
  }

  @override
  Future<Response> submitDocument({
    required String documentType,
    required XFile filePath,
    required void Function(int progress) currentProgress,
    CancelToken? cancelToken,
  }) async {
    final result = await dbService.getToken();
    final token = result.tryGetSuccess();
    MultipartFile? multipartFile;
    // List<MultipartFile> files = [];
    // for (String path in filePaths) {
    //   final file = await MultipartFile.fromFile(path, filename: "image.jpg");
    //   files.add(file);
    // }

    // var path= await MultipartFile.fromFile(filePath.path, filename: "image.jpg");
    if (kIsWeb) {
      var bytes = await filePath.readAsBytes();
      multipartFile = MultipartFile.fromBytes(bytes, filename: "image.jpg");
    } else {
      multipartFile =
          await MultipartFile.fromFile(filePath.path, filename: "image.jpg");
    }

    var data = FormData.fromMap({
      'IdDocumentFileFrontPage': multipartFile,
      'DocumentType': documentType,
    });

    return await dio.post(
      AppURLs.processDocument,
      data: data,
      onSendProgress: (sent, total) {
        currentProgress(((sent / total) * 100).toInt());
      },
      cancelToken: cancelToken,
      options: Options(
        method: 'POST',
        headers: {
          'Content-Type': 'multipart/form-data',
          'Accept': 'text/plain',
          'Authorization': 'Bearer $token',
        },
      ),
    );
  }

  @override
  Future<Response> faceMatchCheck(
      {required String sourceImagePath,
      required String userId,
      CancelToken? cancelToken,
      void Function(int, int)? onSendProgress}) async {
    final result = await dbService.getToken();
    final token = result.tryGetSuccess();
    var headers = {
      'Content-Type': 'multipart/form-data',
      'Accept': 'text/plain',
      'Authorization': 'Bearer $token',
    };
    var data = FormData.fromMap({
      'PhotoDocumentFile': [
        await MultipartFile.fromFile(sourceImagePath, filename: 'face.jpg')
      ],
      'Id': userId
    });

    return await dio.post(
      AppURLs.faceVerify,
      options: Options(
        headers: headers,
      ),
      data: data,
      cancelToken: cancelToken,
    );
  }

  @override
  Future<Response> updateDocument({
    required String name,
    required String idDocumentNumber,
    required String dateOfBirth,
    required String documentExpiryDate,
    required String gender,
    required String documentIssueDate,
    required String id,
    CancelToken? cancelToken,
  }) async {
    final result = await dbService.getToken();
    final token = result.tryGetSuccess();
    final formData = FormData.fromMap({
      'Name': name,
      'IdDocumentNumber': idDocumentNumber,
      'DateOfBirth': dateOfBirth,
      'DocumentExpiryDate': documentExpiryDate,
      'Gender': gender,
      'DocumentIssueDate': documentIssueDate,
      'Id': id,
    });

    return await dio.post(
      AppURLs.updateDocument,
      data: formData,
      options: Options(
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'multipart/form-data',
        },
      ),
      cancelToken: cancelToken,
    );
  }

  @override
  Future<Response> documentExpirationCheck({CancelToken? cancelToken}) async {
    final result = await dbService.getToken();
    final token = result.tryGetSuccess();
    return await dio.get(
      AppURLs.getDocExpiry,
      options: Options(
        headers: {
          'Authorization': 'Bearer $token',
        },
      ),
      cancelToken: cancelToken,
    );
  }

  @override
  Future<Response> getCustomerOnboardingMode({CancelToken? cancelToken}) async {
    return await dio.get(
      AppURLs.getCustomerOnboardingMode,
      cancelToken: cancelToken,
    );
  }

  @override
  Future<Response> uploadFacelivenessVideo(
      {
      //   required final String randomText,
      // required final bool isEnableRandomText,
      required final String videoPath,
      CancelToken? cancelToken,
      required final String documentImageUrl,
      required final String instructionsList,
      required final String processId,
      void Function(int, int)? onSendProgress}) async {
    var headers = {
      'Content-Type': 'multipart/form-data',
      'Accept': 'application/json',
    };

    var data = FormData.fromMap({
      'file': [await MultipartFile.fromFile(videoPath)],
      'InstructionsList': instructionsList
    });
    print("Instruction is $instructionsList");
    return await dio.post(
      '${AppURLs.facelivenesApiBaseUrl}FaceLiveDetection/VideoUpload?ProcessId=$processId&ImageUrl=$documentImageUrl',
      options: Options(headers: headers),
      data: data,
      onSendProgress: onSendProgress,
      cancelToken: cancelToken,
    );
  }

  @override
  Future<Response> getLivenessInstructions({CancelToken? cancelToken}) async {
    return await dio.get(
      AppURLs.getLivenssIntructions,
      cancelToken: cancelToken,
    );
  }
}
