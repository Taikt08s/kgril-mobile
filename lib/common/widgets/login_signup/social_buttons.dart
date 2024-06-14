import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:get/get.dart';

import '../../../navigation_dart.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/connection_strings.dart';
import '../../../utils/constants/image_strings.dart';
import '../../../utils/constants/sizes.dart';

class TSocialButton extends StatelessWidget {
  const TSocialButton({
    super.key,
  });

  Future<void> handleGoogleSignIn(BuildContext context) async {
    final GoogleSignIn googleSignIn = GoogleSignIn(
      scopes: ['email'],
    );

    try {
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      if (googleUser != null) {
        final names = googleUser.displayName?.split(' ') ?? [''];
        final firstName = names.first;
        final lastName = names.length > 1 ? names.sublist(1).join(' ') : '';

        final userInfo = {
          'first-name': firstName,
          'last-name': lastName,
          'email': googleUser.email,
          'id': googleUser.id,
          'photo-url': googleUser.photoUrl,
        };

        // Send user information to the backend
        final response = await http.post(
          Uri.parse('${TConnectionStrings.deployment}auth/google-signin'),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(userInfo),
        );

        if (response.statusCode == 200) {
          final data = jsonDecode(response.body);
          // Handle the response, e.g., save tokens, navigate to home screen
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

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
              border: Border.all(color: TColors.grey),
              borderRadius: BorderRadius.circular(100)),
          child: IconButton(
            onPressed: () => handleGoogleSignIn(context),
            icon: const Image(
                width: TSizes.iconLg,
                height: TSizes.iconLg,
                image: AssetImage(TImages.google)),
          ),
        ),
        const SizedBox(width: TSizes.spaceBtwItems),
        Container(
          decoration: BoxDecoration(
              border: Border.all(color: TColors.grey),
              borderRadius: BorderRadius.circular(100)),
          child: IconButton(
            onPressed: () {},
            icon: const Image(
                width: TSizes.iconLg,
                height: TSizes.iconLg,
                image: AssetImage(TImages.facebook)),
          ),
        ),
      ],
    );
  }
}
