// // ignore_for_file: depend_on_referenced_packages

// import 'dart:async';
// import 'dart:convert';

// import 'package:crypto/crypto.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:sign_in_with_apple/sign_in_with_apple.dart';

// import '../shared/console.dart';

// class AuthServices {
//   static final instance = AuthServices._internal();
//   AuthServices._internal();
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   String _verificationId = '';
//   int? _resendCode;
//   final StreamController<AuthResult> _otpController =
//       StreamController<AuthResult>();
//   StreamSink<AuthResult> get _otpSink => _otpController.sink;
//   Stream<AuthResult> get otpStream => _otpController.stream;

//   Future signOut() async {
//     await _auth.signOut();
//     await GoogleSignIn().signOut();
//     // await FacebookAuth.instance.logOut();
//   }

//   // signIngg() async {
//   //   // GoogleSignIn _googleSignIn = GoogleSignIn(
//   //   //   scopes: <String>[
//   //   //     'email',
//   //   //     'https://www.googleapis.com/auth/contacts.readonly',
//   //   //   ],
//   //   // );
//   //   final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
//   //   // Obtain the auth details from the request
//   //   final GoogleSignInAuthentication? googleAuth =
//   //       await googleUser?.authentication;
//   //   // AGCAuthCredential credential =
//   //   //     GoogleAuthProvider.credentialWithToken(googleAuth.idToken);
//   //   // AGCAuth.instance.signIn(credential).then((value) {
//   //   //     _log = 'signInGoogle = ${value.user.uid} , ${value.user.providerId}';
//   //   // });
//   // }
//   Future<UserAuthResult?> signInWithGoogle() async {
//     try {
//       final GoogleSignInAccount? googleUser = await GoogleSignIn(
//               // clientId: ,
//               //  scopes: <String>[
//               // 'email',
//               //   'https://www.googleapis.com/auth/contacts.readonly',
//               // ],
//               )
//           .signIn();
//       final GoogleSignInAuthentication? googleAuth =
//           await googleUser?.authentication;
//       final credential = GoogleAuthProvider.credential(
//           accessToken: googleAuth?.accessToken, idToken: googleAuth?.idToken);
//       UserCredential userCredential =
//           await FirebaseAuth.instance.signInWithCredential(credential);

//       return UserAuthResult(
//           authType: AuthType.google,
//           userCredential: userCredential,
//           googleCredential: googleUser);
//     } catch (e) {
//       console(e);
//       console(';;;;;;;;;;;;;;;;;;;;;;;;;;');
//       return null;
//     }
//   }

//   Future<UserAuthResult?> signInWithApple() async {
//     final rawNonce = generateNonce();
//     final nonce = _sha256ofString(rawNonce);
//     try {
//       final appleCredential = await SignInWithApple.getAppleIDCredential(
//           scopes: [
//             AppleIDAuthorizationScopes.email,
//             AppleIDAuthorizationScopes.fullName
//           ],
//           webAuthenticationOptions: WebAuthenticationOptions(
//               clientId: 'clientId', redirectUri: Uri.parse('redirectUri')),
//           nonce: nonce);
//       // final oauthCredential = OAuthProvider("apple.com").credential(
//       //     idToken: appleCredential.identityToken, rawNonce: rawNonce);
//       final oauthCredential = AppleAuthProvider();
//       UserCredential userCredential =
//           await FirebaseAuth.instance.signInWithProvider(oauthCredential);
//       return UserAuthResult(
//           authType: AuthType.apple,
//           userCredential: userCredential,
//           appleCredential: appleCredential);
//     } catch (e) {
//       console(e);
//       console("apple sign in");
//       return null;
//     }
//   }

//   Future<UserAuthResult?> signInWithFacebook() async {
//     try {
//       final LoginResult result = await FacebookAuth.instance.login();
//       if (result.status == LoginStatus.success) {
//         final OAuthCredential facebookAuthCredential =
//             FacebookAuthProvider.credential(result.accessToken!.token);
//         UserCredential userCredential = await FirebaseAuth.instance
//             .signInWithCredential(facebookAuthCredential);
//         return UserAuthResult(
//             authType: AuthType.facebook, userCredential: userCredential);
//       } else {
//         return null;
//       }
//     } catch (e) {
//       console(e);
//       console(';;;;;;;;;;;;;;;;;;;;;;;;;;');
//       return null;
//     }
//   }

//   // String _generateNonce([int length = 32]) {
//   //   const charset =
//   //       '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';
//   //   final random = Random.secure();
//   //   return List.generate(length, (_) => charset[random.nextInt(charset.length)])
//   //       .join();
//   // }

//   String _sha256ofString(String input) {
//     final bytes = utf8.encode(input);
//     final digest = sha256.convert(bytes);
//     return digest.toString();
//   }

//   signInWithPhone(String phone, {bool isResendCode = false}) async {
//     FirebaseAuth.instance.setSettings(
//       forceRecaptchaFlow: false,
//     );
//     try {
//       _otpSink.add(AuthResult(authState: AuthState.authenticationStarted));
//       await _auth.verifyPhoneNumber(
//         phoneNumber: phone,
//         verificationCompleted: (PhoneAuthCredential credential) async {
//           UserCredential userCredential =
//               await _auth.signInWithCredential(credential);
//           _otpSink.add(AuthResult(
//               authState: AuthState.authenticationStarted,
//               userCredential: userCredential));
//         },
//         verificationFailed: (FirebaseAuthException e) {
//           console(e);
//           console('?????????????????fffffffffffffffffffffffffffff');
//           if (e.code == 'invalid-phone-number') {
//             _otpSink.add(AuthResult(authState: AuthState.invalidPhoneNumber));
//           } else {
//             _otpSink.add(AuthResult(authState: AuthState.failed));
//             console(e);
//           }
//         },
//         forceResendingToken: _resendCode,
//         codeSent: (String verificationId, int? resendToken) async {
//           if (isResendCode) {
//             _otpSink.add(AuthResult(authState: AuthState.resendCode));
//           } else {
//             _otpSink.add(AuthResult(authState: AuthState.codeSent));
//           }
//           console("tokennnnnn sendddd");
//           console(resendToken);
//           console(verificationId);
//           _verificationId = verificationId;
//           _resendCode = resendToken;
//         },
//         codeAutoRetrievalTimeout: (String verificationId) =>
//             _verificationId = verificationId,
//       );
//     } catch (e) {
//       _otpSink.add(AuthResult(authState: AuthState.failed));
//       console(e);
//     }
//   }

//   Future<UserCredential?> submitOtp(String smsCode) async {
//     try {
//       console(smsCode);
//       var phoneAuth = PhoneAuthProvider.credential(
//           verificationId: _verificationId, smsCode: smsCode);
//       return await _auth.signInWithCredential(phoneAuth);
//     } catch (e) {
//       return null;
//     }
//   }
// }

// enum AuthState {
//   authenticationStarted,
//   verificationCompleted,
//   resendCode,
//   invalidPhoneNumber,
//   codeSent,
//   failed
// }

// enum AuthType { apple, google, facebook }

// class UserAuthResult {
//   final AuthType authType;
//   final AuthorizationCredentialAppleID? appleCredential;
//   final GoogleSignInAccount? googleCredential;
//   final UserCredential? userCredential;
//   UserAuthResult(
//       {required this.authType,
//       this.appleCredential,
//       this.googleCredential,
//       this.userCredential});
// }

// class AuthResult {
//   AuthState? authState;
//   UserCredential? userCredential;

//   AuthResult({this.authState, this.userCredential});
// }
