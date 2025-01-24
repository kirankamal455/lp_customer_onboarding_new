import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lp_customer_onboarding/data/service/theme/i_theme_service.dart';
import 'package:lp_customer_onboarding/data/service/theme/theme_service.dart';

final themeServicePod = Provider.autoDispose<IThemeService>(
  (ref) => ThemeService(),
  name: 'themeServicePod',
);
