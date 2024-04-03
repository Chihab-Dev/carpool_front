import 'package:carpool/presentation/components/appsize.dart';
import 'package:carpool/presentation/components/assets_manager.dart';
import 'package:carpool/presentation/components/color_manager.dart';
import 'package:carpool/presentation/components/strings_manager.dart';
import 'package:carpool/presentation/components/styles_manager.dart';
import 'package:carpool/presentation/screens/auth/login/view/login.dart';
import 'package:flutter/material.dart';

class UnderReviewView extends StatelessWidget {
  const UnderReviewView({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Image.asset(
            ImageAsset.background,
            fit: BoxFit.cover,
          ),
        ),
        Scaffold(
          extendBodyBehindAppBar: true,
          backgroundColor: Colors.transparent,
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
                      builder: (context) => const LoginView(),
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
                  Image.asset(
                    ImageAsset.correct,
                    fit: BoxFit.cover,
                  ),
                  SizedBox(height: AppSize.s80),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: AppPadding.p25),
                    child: Text(
                      AppStrings.youAccountUnderReview,
                      textAlign: TextAlign.center,
                      style: getRegularStyle(color: ColorManager.dark),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
