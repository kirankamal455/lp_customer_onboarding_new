import 'package:auto_route/auto_route.dart';
import 'package:lp_customer_onboarding/data/service/db/i_db_service.dart';

class SplashGuard extends AutoRouteGuard {
  final IDbService iUserDbService;

  SplashGuard({
    required this.iUserDbService,
  });

  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) async {
    final isUserAvailable = await iUserDbService.isUserAvailable();
    _handleUserAvailability(isUserAvailable.tryGetSuccess(), resolver, router);
  }

  void _handleUserAvailability(
      bool? isUserAvailable, NavigationResolver resolver, StackRouter router) {
    if (isUserAvailable == true) {
      //router.replaceAll([const HomeRoute()]);
    } else {
      resolver.next(true);
    }
  }
}
