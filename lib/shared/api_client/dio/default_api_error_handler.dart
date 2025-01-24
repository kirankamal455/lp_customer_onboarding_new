import 'package:dio/dio.dart';

Future<void> defaultAPIErrorHandler(
  DioException err,
  ErrorInterceptorHandler handler,
  Dio dio,
) async {
  switch (err.type) {
    case DioExceptionType.connectionTimeout:
      handler.resolve(
        Response(
          data: 'connect timeout error',
          requestOptions: err.requestOptions,
        ),
      );
    case DioExceptionType.sendTimeout:
      handler.resolve(
        Response(
          data: 'sending data is slow',
          requestOptions: err.requestOptions,
        ),
      );
    case DioExceptionType.receiveTimeout:
      handler.resolve(
        Response(
          data: 'receiving data is slow',
          requestOptions: err.requestOptions,
        ),
      );
    case DioExceptionType.badResponse:
      if (err.response!.statusCode == 404) {
        handler.resolve(
          Response(
            data: 'server error: status code ${err.response!.statusCode}',
            requestOptions: RequestOptions(path: err.requestOptions.path),
          ),
        );
      } else {
        handler.resolve(
          err.response ??
              Response(
                data: 'response error',
                requestOptions: err.requestOptions,
              ),
        );
      }
    case DioExceptionType.cancel:
      handler.resolve(
        Response(
          data: 'user cancelled request',
          requestOptions: err.requestOptions,
        ),
      );
    case DioExceptionType.badCertificate:
      handler.resolve(
        Response(
          data: 'Bad certificate',
          requestOptions: err.requestOptions,
        ),
      );
    case DioExceptionType.connectionError:
      handler.resolve(
        Response(
          data: 'No Internet',
          requestOptions: err.requestOptions,
        ),
      );
    case DioExceptionType.unknown:
      handler.resolve(
        Response(
          data: 'other error data:${err.response?.data}',
          requestOptions: err.requestOptions,
        ),
      );
  }
}
