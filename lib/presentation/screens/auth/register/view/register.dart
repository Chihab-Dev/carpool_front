import 'package:carpool/app/localizations.dart';
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
  const RegisterView(this.isClient, {super.key});
  final bool isClient;

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
                AppStrings.register.tr(context),
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
                        label: AppStrings.name.tr(context),
                        keyboardType: TextInputType.name,
                        errorLabel: cubit.nameErrorMessage,
                        onChanged: (value) {
                          cubit.isNameValid(context);
                        },
                        icon: Icons.person_outline_rounded,
                      ),
                      SizedBox(height: AppSize.s20),
                      CustomFormField(
                        textEditingcontroller: cubit.familyNameController,
                        label: AppStrings.familyName.tr(context),
                        keyboardType: TextInputType.name,
                        errorLabel: cubit.familyNameErrorMessage,
                        onChanged: (value) {
                          cubit.isFamilyNameValid(context);
                        },
                        icon: Icons.person_outline_rounded,
                      ),
                      SizedBox(height: AppSize.s20),
                      CustomFormField(
                        textEditingcontroller: cubit.phoneNumberController,
                        label: AppStrings.phoneNumber.tr(context),
                        keyboardType: TextInputType.name,
                        errorLabel: cubit.phoneNumberErrorMessage,
                        onChanged: (value) {
                          cubit.isPhoneNumberValid(context);
                        },
                        icon: Icons.phone_outlined,
                      ),
                      SizedBox(height: AppSize.s20),
                      CustomPasswordFormField(
                        textEditingcontroller: cubit.passwordController,
                        label: AppStrings.password.tr(context),
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
                        alignment:
                            AppStrings.birthday.tr(context) == 'Birthday' ? Alignment.topLeft : Alignment.topRight,
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
                                  padding: EdgeInsets.symmetric(horizontal: AppPadding.p20),
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
                                              AppStrings.pick.tr(context),
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
                            padding: EdgeInsets.symmetric(horizontal: AppSize.s20),
                            child: Text(
                              AppStrings.birthday.tr(context),
                              style: getSmallLightStyle(color: ColorManager.dark.withOpacity(0.5)),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: AppSize.s20),
                      state is RegisterLoadingState
                          ? CircularProgressIndicator(
                              color: ColorManager.yellow,
                            )
                          : CustomLargeButton(
                              label: AppStrings.createAnAccount.tr(context),
                              onPressed: cubit.isEverythingValid()
                                  ? () {
                                      cubit.register(context, widget.isClient);
                                    }
                                  : null,
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
            AppStrings.wilaya.tr(context),
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
        items: wilayaDropdownItems,
        onChanged: onChanged,
      ),
    );
  }
}

