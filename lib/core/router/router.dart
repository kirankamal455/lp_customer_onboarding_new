import 'package:auto_route/auto_route.dart';
import 'package:lp_customer_onboarding/core/router/router.gr.dart';
import 'package:lp_customer_onboarding/data/service/db/i_db_service.dart';

@AutoRouterConfig()
class AppRouter extends $AppRouter {
  final IDbService iUserDbService;
  AppRouter({super.navigatorKey, required this.iUserDbService});
  @override
  late final List<AutoRoute> routes = [
    // AutoRoute(
    //     page: LoginRoute.page,
    //     path: '/',
    //     initial: true,
    //     guards: [SplashGuard(iUserDbService: iUserDbService)]),
    AutoRoute(
      page: DocumentUploadRoute.page,
      // path: '/home',
      path: '/DocumentUploadRoute',
      maintainState: false,
      initial: true,
      // guards: [SplashGuard(iUserDbService: iUserDbService)]
    ),
    AutoRoute(
      page: RegistrationSuccessRoute.page,
      // path: '/home',
      path: '/RegistrationSuccessRoute',

      // guards: [SplashGuard(iUserDbService: iUserDbService)]
    ),
    // AutoRoute(
    //   page: FaceLivenessRoute.page,
    //   path: '/FaceLivenessRoute',
    // ),

    AutoRoute(
      page: EditDocumentRoute.page,
      path: '/EditDocumentRoute',
      maintainState: false,
    ),
    AutoRoute(
      page: WelcomeRoute.page,
      path: '/WelcomeRoute',
      maintainState: false,
    ),
    AutoRoute(
      page: SendOtpRoute.page,
      path: '/SendOtpRoute',
      maintainState: false,
    ),
    AutoRoute(
      page: OtpVerifyRoute.page,
      path: '/OtpVerifyRoute',
      maintainState: false,
    ),
    AutoRoute(
      page: CustomerRevalidationRoute.page,
      path: '/CustomerRevalidationRoute',
    ),
    AutoRoute(
      page: RegistrationNameRoute.page,
      path: '/RegistrationNameRoute',
    ),
    AutoRoute(
      page: RegistrationSubmitKycRoute.page,
      path: '/RegistrationSubmitKycRoute',
    ),
    AutoRoute(
      page: DocSelectRoute.page,
      path: '/DocSelectRoute',
    ),
    AutoRoute(
      page: RegistrationAddressRoute.page,
      path: '/RegistrationAddressRoute',
    ),
    AutoRoute(
      page: EKYCOnboardingRoute.page,
      path: '/EKYCOnboardingRoute',
    ),
    AutoRoute(
      page: DocsCornerRoute.page,
      path: '/DocsCornerRoute',
    ),
    AutoRoute(
      page: RegistrationVideoOnboardingRoute.page,
      path: '/RegistrationVideoOnboardingRoute',
    ),
    AutoRoute(
        page: FaceLivenessCheckerRoute.page,
        path: '/FaceLivenessNewRoute',
        maintainState: false),
    AutoRoute(
      page: FaceLivenessInstructionRoute.page,
      path: '/FaceLivenessInstructionRoute',
      maintainState: false,
    ),
  ];
}
