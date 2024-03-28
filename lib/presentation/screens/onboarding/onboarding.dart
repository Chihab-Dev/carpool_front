import 'package:carpool/presentation/components/appsize.dart';
import 'package:carpool/presentation/components/assets_manager.dart';
import 'package:carpool/presentation/components/color_manager.dart';
import 'package:carpool/presentation/components/styles_manager.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';

class OnboardingView extends StatelessWidget {
  const OnboardingView({super.key});

  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      globalBackgroundColor: ColorManager.white,
      pages: pagesViewModel,
      showNextButton: true,
      showBackButton: true,
      showDoneButton: true,
      onDone: () {
        //TODO: NAVIGATE TO LOGIN SCREEN
      },
      next: Text(
        'next',
        style: TextStyle(color: ColorManager.dark),
      ),
      back: Text(
        'back',
        style: TextStyle(color: ColorManager.dark),
      ),
      done: Text(
        'DONE',
        style: TextStyle(color: ColorManager.dark),
      ),
      dotsDecorator: DotsDecorator(
        size: const Size.square(10.0),
        activeSize: const Size(20.0, 10.0),
        activeColor: ColorManager.yellow,
        color: ColorManager.lightGrey,
        spacing: const EdgeInsets.symmetric(horizontal: 3.0),
        activeShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0)),
      ),
    );
  }
}

List<PageViewModel> pagesViewModel = [
  PageViewModel(
    title: 'Select the date / time',
    body: 'Pick your departure time. Select the date and time for your journey effortlessly',
    image: Image.asset(ImageAsset.onboardingDate),
    decoration: PageDecoration(
      titleTextStyle: getRegularStyle(color: ColorManager.dark),
      bodyPadding: const EdgeInsets.symmetric(horizontal: AppPadding.p20),
      bodyTextStyle: TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: 15,
        color: ColorManager.darkGrey,
      ),
    ),
  ),
  PageViewModel(
    title: 'Choose the route',
    body: 'Select your preferred route. Find the best path to your destination with ease.',
    image: Image.asset(ImageAsset.onboardingRoute),
    decoration: PageDecoration(
      titleTextStyle: getRegularStyle(color: ColorManager.dark),
      bodyPadding: const EdgeInsets.symmetric(horizontal: AppPadding.p20),
      bodyTextStyle: TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: 15,
        color: ColorManager.darkGrey,
      ),
    ),
  ),
  PageViewModel(
    title: 'Travel',
    body: 'Begin your journey. Join rides, connect with drivers and passengers, and enjoy the trip',
    image: Image.asset(ImageAsset.onboardingTravel),
    decoration: PageDecoration(
      titleTextStyle: getRegularStyle(color: ColorManager.dark),
      bodyPadding: const EdgeInsets.symmetric(horizontal: AppPadding.p20),
      bodyTextStyle: TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: 15,
        color: ColorManager.darkGrey,
      ),
    ),
  ),
];
