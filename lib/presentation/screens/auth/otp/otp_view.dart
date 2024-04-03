import 'package:carpool/presentation/components/appsize.dart';
import 'package:carpool/presentation/components/assets_manager.dart';
import 'package:carpool/presentation/components/color_manager.dart';
import 'package:carpool/presentation/components/strings_manager.dart';
import 'package:carpool/presentation/components/styles_manager.dart';
import 'package:carpool/presentation/components/widgets.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OtpView extends StatelessWidget {
  const OtpView({super.key});

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
          backgroundColor: Colors.transparent,
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            bottomOpacity: 0,
            scrolledUnderElevation: 0,
          ),
          body: Padding(
            padding: EdgeInsets.all(AppPadding.p18),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    AppStrings.phoneVerification,
                    style: getRegularStyle(color: ColorManager.dark),
                  ),
                  SizedBox(height: AppSize.s10),
                  Text(
                    AppStrings.phoneVerificationDesc,
                    style: getSmallRegularStyle(color: ColorManager.darkGrey),
                  ),
                  SizedBox(height: AppSize.s80),
                  const CustomOtpCodeField(),
                  SizedBox(height: AppSize.s100),
                  CustomMediumButton(
                    label: AppStrings.verify,
                    onPressed: () {},
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

class CustomOtpCodeField extends StatelessWidget {
  const CustomOtpCodeField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: AppSize.s300,
      child: PinCodeTextField(
        controller: null,
        appContext: context,
        autoDismissKeyboard: true,
        cursorColor: ColorManager.dark,
        textStyle: getRegularStyle(color: ColorManager.dark),
        length: 6,
        onChanged: (e) {},
        animationType: AnimationType.scale,
        pinTheme: PinTheme(
          fieldWidth: AppSize.s40,
          inactiveColor: ColorManager.yellow,
        ),
      ),
    );
  }
}
