import 'package:carpool/app/localizations.dart';
import 'package:carpool/presentation/components/appsize.dart';
import 'package:carpool/presentation/components/color_manager.dart';
import 'package:carpool/presentation/components/strings_manager.dart';
import 'package:carpool/presentation/components/styles_manager.dart';
import 'package:carpool/presentation/screens/auth/travellerOrDriver/travellerOrDriver.dart';
import 'package:flutter/material.dart';

class UnderReviewView extends StatelessWidget {
  const UnderReviewView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        bottomOpacity: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => const TravellerOrDriverView(),
                ),
                (route) => false);
          },
          icon: Icon(
            Icons.arrow_back_ios_rounded,
            color: ColorManager.dark,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(AppPadding.p18),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.done,
                color: ColorManager.green,
                size: AppSize.s280,
              ),
              // Image.asset(
              //   ImageAsset.correct,
              //   fit: BoxFit.cover,
              // ),
              SizedBox(height: AppSize.s80),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: AppPadding.p25),
                child: Text(
                  AppStrings.yourAccountUnderReview.tr(context),
                  textAlign: TextAlign.center,
                  style: getRegularStyle(color: ColorManager.dark),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
