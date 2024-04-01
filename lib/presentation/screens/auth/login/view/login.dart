import 'package:carpool/presentation/components/appsize.dart';
import 'package:carpool/presentation/components/assets_manager.dart';
import 'package:carpool/presentation/components/color_manager.dart';
import 'package:carpool/presentation/components/strings_manager.dart';
import 'package:carpool/presentation/components/styles_manager.dart';
import 'package:carpool/presentation/components/widgets.dart';
import 'package:carpool/presentation/screens/auth/login/cubit/login_cubit.dart';
import 'package:carpool/presentation/screens/auth/login/cubit/login_states.dart';
import 'package:carpool/presentation/screens/auth/register/view/register.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = LoginCubit.get(context);
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
                  padding: EdgeInsets.all(AppPadding.p18),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: AppSize.s80),
                      SizedBox(
                        width: AppSize.s350,
                        child: Image.asset(ImageAsset.login),
                      ),
                      SizedBox(height: AppSize.s80),
                      CustomFormField(
                        textEditingcontroller: cubit.phoneNumberController,
                        label: AppStrings.phoneNumber,
                        keyboardType: TextInputType.phone,
                        errorLabel: cubit.phoneNumberErrorMessage,
                        onChanged: (value) {
                          cubit.isPhoneNumberValid();
                        },
                        icon: null,
                      ),
                      SizedBox(height: AppSize.s20),
                      CustomPasswordFormField(
                        textEditingcontroller: cubit.passwordController,
                        label: AppStrings.password,
                        errorLabel: null,
                        keyboardType: TextInputType.visiblePassword,
                        onChanged: (value) {},
                        onVisibleChanged: () {
                          cubit.changePasswordVisibility();
                        },
                        isPasswordVisible: cubit.isPasswordVisible,
                      ),
                      SizedBox(height: AppSize.s20),
                      CustomLargeButton(
                          label: AppStrings.login,
                          onPressed: () {
                            cubit.login();
                          }),
                      SizedBox(height: AppSize.s20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            AppStrings.dontHaveAnAccount,
                            style: getSmallRegularStyle(color: ColorManager.dark.withOpacity(0.5)),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const RegisterView(),
                                ),
                              );
                            },
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
        },
      ),
    );
  }
}