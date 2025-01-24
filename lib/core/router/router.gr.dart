// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i17;
import 'package:flutter/foundation.dart' as _i21;
import 'package:flutter/material.dart' as _i19;
import 'package:lp_customer_onboarding/data/model/document_upload_response_model.dart'
    as _i18;
import 'package:lp_customer_onboarding/data/model/faceliveness_arg.dart'
    as _i20;
import 'package:lp_customer_onboarding/features/customer_revalidation/view/customer_revalidation.dart'
    as _i1;
import 'package:lp_customer_onboarding/features/docs_corner/view/docs_corner_page.dart'
    as _i3;
import 'package:lp_customer_onboarding/features/documents_upload/view/documents_upload_page.dart'
    as _i8;
import 'package:lp_customer_onboarding/features/edit_document/view/edit_document.dart'
    as _i5;
import 'package:lp_customer_onboarding/features/face_liveness_checker/view/face_liveness_checker_page.dart'
    as _i6;
import 'package:lp_customer_onboarding/features/face_liveness_instruction/view/face_liveness_instruction_page.dart'
    as _i7;
import 'package:lp_customer_onboarding/features/otp_verify/view/otp_verify_page.dart'
    as _i9;
import 'package:lp_customer_onboarding/features/registration_address_page/view/registration_address_page.dart'
    as _i10;
import 'package:lp_customer_onboarding/features/registration_doc_select_page/view/doc_select_page.dart'
    as _i2;
import 'package:lp_customer_onboarding/features/registration_ekyc_onboarding/view/ekyc_onboarding_page.dart'
    as _i4;
import 'package:lp_customer_onboarding/features/registration_name_page/view/registration_name_page.dart'
    as _i11;
import 'package:lp_customer_onboarding/features/registration_submit_kyc_page/view/registration_submit_kyc_page.dart'
    as _i12;
import 'package:lp_customer_onboarding/features/registration_success_page/view/registarion_success_page.dart'
    as _i13;
import 'package:lp_customer_onboarding/features/registration_video_onboarding/presentation/registration_video_onboarding_page.dart'
    as _i14;
import 'package:lp_customer_onboarding/features/send_otp/view/send_otp_page.dart'
    as _i15;
import 'package:lp_customer_onboarding/features/welcome/view/welcome_page.dart'
    as _i16;

abstract class $AppRouter extends _i17.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i17.PageFactory> pagesMap = {
    CustomerRevalidationRoute.name: (routeData) {
      return _i17.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i1.CustomerRevalidationPage(),
      );
    },
    DocSelectRoute.name: (routeData) {
      return _i17.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i2.DocSelectPage(),
      );
    },
    DocsCornerRoute.name: (routeData) {
      return _i17.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i3.DocsCornerPage(),
      );
    },
    EKYCOnboardingRoute.name: (routeData) {
      return _i17.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i4.EKYCOnboardingPage(),
      );
    },
    EditDocumentRoute.name: (routeData) {
      final args = routeData.argsAs<EditDocumentRouteArgs>();
      return _i17.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i5.EditDocumentPage(
          documentUploadResponseModel: args.documentUploadResponseModel,
          key: args.key,
        ),
      );
    },
    FaceLivenessCheckerRoute.name: (routeData) {
      final args = routeData.argsAs<FaceLivenessCheckerRouteArgs>();
      return _i17.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i6.FaceLivenessCheckerPage(
          key: args.key,
          faceLivenessArg: args.faceLivenessArg,
        ),
      );
    },
    FaceLivenessInstructionRoute.name: (routeData) {
      final args = routeData.argsAs<FaceLivenessInstructionRouteArgs>();
      return _i17.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i7.FaceLivenessInstructionPage(
          key: args.key,
          faceLivenessArg: args.faceLivenessArg,
        ),
      );
    },
    HomeRoute.name: (routeData) {
      final args = routeData.argsAs<HomeRouteArgs>();
      return _i17.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i8.HomePage(
          args.selctedName,
          key: args.key,
        ),
      );
    },
    OtpVerifyRoute.name: (routeData) {
      final args = routeData.argsAs<OtpVerifyRouteArgs>();
      return _i17.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i9.OtpVerifyPage(
          isCustomerRevalidation: args.isCustomerRevalidation,
          isNormalMode: args.isNormalMode,
          mobileNumber: args.mobileNumber,
          key: args.key,
        ),
      );
    },
    RegistrationAddressRoute.name: (routeData) {
      return _i17.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i10.RegistrationAddressPage(),
      );
    },
    RegistrationNameRoute.name: (routeData) {
      return _i17.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i11.RegistrationNamePage(),
      );
    },
    RegistrationSubmitKycRoute.name: (routeData) {
      return _i17.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i12.RegistrationSubmitKycPage(),
      );
    },
    RegistrationSuccessRoute.name: (routeData) {
      final args = routeData.argsAs<RegistrationSuccessRouteArgs>();
      return _i17.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i13.RegistrationSuccessPage(
          key: args.key,
          isRegistrationPending: args.isRegistrationPending,
        ),
      );
    },
    RegistrationVideoOnboardingRoute.name: (routeData) {
      return _i17.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i14.RegistrationVideoOnboardingPage(),
      );
    },
    SendOtpRoute.name: (routeData) {
      final args = routeData.argsAs<SendOtpRouteArgs>();
      return _i17.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i15.SendOtpPage(
          isNormalMode: args.isNormalMode,
          isCustomerRevalidation: args.isCustomerRevalidation,
          key: args.key,
        ),
      );
    },
    WelcomeRoute.name: (routeData) {
      return _i17.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i16.WelcomePage(),
      );
    },
  };
}

