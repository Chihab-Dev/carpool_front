import 'package:carpool/presentation/components/appsize.dart';
import 'package:carpool/presentation/components/assets_manager.dart';
import 'package:carpool/presentation/components/color_manager.dart';
import 'package:carpool/presentation/components/strings_manager.dart';
import 'package:carpool/presentation/components/styles_manager.dart';
import 'package:carpool/presentation/screens/auth/travellerOrDriver/travellerOrDriver.dart';
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
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const TravellerOrDriverView(),
            ));
      },
      next: Text(
        AppStrings.next,
        style: getSmallRegularStyle(color: ColorManager.dark).copyWith(fontSize: 17),
      ),
      back: Text(
        AppStrings.back,
        style: getSmallRegularStyle(color: ColorManager.dark).copyWith(fontSize: 17),
      ),
      done: Text(
        AppStrings.done,
        style: getSmallRegularStyle(color: ColorManager.dark).copyWith(fontSize: 17),
      ),
      dotsDecorator: DotsDecorator(
        size: const Size.square(15.0),
        activeSize: const Size(25.0, 15.0),
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
    title: AppStrings.selectDateAndTime,
    body: AppStrings.selectDateAndTimeBody,
    image: Image.asset(ImageAsset.onboardingDate),
    decoration: PageDecoration(
      titleTextStyle: getRegularStyle(color: ColorManager.dark),
      bodyPadding: EdgeInsets.symmetric(horizontal: AppPadding.p20),
      bodyTextStyle: TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: 15,
        color: ColorManager.darkGrey,
      ),
    ),
  ),
  PageViewModel(
    title: AppStrings.chooseTheRoute,
    body: AppStrings.chooseTheRouteBody,
    image: Image.asset(ImageAsset.onboardingRoute),
    decoration: PageDecoration(
      titleTextStyle: getRegularStyle(color: ColorManager.dark),
      bodyPadding: EdgeInsets.symmetric(horizontal: AppPadding.p20),
      bodyTextStyle: TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: 15,
        color: ColorManager.darkGrey,
      ),
    ),
  ),
  PageViewModel(
    title: AppStrings.travel,
    body: AppStrings.travelBody,
    image: Image.asset(ImageAsset.onboardingTravel),
    decoration: PageDecoration(
      titleTextStyle: getRegularStyle(color: ColorManager.dark),
      bodyPadding: EdgeInsets.symmetric(horizontal: AppPadding.p20),
      bodyTextStyle: TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: 15,
        color: ColorManager.darkGrey,
      ),
    ),
  ),
];
