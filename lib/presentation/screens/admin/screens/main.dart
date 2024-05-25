import 'package:carpool/app/localizations.dart';
import 'package:carpool/presentation/components/appsize.dart';
import 'package:carpool/presentation/components/assets_manager.dart';
import 'package:carpool/presentation/components/color_manager.dart';
import 'package:carpool/presentation/components/strings_manager.dart';
import 'package:carpool/presentation/components/styles_manager.dart';
import 'package:carpool/presentation/components/widgets.dart';
import 'package:carpool/presentation/screens/admin/cubit/cubit.dart';
import 'package:carpool/presentation/screens/admin/cubit/states.dart';
import 'package:carpool/presentation/screens/admin/screens/clients.dart';
import 'package:carpool/presentation/screens/admin/screens/drivers.dart';
import 'package:carpool/presentation/screens/admin/screens/travels.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:lottie/lottie.dart';

class AdminMainView extends StatelessWidget {
  const AdminMainView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AdminCubit, AdminStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = AdminCubit.get(context);
        return Scaffold(
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: AppPadding.p18),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Lottie.asset(LottieAsset.admin),
                  SizedBox(height: AppSize.s70),
                  CustomLargeButton(
                    label: AppStrings.drivers.tr(context),
                    onPressed: () {
                      cubit.getAllDrivers(context);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const AdminDriversView(),
                          ));
                    },
                  ),
                  SizedBox(height: AppSize.s18),
                  CustomLargeButton(
                    label: AppStrings.travels.tr(context),
                    onPressed: () {
                      cubit.getAllTravels(context);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const AdminTravelsView(),
                          ));
                    },
                  ),
                  SizedBox(height: AppSize.s18),
                  CustomLargeButton(
                    label: AppStrings.clients.tr(context),
                    onPressed: () {
                      cubit.getAllClients(context);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const AdminClientsView(),
                          ));
                    },
                  ),
                  SizedBox(height: AppSize.s18),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        AppStrings.appLanguage.tr(context),
                        style: getMeduimStyle(color: ColorManager.dark),
                      ),
                      CupertinoSlidingSegmentedControl(
                        onValueChanged: (value) async {
                          await cubit.chnageAppLanauge(value);
                          Phoenix.rebirth(context);
                        },
                        children: {
                          1: Padding(
                            padding: EdgeInsets.all(AppPadding.p10),
                            child: Text(
                              'en',
                              style: getMeduimStyle(color: ColorManager.dark),
                            ),
                          ),
                          2: Text(
                            'ar',
                            style: getMeduimStyle(color: ColorManager.dark),
                          ),
                        },
                        groupValue: cubit.numAppLanguage,
                        backgroundColor: ColorManager.lightGrey,
                        thumbColor: ColorManager.white,
                      ),
                    ],
                  ),
                  SizedBox(height: AppSize.s18),
                  CustomLargeButton(
                    label: AppStrings.logout.tr(context),
                    color: Colors.red,
                    onPressed: () {
                      logout(context);
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
