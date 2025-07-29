// // ignore_for_file: use_build_context_synchronously

// import 'dart:convert';

// import 'package:balansize/domain/api_models/general_model.dart';
// import 'package:balansize/domain/api_services/api_response.dart';
// import 'package:balansize/domain/data_classes/user_data.dart';
// import 'package:balansize/providers/auth_provider.dart';
// import 'package:balansize/providers/localization_provider.dart';
// import 'package:balansize/services/app_Loader.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:image_picker/image_picker.dart';
// import '../domain/api_models/user_model.dart';
// import '../domain/base_repo/base_repo.dart';
// import '../shared/constants/app_local_keys.dart';
// import '../shared/shared.dart';

// final userProvider = NotifierProvider<UserProvider, UserData>(UserProvider.new);

// class UserProvider extends Notifier<UserData> with BaseRepo {
//   @override
//   UserData build() => UserData();

//   setUser(UserModel user) {
//     state = state.copyWith(user: user);
//     int langIndex = LangConstants.languages.indexWhere((element) =>
//         element.languageCode == (user.result?.user?.language ?? "en"));
//     ref.read(localizationProvider.notifier).setLanguage(langIndex);
//   }

//   getUser() async {
//     ApiResponse res = await authRepo.getUser(enableLocalPersistence: true);
//     if (res.status == Status.completed) {
//       UserModel data = res.data as UserModel;
//       if (data.success ?? false) {
//         saveUserAndToken(data, data.result!.accessToken!);
//         setUser(data);
//       }
//     } else {
//       await clear();
//       appSnackBar(appContext, res.message!);
//     }
//   }

//   updateProfile(String firstName, String lastName) async {
//     AppLoader.show();
//     ApiResponse res = await userRepo.updateProfile(firstName, lastName);
//     AppLoader.hide();
//     if (res.status == Status.completed) {
//       UserModel data = res.data as UserModel;
//       if (data.success ?? false) {
//         saveUserAndToken(data, data.result!.accessToken!);
//         setUser(data);
//         Navigation.pop();
//       } else {
//         appSnackBar(appContext, res.message ?? '');
//       }
//     } else {
//       appSnackBar(appContext, res.message!);
//     }
//   }

//   updateNotifications(bool recommendation, bool emailNotification,
//       bool pushNotification) async {
//     User? user = state.user?.result?.user;
//     if (user?.recommendation == recommendation &&
//         user?.emailNotification == emailNotification &&
//         user?.pushNotification == pushNotification) {
//       return;
//     }
//     ApiResponse res = await userRepo.updateNotifications(
//         recommendation, emailNotification, pushNotification);
//     if (res.status == Status.completed) {
//       UserModel data = res.data as UserModel;
//       if (data.success ?? false) {
//         saveUserAndToken(data, data.result!.accessToken!);
//         setUser(data);
//       } else {
//         appSnackBar(appContext, res.message ?? '');
//       }
//     } else {
//       appSnackBar(appContext, res.message!);
//     }
//   }

//   deleteUser() async {
//     AppLoader.show();
//     ApiResponse res = await userRepo.deleteUser();
//     AppLoader.hide();
//     if (res.status == Status.completed) {
//       GeneralModel data = res.data as GeneralModel;
//       if (data.success ?? false) {
//         appSnackBar(appContext, data.message ?? '');
//         ref.read(authProvider.notifier).logOut();
//       } else {
//         appSnackBar(appContext, data.message ?? '');
//       }
//     } else {
//       appSnackBar(appContext, res.message!);
//     }
//   }

//   updateLanguage(Locale locale) async {
//     if (AppData.instance.token == null) return;
//     AppLoader.show();
//     ApiResponse res = await userRepo.updateLanguage(locale.languageCode);
//     AppLoader.hide();
//     if (res.status == Status.completed) {
//       UserModel data = res.data as UserModel;
//       if (data.success ?? false) {
//         saveUserAndToken(data, data.result!.accessToken!);
//         setUser(data);
//       } else {
//         appSnackBar(appContext, data.message ?? '');
//       }
//     } else {
//       appSnackBar(appContext, res.message!);
//     }
//   }

//   uploadPicture(ImageSource source) async {
//     String? path = await Pickers.ins.pickImage(source: source);
//     if (path != null) {
//       ApiResponse res = await authRepo.uploadProfilePic(path);
//       if (res.status == Status.completed) {
//         UserModel data = res.data as UserModel;
//         if (data.success ?? false) {
//           saveUserAndToken(data, data.result!.accessToken!);
//           setUser(data);
//         }
//       }
//     }
//   }
// }

// Future clear() async {
//   await AppLocal.ins.userBox.clear();
// }

// _saveUser(UserModel user) {
//   AppData.instance.setUser(user);
//   AppLocal.ins.userBox.put(AppLocalKeys.user, json.encode(user.toJson()));
// }

// _saveToken(String token) {
//   AppData.instance.setToken(token);
//   AppLocal.ins.userBox.put(AppLocalKeys.token, token);
// }

// saveUserAndToken(UserModel user, String token) {
//   _saveUser(user);
//   _saveToken(token);
// }
