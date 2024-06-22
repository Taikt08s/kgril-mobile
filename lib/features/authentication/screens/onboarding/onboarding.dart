import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kgrill_mobile/features/authentication/screens/onboarding/widgets/onboarding_dot_navigation.dart';
import 'package:kgrill_mobile/features/authentication/screens/onboarding/widgets/onboarding_next_button.dart';
import 'package:kgrill_mobile/features/authentication/screens/onboarding/widgets/onboarding_page.dart';
import 'package:kgrill_mobile/features/authentication/screens/onboarding/widgets/onboarding_skip.dart';

import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/constants/text_strings.dart';
import '../../controllers/onboarding/onboarding_controller.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OnBoardingController());

    //-- The FutureBuilder is used to wait until the _precacheImages future is complete
    //-- While the future is being resolved (ConnectionState.waiting),
    // a loading indicator is displayed
    return FutureBuilder(
      future: _precacheImages(context),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            backgroundColor: Colors.white,
            body: Center(
              child: CircularProgressIndicator(
                color: TColors.primary,
              ),
            ),
          );
        } else {
          return Scaffold(
            body: Stack(
              children: [
                /// Horizontal Scrollable Pages
                PageView(
                  controller: controller.pageController,
                  onPageChanged: controller.updatePageIndicator,
                  children: const [
                    OnBoardingPage(
                      image: TImages.onBoardingImage1,
                      title: TTexts.onBoardingTitle1,
                      subTitle: TTexts.onBoardingSubTitle1,
                    ),
                    OnBoardingPage(
                      image: TImages.onBoardingImage2,
                      title: TTexts.onBoardingTitle2,
                      subTitle: TTexts.onBoardingSubTitle2,
                    ),
                    OnBoardingPage(
                      image: TImages.onBoardingImage3,
                      title: TTexts.onBoardingTitle3,
                      subTitle: TTexts.onBoardingSubTitle3,
                    ),
                  ],
                ),

                /// Skip Button
                const OnBoardingSkip(),

                /// Dot Navigation SmoothPageIndicator
                const OnBoardingDotNavigation(),

                /// Circular Button
                const OnBoardingNextButton(),
              ],
            ),
          );
        }
      },
    );
  }

  //Pre-cache Images Method load the images into memory
  Future<void> _precacheImages(BuildContext context) async {
    await Future.wait([
      precacheImage(const AssetImage(TImages.onBoardingImage1), context),
      precacheImage(const AssetImage(TImages.onBoardingImage2), context),
      precacheImage(const AssetImage(TImages.onBoardingImage3), context),
    ]);
  }
}
