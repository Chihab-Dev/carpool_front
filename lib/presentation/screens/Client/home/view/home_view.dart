import 'package:carpool/app/localizations.dart';
import 'package:carpool/presentation/components/appsize.dart';
import 'package:carpool/presentation/components/assets_manager.dart';
import 'package:carpool/presentation/components/color_manager.dart';
import 'package:carpool/presentation/components/strings_manager.dart';
import 'package:carpool/presentation/components/styles_manager.dart';
import 'package:carpool/presentation/screens/Client/home/cubit/home_cubit.dart';
import 'package:carpool/presentation/screens/Client/home/view/travels_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
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
                      AppStrings.findARide.tr(context),
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
                                    cubit.pickedFromLocation?.address.toString() ?? AppStrings.from.tr(context),
                                    style: getMeduimStyle(color: ColorManager.dark.withOpacity(0.75)),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  leading: Icon(
                                    Icons.location_on_outlined,
                                    size: AppSize.s30,
                                    color: ColorManager.darkGrey,
                                  ),
                                  contentPadding: EdgeInsets.zero,
                                  onTap: () {
                                    cubit.isItFromLocation = true;
                                    customBottomSheet(context, cubit);
                                  },
                                ),
                                Container(
                                  width: 320,
                                  height: 1,
                                  margin: EdgeInsets.only(bottom: AppPadding.p14),
                                  color: ColorManager.darkGrey.withOpacity(0.75),
                                ),
                                ListTile(
                                  title: Text(
                                    cubit.pickedToLocation?.address.toString() ?? AppStrings.to.tr(context),
                                    style: getMeduimStyle(color: ColorManager.dark.withOpacity(0.75)),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  leading: Icon(
                                    Icons.location_on_outlined,
                                    size: AppSize.s30,
                                    color: ColorManager.darkGrey,
                                  ),
                                  contentPadding: EdgeInsets.zero,
                                  onTap: () {
                                    cubit.isItFromLocation = false;

                                    customBottomSheet(context, cubit);
                                  },
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
                                          cubit.selectedDate.toString().substring(0, 10),
                                          style: getMeduimStyle(color: ColorManager.dark.withOpacity(0.75)),
                                        ),
                                        leading: Icon(
                                          Icons.date_range_outlined,
                                          size: AppSize.s30,
                                          color: ColorManager.darkGrey,
                                        ),
                                        contentPadding: EdgeInsets.zero,
                                        onTap: () {
                                          cubit.pickDate(context);
                                        },
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
                                          cubit.numberOfPlaces.toString(),
                                          style: getMeduimStyle(color: ColorManager.dark.withOpacity(0.75)),
                                        ),
                                        leading: Icon(
                                          Icons.person_outline_sharp,
                                          size: AppSize.s30,
                                          color: ColorManager.darkGrey,
                                        ),
                                        contentPadding: EdgeInsets.zero,
                                        onTap: () {
                                          pickNumberOfPlaces(context, cubit);
                                        },
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
                                onPressed: cubit.pickedFromLocation != null && cubit.pickedToLocation != null
                                    ? () {
                                        cubit.getTravel(context);
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => const TravelsView(),
                                          ),
                                        );
                                      }
                                    : null,
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
                                  AppStrings.search.tr(context),
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
    );
  }

  Future<dynamic> pickNumberOfPlaces(BuildContext context, HomeCubit cubit) {
    return showModalBottomSheet(
        backgroundColor: ColorManager.white,
        useSafeArea: true,
        context: context,
        builder: (context) {
          return BlocConsumer<HomeCubit, HomeState>(
            listener: (context, state) {},
            builder: (context, state) {
              return Container(
                height: AppSize.s250,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: ColorManager.white,
                  borderRadius: BorderRadius.circular(AppSize.s10),
                ),
                child: Padding(
                  padding: EdgeInsets.all(AppPadding.p18),
                  child: Column(
                    children: [
                      Text(
                        AppStrings.pickNumberOfPlaces.tr(context),
                        style: getMeduimStyle(color: ColorManager.dark),
                      ),
                      SizedBox(height: AppSize.s20),
                      CupertinoSlidingSegmentedControl(
                        onValueChanged: (value) {
                          cubit.pickNumberOfPlaces(value);
                        },
                        children: {
                          1: Padding(
                            padding: EdgeInsets.all(AppPadding.p20),
                            child: Text(
                              '1',
                              style: getLargeStyle(color: ColorManager.dark),
                            ),
                          ),
                          2: Text(
                            '2',
                            style: getLargeStyle(color: ColorManager.dark),
                          ),
                          3: Text(
                            '3',
                            style: getLargeStyle(color: ColorManager.dark),
                          ),
                          4: Text(
                            '4',
                            style: getLargeStyle(color: ColorManager.dark),
                          ),
                          5: Text(
                            '5',
                            style: getLargeStyle(color: ColorManager.dark),
                          ),
                        },
                        groupValue: cubit.numberOfPlaces,
                        backgroundColor: ColorManager.lightGrey,
                        thumbColor: ColorManager.white,
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        });
  }

  Future<dynamic> customBottomSheet(BuildContext context, HomeCubit cubit) {
    return showModalBottomSheet(
        backgroundColor: ColorManager.white,
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return BlocConsumer<HomeCubit, HomeState>(
            listener: (context, state) {},
            builder: (context, state) {
              return Padding(
                padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                child: Container(
                  height: AppSize.s400,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: ColorManager.white,
                    borderRadius: BorderRadius.circular(AppSize.s10),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(AppPadding.p18),
                    child: Column(
                      children: [
                        TextField(
                          controller: cubit.locationController,
                          autocorrect: false,
                          keyboardType: TextInputType.text,
                          onChanged: (value) {
                            cubit.searchForLocation();
                          },
                          style: getMeduimStyle(color: ColorManager.dark.withOpacity(0.75)),
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(horizontal: AppPadding.p8, vertical: AppPadding.p6),
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                            label: Text(
                              AppStrings.location.tr(context),
                              style: getSmallLightStyle(color: ColorManager.dark.withOpacity(0.5)),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: ColorManager.yellow),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: ColorManager.yellow),
                            ),
                          ),
                        ),
                        Expanded(
                          child: ListView.builder(
                            itemCount: cubit.listSource.length,
                            itemBuilder: (context, index) {
                              var item = cubit.listSource[index];
                              return Padding(
                                padding: EdgeInsets.symmetric(vertical: AppPadding.p8),
                                child: InkWell(
                                  onTap: () {
                                    cubit.chooseLocation(index, context);
                                  },
                                  child: Text(
                                    item.address.toString(),
                                    style: getMeduimStyle(color: ColorManager.dark.withOpacity(0.75)),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        });
  }
}
