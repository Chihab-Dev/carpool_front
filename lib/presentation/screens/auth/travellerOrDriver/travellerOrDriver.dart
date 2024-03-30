import 'package:carpool/presentation/components/appsize.dart';
import 'package:carpool/presentation/components/assets_manager.dart';
import 'package:carpool/presentation/components/color_manager.dart';
import 'package:carpool/presentation/components/strings_manager.dart';
import 'package:carpool/presentation/components/styles_manager.dart';
import 'package:carpool/presentation/components/widgets.dart';
import 'package:carpool/presentation/screens/auth/login/view/login.dart';
import 'package:flutter/material.dart';

class TravellerOrDriverView extends StatelessWidget {
  const TravellerOrDriverView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(AppPadding.p18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: AppSize.s350,
                child: Image.asset(ImageAsset.travellerOrDriver),
              ),
              const SizedBox(height: AppSize.s110),
              Text(
                AppStrings.howDoYouWantToContinueAs,
                style: getRegularStyle(color: ColorManager.dark),
                maxLines: 2,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppSize.s15),
              Text(
                AppStrings.howDoYouWantToContinueAsBody,
                style: getSmallRegularStyle(color: ColorManager.darkGrey),
                maxLines: 2,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppSize.s110),
              CustomLargeButton(
                label: AppStrings.traveller,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginView()),
                  );
                },
              ),
              const SizedBox(height: AppSize.s15),
              CustomLargeButton(
                label: AppStrings.driver,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginView()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
