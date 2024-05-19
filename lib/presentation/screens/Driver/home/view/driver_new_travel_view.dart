import 'package:carpool/app/localizations.dart';
import 'package:carpool/presentation/components/appsize.dart';
import 'package:carpool/presentation/components/assets_manager.dart';
import 'package:carpool/presentation/components/color_manager.dart';
import 'package:carpool/presentation/components/strings_manager.dart';
import 'package:carpool/presentation/components/styles_manager.dart';
import 'package:carpool/presentation/components/widgets.dart';
import 'package:carpool/presentation/screens/Driver/home/cubit/driver_home_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:timeline_tile/timeline_tile.dart';

class DriverHomeView extends StatelessWidget {
  const DriverHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        bottomOpacity: 0,
        scrolledUnderElevation: 0,
        title: Text(
          AppStrings.newTravel.tr(context),
          style: getRegularStyle(color: ColorManager.dark),
        ),
      ),
      body: BlocConsumer<DriverHomeCubit, DriverHomeState>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = DriverHomeCubit.get(context);
          return Padding(
            padding: EdgeInsets.all(AppSize.s18).copyWith(bottom: 0),
            child: SingleChildScrollView(
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: kToolbarHeight * 2),
                    TimelineTile(
                      alignment: TimelineAlign.manual,
                      lineXY: 0.27.sp,
                      isFirst: true,
                      indicatorStyle: IndicatorStyle(
                        height: 25,
                        width: 25,
                        color: ColorManager.yellow,
                        padding: EdgeInsets.symmetric(horizontal: AppPadding.p10),
                        iconStyle: IconStyle(
                          color: Colors.white,
                          iconData: Icons.home,
                          fontSize: 20,
                        ),
                      ),
                      startChild: IconButton(
                        onPressed: () {
                          cubit.isItFrom = true;
                          cubit.pickTime(context);
                        },
                        icon: cubit.pickedFromTime != null
                            ? Text(
                                "${cubit.pickedFromTime}",
                                style: getMeduimStyle(color: ColorManager.yellow),
                              )
                            : Icon(
                                Icons.watch_later_outlined,
                                color: ColorManager.yellow,
                              ),
                      ),
                      endChild: InkWell(
                        onTap: () {
                          cubit.isItFrom = true;
                          customBottomSheet(context, cubit);
                        },
                        child: Text(
                          cubit.pickedFromLocation != null
                              ? cubit.pickedFromLocation!.address.toString()
                              : AppStrings.from.tr(context),
                          style: getMeduimStyle(color: ColorManager.dark.withOpacity(0.75)),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: AppSize.s55,
                      child: TimelineTile(
                        alignment: TimelineAlign.manual,
                        lineXY: 0.27.sp,
                        hasIndicator: false,
                      ),
                    ),
                    TimelineTile(
                      alignment: TimelineAlign.manual,
                      lineXY: 0.27.sp,
                      isLast: true,
                      indicatorStyle: IndicatorStyle(
                        height: 25,
                        width: 25,
                        color: ColorManager.yellow,
                        padding: EdgeInsets.symmetric(horizontal: AppPadding.p10),
                        iconStyle: IconStyle(
                          color: Colors.white,
                          iconData: Icons.location_on,
                          fontSize: 20,
                        ),
                      ),
                      startChild: IconButton(
                        onPressed: () {
                          cubit.isItFrom = false;
                          cubit.pickTime(context);
                        },
                        icon: cubit.pickedtoTime != null
                            ? Text(
                                "${cubit.pickedtoTime}",
                                style: getMeduimStyle(color: ColorManager.yellow),
                              )
                            : Icon(
                                Icons.watch_later_outlined,
                                color: ColorManager.yellow,
                              ),
                      ),
                      endChild: InkWell(
                        onTap: () {
                          cubit.isItFrom = false;
                          customBottomSheet(context, cubit);
                        },
                        child: Text(
                          cubit.pickedToLocation != null
                              ? cubit.pickedToLocation!.address.toString()
                              : AppStrings.to.tr(context),
                          style: getMeduimStyle(color: ColorManager.dark.withOpacity(0.75)),
                        ),
                      ),
                    ),
                    separator(),
                    Row(
                      children: [
                        Text(
                          AppStrings.numberOfSeats.tr(context),
                          style: getMeduimStyle(color: ColorManager.dark),
                        ),
                        Text(
                          cubit.numberOfSeats.toString(),
                          style: getMeduimStyle(color: ColorManager.dark),
                        ),
                        const Spacer(),
                        IconButton(
                          onPressed: () {
                            pickNumberOfPlaces(context, cubit);
                          },
                          icon: Icon(
                            Icons.change_circle_outlined,
                            color: ColorManager.yellow,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          AppStrings.placePrice.tr(context),
                          style: getMeduimStyle(color: ColorManager.dark),
                        ),
                        Text(
                          '${cubit.placePrice}DA',
                          style: getMeduimStyle(color: ColorManager.dark),
                        ),
                        const Spacer(),
                        IconButton(
                          onPressed: () {
                            pickPriceOfPlace(context, cubit);
                          },
                          icon: Icon(
                            Icons.change_circle_outlined,
                            color: ColorManager.yellow,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          AppStrings.date.tr(context),
                          style: getMeduimStyle(color: ColorManager.dark),
                        ),
                        Text(
                          cubit.selectedDate.toString().substring(0, 10),
                          style: getMeduimStyle(color: ColorManager.dark),
                        ),
                        const Spacer(),
                        IconButton(
                          onPressed: () {
                            cubit.pickDate(context);
                          },
                          icon: Icon(
                            Icons.change_circle_outlined,
                            color: ColorManager.yellow,
                          ),
                        ),
                      ],
                    ),
                    separator(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          AppStrings.baggageAllowed2.tr(context),
                          style: getMeduimStyle(color: ColorManager.dark),
                        ),
                        CupertinoSlidingSegmentedControl(
                          onValueChanged: (value) {
                            cubit.changeBaggaeAllowed(value);
                          },
                          children: {
                            1: Padding(
                              padding: EdgeInsets.all(AppPadding.p10),
                              child: Text(
                                'S',
                                style: getMeduimStyle(color: ColorManager.dark),
                              ),
                            ),
                            2: Text(
                              'M',
                              style: getMeduimStyle(color: ColorManager.dark),
                            ),
                            3: Text(
                              'L',
                              style: getMeduimStyle(color: ColorManager.dark),
                            ),
                          },
                          groupValue: cubit.numOfBaggageSizeAllowed,
                          backgroundColor: ColorManager.lightGrey,
                          thumbColor: ColorManager.white,
                        ),
                      ],
                    ),
                    SizedBox(height: AppSize.s10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          AppStrings.petsAllowed2.tr(context),
                          style: getMeduimStyle(color: ColorManager.dark),
                        ),
                        CupertinoSlidingSegmentedControl(
                          onValueChanged: (value) {
                            cubit.changePetsAllowed(value);
                          },
                          children: {
                            1: Padding(
                              padding: EdgeInsets.all(AppPadding.p10),
                              child: Text(
                                AppStrings.no.tr(context),
                                style: getMeduimStyle(color: ColorManager.dark),
                              ),
                            ),
                            2: Text(
                              AppStrings.yes.tr(context),
                              style: getMeduimStyle(color: ColorManager.dark),
                            ),
                          },
                          groupValue: cubit.numOfPetsAllowed,
                          backgroundColor: ColorManager.lightGrey,
                          thumbColor: ColorManager.white,
                        ),
                      ],
                    ),
                    SizedBox(height: AppSize.s10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          AppStrings.smokingAllowed.tr(context),
                          style: getMeduimStyle(color: ColorManager.dark),
                        ),
                        CupertinoSlidingSegmentedControl(
                          onValueChanged: (value) {
                            cubit.changesmokingAllowed(value);
                          },
                          children: {
                            1: Padding(
                              padding: EdgeInsets.all(AppPadding.p10),
                              child: Text(
                                AppStrings.no.tr(context),
                                style: getMeduimStyle(color: ColorManager.dark),
                              ),
                            ),
                            2: Text(
                              AppStrings.yes.tr(context),
                              style: getMeduimStyle(color: ColorManager.dark),
                            ),
                          },
                          groupValue: cubit.numOfsmokingAllowed,
                          backgroundColor: ColorManager.lightGrey,
                          thumbColor: ColorManager.white,
                        ),
                      ],
                    ),
                    separator(),
                    CustomFormField(
                      textEditingcontroller: cubit.carNameController,
                      label: AppStrings.carName.tr(context),
                      keyboardType: TextInputType.name,
                      errorLabel: null,
                      onChanged: (value) {},
                      icon: null,
                    ),
                    SizedBox(height: AppSize.s20),
                    InkWell(
                      onTap: () async {
                        await cubit.pickImage();
                      },
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: ColorManager.lightGrey,
                          borderRadius: BorderRadius.circular(AppPadding.p10),
                        ),
                        child: cubit.image == null ? Image.asset(ImageAsset.dodgeCar) : Image.file(cubit.image!),
                      ),
                    ),
                    separator(),
                    state is DriverCreateTravelLoadingState
                        ? CircularProgressIndicator(
                            color: ColorManager.yellow,
                          )
                        : CustomLargeButton(
                            label: AppStrings.createTravel.tr(context),
                            onPressed: cubit.isEverythingValid
                                ? () {
                                    cubit.createTravel(context);
                                  }
                                : null,
                          ),
                    separator(),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Future<dynamic> pickPriceOfPlace(BuildContext context, DriverHomeCubit cubit) {
    return showModalBottomSheet(
        backgroundColor: ColorManager.white,
        useSafeArea: true,
        context: context,
        builder: (context) {
          return BlocConsumer<DriverHomeCubit, DriverHomeState>(
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
                        AppStrings.placePrice.tr(context),
                        style: getMeduimStyle(color: ColorManager.dark),
                      ),
                      SizedBox(height: AppSize.s20),
                      NumberPicker(
                        minValue: 200,
                        maxValue: 10000,
                        value: cubit.placePrice,
                        itemCount: 3,
                        textStyle: getMeduimStyle(color: ColorManager.darkGrey),
                        selectedTextStyle: getMeduimStyle(color: ColorManager.yellow),
                        step: 200,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(AppPadding.p12),
                          border: Border.all(color: ColorManager.darkGrey),
                        ),
                        axis: Axis.horizontal,
                        onChanged: (value) {
                          cubit.pickPrice(value);
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        });
  }

  Future<dynamic> pickNumberOfPlaces(BuildContext context, DriverHomeCubit cubit) {
    return showModalBottomSheet(
        backgroundColor: ColorManager.white,
        useSafeArea: true,
        context: context,
        builder: (context) {
          return BlocConsumer<DriverHomeCubit, DriverHomeState>(
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
                        AppStrings.numberOfSeats.tr(context),
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
                        groupValue: cubit.numberOfSeats,
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

  Future<dynamic> customBottomSheet(BuildContext context, DriverHomeCubit cubit) {
    return showModalBottomSheet(
        backgroundColor: ColorManager.white,
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return BlocConsumer<DriverHomeCubit, DriverHomeState>(
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
