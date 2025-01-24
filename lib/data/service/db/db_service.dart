import 'package:hive_flutter/hive_flutter.dart';
import 'package:lp_customer_onboarding/data/model/user_model.dart';
import 'package:lp_customer_onboarding/data/service/db/i_db_service.dart';

import 'package:multiple_result/multiple_result.dart';

class DbService implements IDbService {
  DbService({required this.userbox});
  final Box userbox;

  @override
  Future<Result<UserModel, Exception>> getUser() async {
    final userJson = await userbox.get('user');
    if (userJson != null) {
      return Success(UserModel.fromJson(userJson.toString()));
    } else {
      return Error(Exception('User not found'));
    }
  }

  @override
  Future<Result<bool, Exception>> saveUser(UserModel user) async {
    await userbox.put('user', user.toJson());
    return const Success(true);
  }

  @override
  Future<Result<String, Exception>> getToken() async {
    final token = await userbox.get('token');
    if (token != null) {
      return Success(token);
    } else {
      return Error(Exception('token not found'));
    }
  }

  @override
  Future<Result<bool, Exception>> saveToken({required String token}) async {
    await userbox.put('token', token);
    return const Success(true);
  }

  @override
  Future<Result<bool, Exception>> saveUniqueUserId(
      {required String uniqueUserId}) async {
    await userbox.put('uniqueUserId', uniqueUserId);
    return const Success(true);
  }

  @override
  Future<Result<String, Exception>> getsaveUniqueUserId() async {
    final uniqueUserId = await userbox.get('uniqueUserId');
    if (uniqueUserId != null) {
      return Success(uniqueUserId);
    } else {
      return Error(Exception('uniqueUserId not found'));
    }
  }

  @override
  Future<Result<bool, Exception>> removeAllUserRegisterDatas() async {
    await userbox.delete('uniqueUserId');
    await userbox.delete('token');
    await userbox.delete('user');

    return const Success(true);
  }

  @override
  Future<Result<bool, Exception>> isUserAvailable() async {
    final user = await getUser();
    return user.when(
      (success) => const Success(true),
      (error) => Error(error),
    );
  }
}