/// generated route for
/// [_i1.CustomerRevalidationPage]
class CustomerRevalidationRoute extends _i17.PageRouteInfo<void> {
  const CustomerRevalidationRoute({List<_i17.PageRouteInfo>? children})
      : super(
          CustomerRevalidationRoute.name,
          initialChildren: children,
        );

  static const String name = 'CustomerRevalidationRoute';

  static const _i17.PageInfo<void> page = _i17.PageInfo<void>(name);
}

/// generated route for
/// [_i2.DocSelectPage]
class DocSelectRoute extends _i17.PageRouteInfo<void> {
  const DocSelectRoute({List<_i17.PageRouteInfo>? children})
      : super(
          DocSelectRoute.name,
          initialChildren: children,
        );

  static const String name = 'DocSelectRoute';

  static const _i17.PageInfo<void> page = _i17.PageInfo<void>(name);
}

/// generated route for
/// [_i3.DocsCornerPage]
class DocsCornerRoute extends _i17.PageRouteInfo<void> {
  const DocsCornerRoute({List<_i17.PageRouteInfo>? children})
      : super(
          DocsCornerRoute.name,
          initialChildren: children,
        );

  static const String name = 'DocsCornerRoute';

  static const _i17.PageInfo<void> page = _i17.PageInfo<void>(name);
}

/// generated route for
/// [_i4.EKYCOnboardingPage]
class EKYCOnboardingRoute extends _i17.PageRouteInfo<void> {
  const EKYCOnboardingRoute({List<_i17.PageRouteInfo>? children})
      : super(
          EKYCOnboardingRoute.name,
          initialChildren: children,
        );

  static const String name = 'EKYCOnboardingRoute';

  static const _i17.PageInfo<void> page = _i17.PageInfo<void>(name);
}

/// generated route for
/// [_i5.EditDocumentPage]
class EditDocumentRoute extends _i17.PageRouteInfo<EditDocumentRouteArgs> {
  EditDocumentRoute({
    required _i18.DocumentUploadResponseModel documentUploadResponseModel,
    _i19.Key? key,
    List<_i17.PageRouteInfo>? children,
  }) : super(
          EditDocumentRoute.name,
          args: EditDocumentRouteArgs(
            documentUploadResponseModel: documentUploadResponseModel,
            key: key,
          ),
          initialChildren: children,
        );

  static const String name = 'EditDocumentRoute';

  static const _i17.PageInfo<EditDocumentRouteArgs> page =
      _i17.PageInfo<EditDocumentRouteArgs>(name);
}

class EditDocumentRouteArgs {
  const EditDocumentRouteArgs({
    required this.documentUploadResponseModel,
    this.key,
  });

  final _i18.DocumentUploadResponseModel documentUploadResponseModel;

  final _i19.Key? key;

  @override
  String toString() {
    return 'EditDocumentRouteArgs{documentUploadResponseModel: $documentUploadResponseModel, key: $key}';
  }
}

