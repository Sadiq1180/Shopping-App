// // ignore_for_file: use_build_context_synchronously

// import 'package:balansize/domain/api_services/api_response.dart';
// import 'package:balansize/domain/data_classes/auth_data_model.dart';
// import 'package:balansize/presentation/views/screens/main_screens/main_screen.dart';
// import 'package:balansize/presentation/views/screens/onboarding_screens/onboarding_screen.dart';
// import 'package:balansize/presentation/views/screens/onboarding_screens/verify_email_screen.dart';
// import 'package:balansize/providers/user_provider.dart';
// import 'package:balansize/services/app_Loader.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import '../domain/api_models/user_model.dart';
// import '../domain/base_repo/base_repo.dart';
// import '../presentation/views/screens/onboarding_screens/create_account_screen.dart';
// import '../presentation/views/screens/personalized_test/priority_screen.dart';
// import '../presentation/views/screens/personalized_test/questionaire_initial.dart';
// import '../services/auth_service.dart';
// import '../services/validation.dart';
// import '../shared/shared.dart';

// final authProvider =
//     NotifierProvider<AuthProvider, AuthDataModel>(AuthProvider.new);

// class AuthProvider extends Notifier<AuthDataModel> with BaseRepo {
//   @override
//   AuthDataModel build() => AuthDataModel(currentIndex: 0);

//   verifyOtp(String code, String? otpToken, String? email) async {
//     String? result = validateEmail(email ?? '');
//     if (result != null) {
//       appSnackBar(appContext, result);
//       return;
//     }
//     AppLoader.show();
//     ApiResponse res = await authRepo.verifyCode(code, otpToken ?? "");
//     AppLoader.hide();
//     if (res.status == Status.completed) {
//       UserModel data = res.data as UserModel;
//       _handleUser(data, email!);
//     } else {
//       appSnackBar(appContext, res.message!);
//     }
//   }

//   Future<String?> resendOtp(String? email) async {
//     AppLoader.show();
//     ApiResponse res = await authRepo.resendCode(email ?? '');
//     AppLoader.hide();
//     if (res.status == Status.completed) {
//       UserModel data = res.data as UserModel;
//       return data.result!.otpToken;
//     } else {
//       appSnackBar(appContext, res.message!);
//       return null;
//     }
//   }

//   emailSignIn(String email) async {
//     email = email.toLowerCase().trim();
//     String? result = validateEmail(email);
//     if (result != null) {
//       appSnackBar(appContext, result);
//       return;
//     }
//     AppLoader.show();
//     ApiResponse res = await authRepo.signIn(email);
//     AppLoader.hide();
//     if (res.status == Status.completed) {
//       UserModel data = res.data as UserModel;
//       if (data.success ?? false) {
//         Navigation.pushNamed(VerifyEmailScreen.routeName,
//             args: VerifyEmailScreenArgs(
//                 email: email, otpToken: data.result?.otpToken));
//       }
//     } else {
//       appSnackBar(appContext, res.message!);
//     }
//   }

//   _register(String? firstName, String? lastName, String email, String loginType,
//       String? socialId) async {
//     AppLoader.show();
//     email = email.toLowerCase().trim();
//     ApiResponse res = await authRepo.register(firstName?.trim(), lastName?.trim(), email,
//         loginType, socialId, AppData.instance.locale?.languageCode ?? "en");
//     AppLoader.hide();
//     if (res.status == Status.completed) {
//       UserModel data = res.data as UserModel;
//       _handleUser(data, email);
//     }
//   }

//   _handleUser(UserModel data, String email) {
//     if (data.success ?? false) {
//       if (!(data.result!.isVerified!)) {
//         appSnackBar(appContext, data.message!);
//       } else if (data.result!.isRegistered!) {
//         if(data.result?.user ==null) {
//          logOut();
//           return;
//         }
//         saveUserAndToken(data, data.result!.accessToken!);
//         ref.read(userProvider.notifier).setUser(data);
//         if (!(data.result?.user?.isPriority ?? true)) {
//           Navigation.pushNamedAndRemoveUntil(PriorityScreen.routeName);
//         } else if (!(data.result?.user?.isQuestionnaire ?? true)) {
//           Navigation.pushNamedAndRemoveUntil(QuestionnaireInitial.routeName);
//         } else {
//           Navigation.pushNamedAndRemoveUntil(MainScreen.routeName);
//         }
//       } else {
//         Navigation.pushNamedAndRemoveUntil(CreateAccountScreen.routeName,
//             args: CreateEmailScreenArgs(email: email));
//       }
//     } else {
//       appSnackBar(appContext, data.message ?? '');
//     }
//   }

//   emailSignUp(String? firstName, String? lastName, String email) {
//     String? result = validateNames(firstName, lastName, email);
//     if (result != null) {
//       appSnackBar(appContext, result);
//       return;
//     }
//     _register(firstName, lastName, email, "email", null);
//   }

//   googleSignIn() async {
//     UserAuthResult? userAuthResult =
//         await AuthServices.instance.signInWithGoogle();
//     if (isNotNull(userAuthResult)) {
//       console(userAuthResult?.userCredential?.user?.photoURL);
//       _register(
//           userAuthResult?.userCredential?.user?.displayName?.split(" ").first,
//           userAuthResult?.userCredential?.user?.displayName?.split(" ").last,
//           userAuthResult!.userCredential!.user!.email!,
//           "google",
//           userAuthResult.userCredential!.user!.uid);
//     }
//   }

//   facebookSignIn() async {
//     UserAuthResult? userAuthResult =
//         await AuthServices.instance.signInWithFacebook();
//     if (isNotNull(userAuthResult)) {
//       console(userAuthResult?.userCredential?.user?.photoURL);
//       _register(
//           userAuthResult?.userCredential?.user?.displayName?.split(" ").first,
//           userAuthResult?.userCredential?.user?.displayName?.split(" ").last,
//           userAuthResult!.userCredential!.user!.email!,
//           "facebook",
//           userAuthResult.userCredential!.user!.uid);
//     }
//   }

//   appleSignIn() async {
//     UserAuthResult? userAuthResult =
//         await AuthServices.instance.signInWithApple();
//     if (isNotNull(userAuthResult)) {
//       _register(
//           userAuthResult?.appleCredential?.givenName,
//           userAuthResult?.appleCredential?.familyName,
//           userAuthResult!.userCredential!.user!.email!,
//           "apple",
//           userAuthResult.userCredential!.user!.uid);
//     }
//   }

//   void logOut() async {
//     AppLoader.show();
//     await AuthServices.instance.signOut();
//     await clear();
//     AppData.instance.setUser(null);
//     AppData.instance.setToken(null);
//     AppLoader.hide();
//     Navigation.pushNamedAndRemoveUntil(OnboardingScreen.routeName);
//   }
// }
