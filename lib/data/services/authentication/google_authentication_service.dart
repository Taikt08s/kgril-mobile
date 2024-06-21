import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:get/get.dart';
import 'package:flutter/foundation.dart';
import '../../../utils/constants/connection_strings.dart';
import '../../../navigation_dart.dart';
import '../../../utils/constants/image_strings.dart';
import '../../../utils/helpers/network_manager.dart';
import '../../../utils/popups/full_screen_loader.dart';
import '../../../utils/popups/loaders.dart';

Future<void> handleGoogleSignIn(BuildContext context) async {
  final GoogleSignIn googleSignIn = GoogleSignIn(
    scopes: ['email'],
  );

  try {
    TFullScreenLoader.openLoadingDialog(
        'Đang xử lí chờ xíu...', TImages.screenLoading);

    final isConnected = await NetworkManager.instance.isConnected();
    if (!isConnected) return;

    final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
    if (googleUser != null) {
      final names = googleUser.displayName?.split(' ') ?? [''];
      final firstName = names.first;
      final lastName = names.length > 1 ? names.sublist(1).join(' ') : '';

      final userInfo = {
        'first_name': firstName,
        'last_name': lastName,
        'email': googleUser.email,
        'id': googleUser.id,
        'photo_url': googleUser.photoUrl,
      };

      // Send user information to the backend
      final response = await http.post(
        Uri.parse('${TConnectionStrings.deployment}auth/google-signin'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(userInfo),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        Get.off(() => const NavigationMenu());
        if (kDebugMode) {
          print('Login successful: $data');
        }
      } else {
        if (kDebugMode) {
          print('Login failed: ${response.body}');
        }
      }
    }
  } catch (e) {
    TFullScreenLoader.stopLoading();
    TLoaders.errorSnackBar(title: 'Xảy ra lỗi rồi!', message: e.toString());
    if (kDebugMode) {
      print(e);
    }
  }
}

///This method use to logged out the user who sign in with the google account
// Future<void> handleGoogleSignOut(BuildContext context) async {
//   final GoogleSignIn googleSignIn = GoogleSignIn();
//
//   try {
//     await googleSignIn.signOut();
//   } catch (e) {
//     if (kDebugMode) {
//       print(e);
//     }
//   }
// }
