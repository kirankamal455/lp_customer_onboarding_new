import 'package:dio/dio.dart';
import 'package:lp_customer_onboarding/shared/api_client/dio/default_api_error_handler.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

class DefaultAPIInterceptor extends Interceptor {
  DefaultAPIInterceptor({
    required this.dio,
  });
  final Dio dio;

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    defaultAPIErrorHandler(err, handler, dio);
    await Sentry.captureException(
      "API : ${err.requestOptions.path}  Dio Api Error : $err",
      stackTrace: StackTrace.current,
    );
  }
}