List<DropdownMenuItem<String>>? wilayaDropdownItems = [
  const DropdownMenuItem<String>(
    value: 'Adrar',
    child: Text('1 - Adrar'),
  ),
  const DropdownMenuItem<String>(
    value: 'Chlef',
    child: Text('2 - Chlef'),
  ),
  const DropdownMenuItem<String>(
    value: 'Laghouat',
    child: Text('3 - Laghouat'),
  ),
  const DropdownMenuItem<String>(
    value: 'Oum El Bouaghi',
    child: Text('4 - Oum El Bouaghi'),
  ),
  const DropdownMenuItem<String>(
    value: 'Batna',
    child: Text('5 - Batna'),
  ),
  const DropdownMenuItem<String>(
    value: 'Béjaïa',
    child: Text('6 - Béjaïa'),
  ),
  const DropdownMenuItem<String>(
    value: 'Biskra',
    child: Text('7 - Biskra'),
  ),
  const DropdownMenuItem<String>(
    value: 'Béchar',
    child: Text('8 - Béchar'),
  ),
  const DropdownMenuItem<String>(
    value: 'Blida',
    child: Text('9 - Blida'),
  ),
  const DropdownMenuItem<String>(
    value: 'Bouira',
    child: Text('10 - Bouira'),
  ),
  const DropdownMenuItem<String>(
    value: 'Tamanrasset',
    child: Text('11 - Tamanrasset'),
  ),
  const DropdownMenuItem<String>(
    value: 'Tébessa',
    child: Text('12 - Tébessa'),
  ),
  const DropdownMenuItem<String>(
    value: 'Tlemcen',
    child: Text('13 - Tlemcen'),
  ),
  const DropdownMenuItem<String>(
    value: 'Tiaret',
    child: Text('14 - Tiaret'),
  ),
  const DropdownMenuItem<String>(
    value: 'Tizi Ouzou',
    child: Text('15 - Tizi Ouzou'),
  ),
  const DropdownMenuItem<String>(
    value: 'Alger',
    child: Text('16 - Alger'),
  ),
  const DropdownMenuItem<String>(
    value: 'Djelfa',
    child: Text('17 - Djelfa'),
  ),
  const DropdownMenuItem<String>(
    value: 'Jijel',
    child: Text('18 - Jijel'),
  ),
  const DropdownMenuItem<String>(
    value: 'Sétif',
    child: Text('19 - Sétif'),
  ),
  const DropdownMenuItem<String>(
    value: 'Saïda',
    child: Text('20 - Saïda'),
  ),
  const DropdownMenuItem<String>(
    value: 'Skikda',
    child: Text('21 - Skikda'),
  ),
  const DropdownMenuItem<String>(
    value: 'Sidi Bel Abbès',
    child: Text('22 - Sidi Bel Abbès'),
  ),
  const DropdownMenuItem<String>(
    value: 'Annaba',
    child: Text('23 - Annaba'),
  ),
  const DropdownMenuItem<String>(
    value: 'Guelma',
    child: Text('24 - Guelma'),
  ),
  const DropdownMenuItem<String>(
    value: 'Constantine',
    child: Text('25 - Constantine'),
  ),
  const DropdownMenuItem<String>(
    value: 'Médéa',
    child: Text('26 - Médéa'),
  ),
  const DropdownMenuItem<String>(
    value: 'Mostaganem',
    child: Text('27 - Mostaganem'),
  ),
  const DropdownMenuItem<String>(
    value: 'M\'Sila',
    child: Text('28 - M\'Sila'),
  ),
  const DropdownMenuItem<String>(
    value: 'Mascara',
    child: Text('29 - Mascara'),
  ),
  const DropdownMenuItem<String>(
    value: 'Ouargla',
    child: Text('30 - Ouargla'),
  ),
  const DropdownMenuItem<String>(
    value: 'Oran',
    child: Text('31 - Oran'),
  ),
  const DropdownMenuItem<String>(
    value: 'El Bayadh',
    child: Text('32 - El Bayadh'),
  ),
  const DropdownMenuItem<String>(
    value: 'Illizi',
    child: Text('33 - Illizi'),
  ),
  const DropdownMenuItem<String>(
    value: 'Bordj Bou Arréridj',
    child: Text('34 - Bordj Bou Arréridj'),
  ),
  const DropdownMenuItem<String>(
    value: 'Boumerdès',
    child: Text('35 - Boumerdès'),
  ),
  const DropdownMenuItem<String>(
    value: 'El Tarf',
    child: Text('36 - El Tarf'),
  ),
  const DropdownMenuItem<String>(
    value: 'Tindouf',
    child: Text('37 - Tindouf'),
  ),
  const DropdownMenuItem<String>(
    value: 'Tissemsilt',
    child: Text('38 - Tissemsilt'),
  ),
  const DropdownMenuItem<String>(
    value: 'El Oued',
    child: Text('39 - El Oued'),
  ),
  const DropdownMenuItem<String>(
    value: 'Khenchela',
    child: Text('40 - Khenchela'),
  ),
  const DropdownMenuItem<String>(
    value: 'Souk Ahras',
    child: Text('41 - Souk Ahras'),
  ),
  const DropdownMenuItem<String>(
    value: 'Tipaza',
    child: Text('42 - Tipaza'),
  ),
  const DropdownMenuItem<String>(
    value: 'Mila',
    child: Text('43 - Mila'),
  ),
  const DropdownMenuItem<String>(
    value: 'Aïn Defla',
    child: Text('44 - Aïn Defla'),
  ),
  const DropdownMenuItem<String>(
    value: 'Naâma',
    child: Text('45 - Naâma'),
  ),
  const DropdownMenuItem<String>(
    value: 'Aïn Témouchent',
    child: Text('46 - Aïn Témouchent'),
  ),
  const DropdownMenuItem<String>(
    value: 'Ghardaïa',
    child: Text('47 - Ghardaïa'),
  ),
  const DropdownMenuItem<String>(
    value: 'Relizane',
    child: Text('48 - Relizane'),
  ),
];
