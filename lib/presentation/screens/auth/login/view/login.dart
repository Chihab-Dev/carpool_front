import 'package:carpool/presentation/components/appsize.dart';
import 'package:carpool/presentation/components/assets_manager.dart';
import 'package:carpool/presentation/components/color_manager.dart';
import 'package:carpool/presentation/components/strings_manager.dart';
import 'package:carpool/presentation/components/styles_manager.dart';
import 'package:carpool/presentation/components/widgets.dart';
import 'package:flutter/material.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController phoneNumberController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        bottomOpacity: 0,
        scrolledUnderElevation: 0,
      ),
      backgroundColor: ColorManager.white,
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(AppPadding.p18),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: AppSize.s80),
                SizedBox(
                  width: AppSize.s350,
                  child: Image.asset(ImageAsset.login),
                ),
                const SizedBox(height: AppSize.s80),
                CustomFormField(
                  textEditingcontroller: phoneNumberController,
                  label: AppStrings.phoneNumber,
                  keyboardType: TextInputType.phone,
                  errorLabel: null,
                  onChanged: (value) {},
                ),
                const SizedBox(height: AppSize.s20),
                customPasswordFormField(
                  textEditingcontroller: passwordController,
                  label: AppStrings.password,
                  errorLabel: null,
                  keyboardType: TextInputType.visiblePassword,
                  onChanged: (value) {},
                  onVisibleChanged: () {},
                  isPasswordVisible: false,
                ),
                const SizedBox(height: AppSize.s20),
                CustomLargeButton(label: AppStrings.login, onPressed: () {}),
                const SizedBox(height: AppSize.s20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      AppStrings.dontHaveAnAccount,
                      style: getSmallRegularStyle(color: ColorManager.dark.withOpacity(0.5)),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        AppStrings.register,
                        style: getSmallRegularStyle(color: ColorManager.yellow),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
