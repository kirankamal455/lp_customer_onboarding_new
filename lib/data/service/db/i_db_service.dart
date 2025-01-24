import 'package:lp_customer_onboarding/data/model/user_model.dart';
import 'package:multiple_result/multiple_result.dart';

abstract class IDbService {
  Future<Result<bool, Exception>> saveUser(UserModel user);
  Future<Result<UserModel, Exception>> getUser();
  Future<Result<bool, Exception>> saveToken({required String token});
  Future<Result<bool, Exception>> isUserAvailable();
  Future<Result<String, Exception>> getToken();
  Future<Result<bool, Exception>> saveUniqueUserId(
      {required String uniqueUserId});
  Future<Result<String, Exception>> getsaveUniqueUserId();
  Future<Result<bool, Exception>> removeAllUserRegisterDatas();
}
