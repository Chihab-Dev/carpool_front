import 'package:carpool/presentation/components/appsize.dart';
import 'package:carpool/presentation/components/assets_manager.dart';
import 'package:carpool/presentation/components/color_manager.dart';
import 'package:carpool/presentation/components/strings_manager.dart';
import 'package:carpool/presentation/components/styles_manager.dart';
import 'package:carpool/presentation/components/widgets.dart';
import 'package:carpool/presentation/screens/auth/register/cubit/register_cubit.dart';
import 'package:carpool/presentation/screens/auth/register/cubit/register_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit, RegisterStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = RegisterCubit.get(context);
          return Scaffold(
            backgroundColor: ColorManager.white,
            extendBodyBehindAppBar: true,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              bottomOpacity: 0,
              scrolledUnderElevation: 0,
              title: Text(
                AppStrings.register,
                style: getMeduimStyle(color: ColorManager.dark),
              ),
            ),
            body: Padding(
              padding: EdgeInsets.all(AppPadding.p18),
              child: SingleChildScrollView(
                child: Center(
                  child: Column(
                    children: [
                      const SizedBox(height: kToolbarHeight + kToolbarHeight / 2),
                      Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          CircleAvatar(
                            radius: AppSize.s70,
                            backgroundColor: ColorManager.lightGrey,
                            backgroundImage: const AssetImage(ImageAsset.userProfile),
                            foregroundImage: cubit.image != null ? FileImage(cubit.image!) : null,
                          ),
                          InkWell(
                            onTap: () async {
                              cubit.pickImage();
                            },
                            child: CircleAvatar(
                              radius: AppSize.s18,
                              backgroundColor: ColorManager.yellow,
                              child: Icon(
                                Icons.camera_alt_outlined,
                                color: ColorManager.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: AppSize.s40),
                      CustomFormField(
                        textEditingcontroller: cubit.nameController,
                        label: AppStrings.name,
                        keyboardType: TextInputType.name,
                        errorLabel: cubit.nameErrorMessage,
                        onChanged: (value) {
                          cubit.isNameValid();
                        },
                        icon: Icons.person_outline_rounded,
                      ),
                      SizedBox(height: AppSize.s20),
                      CustomFormField(
                        textEditingcontroller: cubit.familyNameController,
                        label: AppStrings.familyName,
                        keyboardType: TextInputType.name,
                        errorLabel: cubit.familyNameErrorMessage,
                        onChanged: (value) {
                          cubit.isFamilyNameValid();
                        },
                        icon: Icons.person_outline_rounded,
                      ),
                      SizedBox(height: AppSize.s20),
                      CustomFormField(
                        textEditingcontroller: cubit.phoneNumberController,
                        label: AppStrings.phoneNumber,
                        keyboardType: TextInputType.name,
                        errorLabel: cubit.phoneNumberErrorMessage,
                        onChanged: (value) {
                          cubit.isPhoneNumberValid();
                        },
                        icon: Icons.phone_outlined,
                      ),
                      SizedBox(height: AppSize.s20),
                      CustomPasswordFormField(
                        textEditingcontroller: cubit.passwordController,
                        label: AppStrings.password,
                        errorLabel: cubit.passwordErrorMessage,
                        keyboardType: TextInputType.visiblePassword,
                        onChanged: (value) {
                          cubit.isPasswordValid();
                        },
                        onVisibleChanged: () {
                          cubit.changePasswordVisibility();
                        },
                        isPasswordVisible: cubit.isPasswordVisible,
                      ),
                      SizedBox(height: AppSize.s20),
                      CustomDropDown(
                        wilaya: cubit.wilaya,
                        onChanged: (value) {
                          cubit.pickWilaya(value);
                        },
                      ),
                      SizedBox(height: AppSize.s10),
                      Stack(
                        alignment: Alignment.topLeft,
                        children: [
                          Column(
                            children: [
                              SizedBox(height: AppSize.s10),
                              Container(
                                width: 350,
                                height: 55,
                                decoration: BoxDecoration(
                                  color: ColorManager.lightGrey,
                                  borderRadius: BorderRadius.circular(AppSize.s10),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.only(left: AppPadding.p20),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        cubit.selectedDate.toString().substring(0, 10),
                                        style: getMeduimStyle(color: ColorManager.dark),
                                      ),
                                      TextButton(
                                        onPressed: () async {
                                          await cubit.pickDate(context);
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: ColorManager.yellow,
                                            borderRadius: BorderRadius.circular(AppSize.s10),
                                          ),
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: AppPadding.p8, vertical: AppPadding.p2),
                                            child: Text(
                                              AppStrings.pick,
                                              style: getMeduimStyle(color: ColorManager.white),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: AppSize.s20),
                            child: Text(
                              AppStrings.birthday,
                              style: getSmallLightStyle(color: ColorManager.dark.withOpacity(0.5)),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: AppSize.s20),
                      CustomLargeButton(
                        label: AppStrings.createAnAccount,
                        onPressed: () {},
                      ),
                      SizedBox(height: AppSize.s20),
                      SizedBox(
                        width: AppSize.s350,
                        child: RichText(
                          text: TextSpan(
                            style: getSmallLightStyle(color: ColorManager.darkGrey),
                            children: [
                              const TextSpan(
                                text: 'By signing up. you agree to the ',
                              ),
                              TextSpan(
                                text: 'Terms of service',
                                style: TextStyle(color: ColorManager.green), // Change color here
                              ),
                              const TextSpan(
                                text: ' and ',
                              ),
                              TextSpan(
                                text: 'Privacy policy.',
                                style: TextStyle(color: ColorManager.green), // Change color here
                              ),
                            ],
                          ),
                        ),
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

class CustomDropDown extends StatelessWidget {
  const CustomDropDown({
    super.key,
    required this.wilaya,
    required this.onChanged,
  });

  final String? wilaya;
  final Function(String?)? onChanged;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 350,
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: AppPadding.p20, vertical: AppPadding.p16),
          border: InputBorder.none,
          filled: true,
          fillColor: ColorManager.lightGrey,
          alignLabelWithHint: true,
          label: Text(
            AppStrings.wilaya,
            style: getSmallLightStyle(color: ColorManager.dark.withOpacity(0.5)).copyWith(fontSize: 20),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppSize.s10),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppSize.s10),
            borderSide: BorderSide.none,
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppSize.s10),
            borderSide: BorderSide.none,
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppSize.s10),
            borderSide: BorderSide.none,
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppSize.s10),
            borderSide: BorderSide.none,
          ),
        ),
        value: wilaya,
        style: getMeduimStyle(color: ColorManager.dark),
        dropdownColor: ColorManager.white,
        items: const [
          DropdownMenuItem<String>(
            value: 'khenchela',
            child: Text('khenchela'),
          ),
          DropdownMenuItem<String>(
            value: 'batna',
            child: Text('batna'),
          ),
          DropdownMenuItem<String>(
            value: 'oran',
            child: Text('oran'),
          ),
        ],
        onChanged: onChanged,
      ),
    );
  }
}