/// generated route for
/// [_i6.FaceLivenessCheckerPage]
class FaceLivenessCheckerRoute
    extends _i17.PageRouteInfo<FaceLivenessCheckerRouteArgs> {
  FaceLivenessCheckerRoute({
    _i19.Key? key,
    required _i20.FaceLivenessArg faceLivenessArg,
    List<_i17.PageRouteInfo>? children,
  }) : super(
          FaceLivenessCheckerRoute.name,
          args: FaceLivenessCheckerRouteArgs(
            key: key,
            faceLivenessArg: faceLivenessArg,
          ),
          initialChildren: children,
        );

  static const String name = 'FaceLivenessCheckerRoute';

  static const _i17.PageInfo<FaceLivenessCheckerRouteArgs> page =
      _i17.PageInfo<FaceLivenessCheckerRouteArgs>(name);
}

class FaceLivenessCheckerRouteArgs {
  const FaceLivenessCheckerRouteArgs({
    this.key,
    required this.faceLivenessArg,
  });

  final _i19.Key? key;

  final _i20.FaceLivenessArg faceLivenessArg;

  @override
  String toString() {
    return 'FaceLivenessCheckerRouteArgs{key: $key, faceLivenessArg: $faceLivenessArg}';
  }
}

/// generated route for
/// [_i7.FaceLivenessInstructionPage]
class FaceLivenessInstructionRoute
    extends _i17.PageRouteInfo<FaceLivenessInstructionRouteArgs> {
  FaceLivenessInstructionRoute({
    _i19.Key? key,
    required _i20.FaceLivenessArg faceLivenessArg,
    List<_i17.PageRouteInfo>? children,
  }) : super(
          FaceLivenessInstructionRoute.name,
          args: FaceLivenessInstructionRouteArgs(
            key: key,
            faceLivenessArg: faceLivenessArg,
          ),
          initialChildren: children,
        );

  static const String name = 'FaceLivenessInstructionRoute';

  static const _i17.PageInfo<FaceLivenessInstructionRouteArgs> page =
      _i17.PageInfo<FaceLivenessInstructionRouteArgs>(name);
}

class FaceLivenessInstructionRouteArgs {
  const FaceLivenessInstructionRouteArgs({
    this.key,
    required this.faceLivenessArg,
  });

  final _i19.Key? key;

  final _i20.FaceLivenessArg faceLivenessArg;

  @override
  String toString() {
    return 'FaceLivenessInstructionRouteArgs{key: $key, faceLivenessArg: $faceLivenessArg}';
  }
}

/// generated route for
/// [_i8.HomePage]
class HomeRoute extends _i17.PageRouteInfo<HomeRouteArgs> {
  HomeRoute({
    required String selctedName,
    _i19.Key? key,
    List<_i17.PageRouteInfo>? children,
  }) : super(
          HomeRoute.name,
          args: HomeRouteArgs(
            selctedName: selctedName,
            key: key,
          ),
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static const _i17.PageInfo<HomeRouteArgs> page =
      _i17.PageInfo<HomeRouteArgs>(name);
}

class HomeRouteArgs {
  const HomeRouteArgs({
    required this.selctedName,
    this.key,
  });

  final String selctedName;

  final _i19.Key? key;

  @override
  String toString() {
    return 'HomeRouteArgs{selctedName: $selctedName, key: $key}';
  }
}

/// generated route for
/// [_i9.OtpVerifyPage]
class OtpVerifyRoute extends _i17.PageRouteInfo<OtpVerifyRouteArgs> {
  OtpVerifyRoute({
    required bool isCustomerRevalidation,
    required bool isNormalMode,
    required String mobileNumber,
    _i19.Key? key,
    List<_i17.PageRouteInfo>? children,
  }) : super(
          OtpVerifyRoute.name,
          args: OtpVerifyRouteArgs(
            isCustomerRevalidation: isCustomerRevalidation,
            isNormalMode: isNormalMode,
            mobileNumber: mobileNumber,
            key: key,
          ),
          initialChildren: children,
        );

  static const String name = 'OtpVerifyRoute';

  static const _i17.PageInfo<OtpVerifyRouteArgs> page =
      _i17.PageInfo<OtpVerifyRouteArgs>(name);
}

class OtpVerifyRouteArgs {
  const OtpVerifyRouteArgs({
    required this.isCustomerRevalidation,
    required this.isNormalMode,
    required this.mobileNumber,
    this.key,
  });

  final bool isCustomerRevalidation;

  final bool isNormalMode;

  final String mobileNumber;

  final _i19.Key? key;

  @override
  String toString() {
    return 'OtpVerifyRouteArgs{isCustomerRevalidation: $isCustomerRevalidation, isNormalMode: $isNormalMode, mobileNumber: $mobileNumber, key: $key}';
  }
}

/// generated route for
/// [_i10.RegistrationAddressPage]
class RegistrationAddressRoute extends _i17.PageRouteInfo<void> {
  const RegistrationAddressRoute({List<_i17.PageRouteInfo>? children})
      : super(
          RegistrationAddressRoute.name,
          initialChildren: children,
        );

