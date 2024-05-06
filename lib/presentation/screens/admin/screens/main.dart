import 'package:carpool/presentation/components/appsize.dart';
import 'package:carpool/presentation/components/assets_manager.dart';
import 'package:carpool/presentation/components/strings_manager.dart';
import 'package:carpool/presentation/components/widgets.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class AdminMainView extends StatelessWidget {
  const AdminMainView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: AppPadding.p18),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Lottie.asset(LottieAsset.admin),
              SizedBox(height: AppSize.s70),
              CustomLargeButton(label: AppStrings.drivers, onPressed: () {}),
              SizedBox(height: AppSize.s18),
              CustomLargeButton(label: AppStrings.travels, onPressed: () {}),
              SizedBox(height: AppSize.s18),
              CustomLargeButton(label: AppStrings.clients, onPressed: () {}),
            ],
          ),
        ),
      ),
    );
  }
}