import 'package:dio/dio.dart';
import 'package:lp_customer_onboarding/bootstrap.dart';
import 'package:lp_customer_onboarding/shared/exception/base_exception.dart';

extension ResponseFormatChecker<T> on Response<T> {
  bool isFormatValid({
    String? key,
  }) {
    if ((statusCode == 200 || statusCode == 201) &&
        data != null &&
        data is Map &&
        (key != null
            ? ((data as Map).containsKey(key) && (data as Map)[key] != null)
            : true)) {
      talker.debug('valid response');
      return true;
    } else {
      talker.debug('invalid response $realUri $statusCode');
      if (statusCode == 401) {
        talker.error("UNauthorized");
      }
      return false;
    }
  }

  APIException getErrorMessage() {
    if (data != null && data is Map && ((data as Map?)?['message'] != null)) {
      return APIException(
          statusCode: statusCode,
          statusMessage: statusMessage,
          errorMessage: (data as Map?)?['message']);
    } else {
      return APIException(
        statusCode: statusCode,
        statusMessage: statusMessage,
        errorMessage: data.toString(),
      );
    }
  }
}
