import 'dart:async';
import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domain/api_models/user_model.dart';
import '../domain/base_repo/base_repo.dart';
import '../shared/app_persistance/app_data.dart';
import '../shared/app_persistance/app_local.dart';
import '../shared/constants/app_local_keys.dart';
import '../shared/general_methods.dart';

final splashProvider = AsyncNotifierProvider<SplashProvider, UserState>(
  SplashProvider.new,
);

enum UserState { login, home, notAuthenticated }

class SplashProvider extends AsyncNotifier<UserState> with BaseRepo {
  @override
  FutureOr<UserState> build() async {
    String? token = AppLocal.ins.userBox.get(AppLocalKeys.token);
    UserModel? user;
    bool isTokenValid = true;
    if (isNotNull(token)) {
      AppData.instance.setToken(token!);
      String? userjson = AppLocal.ins.userBox.get(AppLocalKeys.user);
      var jsons = json.decode(userjson!);
      user = UserModel.fromJson(jsons);
      //  ref.read(userProvider.notifier).getUser();
      AppData.instance.setUser(user);
      isTokenValid = await Future.value(false);
      // isTokenValid = await _verifyToken();
    }
    return await Future.delayed(const Duration(seconds: 1), () {
      if (isNull(token)) {
        return UserState.login;
      } else if (!isTokenValid) {
        print("validddddd");
        return UserState.notAuthenticated;
      } else if (user?.data?.user == null) {
        print("not validddddd");

        return UserState.login;
      } else {
        return UserState.home;
      }
    });
  }

  // Future<bool> _verifyToken() async {
  //   ApiResponse res = await authRepo.verifyToken();
  //   if (res.status != Status.completed) {
  //     return false;
  //   } else {
  //     final data = res.data as GeneralModel;
  //     return data.status ?? false;
  //   }
  // }
}
