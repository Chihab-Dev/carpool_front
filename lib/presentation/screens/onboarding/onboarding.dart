import 'package:cached_network_image/cached_network_image.dart';
import 'package:carpool/app/localizations.dart';
import 'package:carpool/app/service_locator.dart';
import 'package:carpool/app/shared_prefrences.dart';
import 'package:carpool/presentation/components/appsize.dart';
import 'package:carpool/presentation/components/assets_manager.dart';
import 'package:carpool/presentation/components/color_manager.dart';
import 'package:carpool/presentation/components/strings_manager.dart';
import 'package:carpool/presentation/components/styles_manager.dart';
import 'package:carpool/presentation/screens/auth/travellerOrDriver/travellerOrDriver.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';

class OnboardingView extends StatelessWidget {
  OnboardingView({super.key});

  final AppPrefences _appPrefences = AppPrefences(getIt());

  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      globalBackgroundColor: ColorManager.white,
      pages: [
        PageViewModel(
          title: AppStrings.selectDateAndTime.tr(context),
          body: AppStrings.selectDateAndTimeBody.tr(context),
          image: CachedNetworkImage(
            imageUrl: ImageAsset.onboardingDate,
            progressIndicatorBuilder: (context, url, downloadProgress) => Center(
                child: CircularProgressIndicator(
              value: downloadProgress.progress,
              color: ColorManager.yellow,
            )),
            errorWidget: (context, url, error) => Center(
                child: Icon(
              Icons.error,
              color: Colors.red,
              size: AppSize.s50,
            )),
          ),
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
          title: AppStrings.chooseTheRoute.tr(context),
          body: AppStrings.chooseTheRouteBody.tr(context),
          image: CachedNetworkImage(
            imageUrl: ImageAsset.onboardingRoute,
            progressIndicatorBuilder: (context, url, downloadProgress) => Center(
                child: CircularProgressIndicator(
              value: downloadProgress.progress,
              color: ColorManager.yellow,
            )),
            errorWidget: (context, url, error) => Center(
                child: Icon(
              Icons.error,
              color: Colors.red,
              size: AppSize.s50,
            )),
          ),
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
          title: AppStrings.travel.tr(context),
          body: AppStrings.travelBody.tr(context),
          image: CachedNetworkImage(
            imageUrl: ImageAsset.onboardingTravel,
            progressIndicatorBuilder: (context, url, downloadProgress) => Center(
                child: CircularProgressIndicator(
              value: downloadProgress.progress,
              color: ColorManager.yellow,
            )),
            errorWidget: (context, url, error) => Center(
                child: Icon(
              Icons.error,
              color: Colors.red,
              size: AppSize.s50,
            )),
          ),
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
      ],
      showNextButton: true,
      showBackButton: true,
      showDoneButton: true,
      onDone: () {
        _appPrefences.setWatchedOnBoarding();
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const TravellerOrDriverView(),
            ));
      },
      next: Text(
        AppStrings.next.tr(context),
        style: getSmallRegularStyle(color: ColorManager.dark).copyWith(fontSize: 17),
      ),
      back: Text(
        AppStrings.back.tr(context),
        style: getSmallRegularStyle(color: ColorManager.dark).copyWith(fontSize: 17),
      ),
      done: Text(
        AppStrings.done.tr(context),
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