  static const String name = 'RegistrationAddressRoute';

  static const _i17.PageInfo<void> page = _i17.PageInfo<void>(name);
}

/// generated route for
/// [_i11.RegistrationNamePage]
class RegistrationNameRoute extends _i17.PageRouteInfo<void> {
  const RegistrationNameRoute({List<_i17.PageRouteInfo>? children})
      : super(
          RegistrationNameRoute.name,
          initialChildren: children,
        );

  static const String name = 'RegistrationNameRoute';

  static const _i17.PageInfo<void> page = _i17.PageInfo<void>(name);
}

/// generated route for
/// [_i12.RegistrationSubmitKycPage]
class RegistrationSubmitKycRoute extends _i17.PageRouteInfo<void> {
  const RegistrationSubmitKycRoute({List<_i17.PageRouteInfo>? children})
      : super(
          RegistrationSubmitKycRoute.name,
          initialChildren: children,
        );

  static const String name = 'RegistrationSubmitKycRoute';

  static const _i17.PageInfo<void> page = _i17.PageInfo<void>(name);
}

/// generated route for
/// [_i13.RegistrationSuccessPage]
class RegistrationSuccessRoute
    extends _i17.PageRouteInfo<RegistrationSuccessRouteArgs> {
  RegistrationSuccessRoute({
    _i19.Key? key,
    required bool isRegistrationPending,
    List<_i17.PageRouteInfo>? children,
  }) : super(
          RegistrationSuccessRoute.name,
          args: RegistrationSuccessRouteArgs(
            key: key,
            isRegistrationPending: isRegistrationPending,
          ),
          initialChildren: children,
        );

  static const String name = 'RegistrationSuccessRoute';

  static const _i17.PageInfo<RegistrationSuccessRouteArgs> page =
      _i17.PageInfo<RegistrationSuccessRouteArgs>(name);
}

class RegistrationSuccessRouteArgs {
  const RegistrationSuccessRouteArgs({
    this.key,
    required this.isRegistrationPending,
  });

  final _i19.Key? key;

  final bool isRegistrationPending;

  @override
  String toString() {
    return 'RegistrationSuccessRouteArgs{key: $key, isRegistrationPending: $isRegistrationPending}';
  }
}

/// generated route for
/// [_i14.RegistrationVideoOnboardingPage]
class RegistrationVideoOnboardingRoute extends _i17.PageRouteInfo<void> {
  const RegistrationVideoOnboardingRoute({List<_i17.PageRouteInfo>? children})
      : super(
          RegistrationVideoOnboardingRoute.name,
          initialChildren: children,
        );

  static const String name = 'RegistrationVideoOnboardingRoute';

  static const _i17.PageInfo<void> page = _i17.PageInfo<void>(name);
}

/// generated route for
/// [_i15.SendOtpPage]
class SendOtpRoute extends _i17.PageRouteInfo<SendOtpRouteArgs> {
  SendOtpRoute({
    required bool isNormalMode,
    required bool isCustomerRevalidation,
    _i21.Key? key,
    List<_i17.PageRouteInfo>? children,
  }) : super(
          SendOtpRoute.name,
          args: SendOtpRouteArgs(
            isNormalMode: isNormalMode,
            isCustomerRevalidation: isCustomerRevalidation,
            key: key,
          ),
          initialChildren: children,
        );

  static const String name = 'SendOtpRoute';

  static const _i17.PageInfo<SendOtpRouteArgs> page =
      _i17.PageInfo<SendOtpRouteArgs>(name);
}

class SendOtpRouteArgs {
  const SendOtpRouteArgs({
    required this.isNormalMode,
    required this.isCustomerRevalidation,
    this.key,
  });

  final bool isNormalMode;

  final bool isCustomerRevalidation;

  final _i21.Key? key;

  @override
  String toString() {
    return 'SendOtpRouteArgs{isNormalMode: $isNormalMode, isCustomerRevalidation: $isCustomerRevalidation, key: $key}';
  }
}

/// generated route for
/// [_i16.WelcomePage]
class WelcomeRoute extends _i17.PageRouteInfo<void> {
  const WelcomeRoute({List<_i17.PageRouteInfo>? children})
      : super(
          WelcomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'WelcomeRoute';

  static const _i17.PageInfo<void> page = _i17.PageInfo<void>(name);
}
