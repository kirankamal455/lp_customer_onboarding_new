import 'package:flash/flash_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lp_customer_onboarding/shared/widget/no_internet_widget.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:lp_customer_onboarding/core/router/auto_route_observer.dart';
import 'package:lp_customer_onboarding/core/router/router_pod.dart';
import 'package:lp_customer_onboarding/core/theme/app_theme.dart';
import 'package:lp_customer_onboarding/core/theme/theme_controller.dart';
import 'package:lp_customer_onboarding/shared/helper/global_helper.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class App extends ConsumerStatefulWidget {
  const App({super.key});

  @override
  ConsumerState<App> createState() => _AppState();
}

class _AppState extends ConsumerState<App> with GlobalHelper {
  @override
  Widget build(BuildContext context) {
    final approuter = ref.watch(autorouterProvider);
    final currentTheme = ref.watch(themecontrollerProvider);
    // ref.invalidate(customeOnboardingModePod);
    //final locale = ref.watch(localePod);

    return MaterialApp.router(
      useInheritedMediaQuery: true,
      debugShowCheckedModeBanner: false,
      title: 'Lp Customer Onboarding',
      theme: Themes.theme,
      //darkTheme: Themes.darkTheme,
      //themeMode: currentTheme,
      themeMode: ThemeMode.light,
      routerConfig: approuter.config(
        navigatorObservers: () => [
          RouterObserver(),
        ],
      ),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      // locale: DevicePreview.locale(context),
      builder: (context, child) {
        if (mounted) {
          child = ResponsiveBreakpoints.builder(
            child: BouncingScrollWrapper.builder(context, child!),
            breakpoints: [
              const Breakpoint(start: 0, end: 450, name: MOBILE),
              const Breakpoint(start: 451, end: 800, name: TABLET),
              const Breakpoint(start: 801, end: 1920, name: DESKTOP),
              const Breakpoint(start: 1921, end: double.infinity, name: '4K'),
            ],
          );
          child = AnnotatedRegion<SystemUiOverlayStyle>(
            value: SystemUiOverlayStyle.dark.copyWith(
              // statusBarColor: Colors.transparent,
              systemNavigationBarColor: Colors.white,
              systemNavigationBarDividerColor: Colors.white,
              systemNavigationBarIconBrightness: Brightness.light,
            ),
            child: GestureDetector(
              child: child,
              onTap: () {
                hideKeyboard();
              },
            ),
          );
        } else {
          child = const SizedBox.shrink();
        }
        return child.noInternetWidget();
      },
    );
  }
}
