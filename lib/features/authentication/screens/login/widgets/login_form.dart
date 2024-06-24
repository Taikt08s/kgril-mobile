import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../navigation_dart.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/constants/text_strings.dart';
import '../../password_configuration/forget_password.dart';
import '../../signup/signup.dart';
import '../../signup/verify_email.dart';

class TLoginForm extends StatelessWidget {
  const TLoginForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: TSizes.spaceBtwSections),
        child: Column(
          children: [
            ///email
            TextFormField(
              decoration: const InputDecoration(
                  prefixIcon: Icon(Iconsax.user_square),
                  labelText: TTexts.email),
            ),

            const SizedBox(height: TSizes.spaceBtwInputFields),

            ///password
            TextFormField(
              decoration: const InputDecoration(
                  prefixIcon: Icon(Iconsax.password_check),
                  labelText: TTexts.password,
                  suffixIcon: Icon(Iconsax.eye_slash)),
            ),

            const SizedBox(height: TSizes.spaceBtwInputFields / 2),

            ///remember me and forgot password
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ///otp input
                TextButton(
                    onPressed: () => Get.to(() => const VerifyEmailScreen()),
                    child: const Text(TTexts.inputOtp)),

                ///forgot password
                TextButton(
                    onPressed: () => Get.to(() => const ForgetPassword()),
                    child: const Text(TTexts.forgetPassword)),
              ],
            ),
            const SizedBox(height: TSizes.spaceBtwItems),

            ///Sign in button
            SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                    onPressed: () => Get.to(() => const NavigationMenu()),
                    child: const Text(TTexts.signIn))),
            const SizedBox(height: TSizes.spaceBtwItems),

            ///create account button
            SizedBox(
                width: double.infinity,
                height: 50,
                child: OutlinedButton(
                    onPressed: () => Get.to(
                          () => const SignupScreen(),
                          transition: Transition.cupertinoDialog,
                          duration: const Duration(milliseconds: 400),
                        ),
                    child: const Text(TTexts.createAccount))),
          ],
        ),
      ),
    );
  }
}
