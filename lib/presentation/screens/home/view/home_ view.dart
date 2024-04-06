import 'package:carpool/presentation/components/appsize.dart';
import 'package:carpool/presentation/components/assets_manager.dart';
import 'package:carpool/presentation/components/color_manager.dart';
import 'package:carpool/presentation/components/strings_manager.dart';
import 'package:carpool/presentation/components/styles_manager.dart';
import 'package:carpool/presentation/screens/home/cubit/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit(),
      child: BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = HomeCubit.get(context);
          return Scaffold(
            backgroundColor: ColorManager.white,
            body: Padding(
              padding: EdgeInsets.all(AppSize.s18),
              child: SingleChildScrollView(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: kToolbarHeight,
                      ),
                      SizedBox(
                        width: AppSize.s300,
                        child: Lottie.asset(LottieAsset.map),
                      ),
                      Text(
                        AppStrings.findARide,
                        style: getLargeStyle(color: ColorManager.dark),
                      ),
                      SizedBox(
                        height: AppSize.s60,
                      ),
                      Container(
                        width: AppSize.s350,
                        height: AppSize.s310,
                        decoration: BoxDecoration(
                          color: ColorManager.white,
                          borderRadius: BorderRadius.circular(AppSize.s10),
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 3,
                              blurStyle: BlurStyle.inner,
                              offset: const Offset(0, 0),
                              color: ColorManager.dark,
                            )
                          ],
                        ),
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.all(AppPadding.p20),
                              child: Column(
                                children: [
                                  ListTile(
                                    title: Text(
                                      AppStrings.from,
                                      style: getMeduimStyle(color: ColorManager.dark.withOpacity(0.75)),
                                    ),
                                    leading: Icon(
                                      Icons.location_on_outlined,
                                      size: AppSize.s30,
                                      color: ColorManager.darkGrey,
                                    ),
                                    contentPadding: EdgeInsets.zero,
                                    onTap: () {},
                                  ),
                                  Container(
                                    width: 320,
                                    height: 1,
                                    margin: EdgeInsets.only(bottom: AppPadding.p14),
                                    color: ColorManager.darkGrey.withOpacity(0.75),
                                  ),
                                  ListTile(
                                    title: Text(
                                      AppStrings.to,
                                      style: getMeduimStyle(color: ColorManager.dark.withOpacity(0.75)),
                                    ),
                                    leading: Icon(
                                      Icons.location_on_outlined,
                                      size: AppSize.s30,
                                      color: ColorManager.darkGrey,
                                    ),
                                    contentPadding: EdgeInsets.zero,
                                    onTap: () {},
                                  ),
                                  Container(
                                    width: 320,
                                    height: 1,
                                    color: ColorManager.darkGrey.withOpacity(0.75),
                                    margin: EdgeInsets.only(bottom: AppPadding.p14),
                                  ),
                                  Row(
                                    children: [
                                      Flexible(
                                        flex: 5,
                                        child: ListTile(
                                          title: Text(
                                            AppStrings.today,
                                            style: getMeduimStyle(color: ColorManager.dark.withOpacity(0.75)),
                                          ),
                                          leading: Icon(
                                            Icons.location_on_outlined,
                                            size: AppSize.s30,
                                            color: ColorManager.darkGrey,
                                          ),
                                          contentPadding: EdgeInsets.zero,
                                          onTap: () {},
                                        ),
                                      ),
                                      Flexible(
                                        flex: 1,
                                        child: Container(
                                          margin: EdgeInsets.only(right: AppPadding.p12),
                                          height: 40,
                                          width: 2,
                                          color: ColorManager.darkGrey.withOpacity(0.75),
                                        ),
                                      ),
                                      Flexible(
                                        flex: 1,
                                        child: ListTile(
                                          title: Text(
                                            '3',
                                            style: getMeduimStyle(color: ColorManager.dark.withOpacity(0.75)),
                                          ),
                                          leading: Icon(
                                            Icons.person_outline_sharp,
                                            size: AppSize.s30,
                                            color: ColorManager.darkGrey,
                                          ),
                                          contentPadding: EdgeInsets.zero,
                                          onTap: () {},
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: SizedBox(
                                width: AppSize.s350,
                                // height: double.infinity,
                                child: ElevatedButton(
                                  onPressed: () {},
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: ColorManager.yellow,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(AppPadding.p10),
                                        bottomRight: Radius.circular(AppPadding.p10),
                                      ),
                                    ),
                                  ),
                                  child: Text(
                                    AppStrings.search,
                                    style: getRegularStyle(color: ColorManager.white),
                                  ),
                                ),
                              ),
                            ),
                          ],
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
