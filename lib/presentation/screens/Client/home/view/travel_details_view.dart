import 'package:carpool/app/localizations.dart';
import 'package:carpool/data/models/models.dart';
import 'package:carpool/presentation/components/appsize.dart';
import 'package:carpool/presentation/components/assets_manager.dart';
import 'package:carpool/presentation/components/color_manager.dart';
import 'package:carpool/presentation/components/strings_manager.dart';
import 'package:carpool/presentation/components/styles_manager.dart';
import 'package:carpool/presentation/components/widgets.dart';
import 'package:carpool/presentation/screens/Client/home/cubit/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:timeline_tile/timeline_tile.dart';
import 'package:url_launcher/url_launcher.dart';

class TravelDetailsView extends StatelessWidget {
  const TravelDetailsView(this.travel, {super.key});

  final TravelModel travel;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = HomeCubit.get(context);
        return Scaffold(
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            bottomOpacity: 0,
            scrolledUnderElevation: 0,
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: AppSize.s18),
            child: SingleChildScrollView(
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: kToolbarHeight * 2),
                    Text(
                      travel.dateOfDeparture,
                      style: getMeduimStyle(color: ColorManager.dark),
                    ),
                    SizedBox(height: AppSize.s20),
                    TimelineTile(
                      alignment: TimelineAlign.manual,
                      lineXY: 0.25.sp,
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
                      startChild: Text(travel.timeOfDeparture, style: getMeduimStyle(color: ColorManager.dark)),
                      endChild: Text(travel.placeOfDeparture, style: getMeduimStyle(color: ColorManager.dark)),
                    ),
                    SizedBox(
                      height: AppSize.s70,
                      child: TimelineTile(
                        alignment: TimelineAlign.manual,
                        lineXY: 0.25.sp,
                        hasIndicator: false,
                      ),
                    ),
                    TimelineTile(
                      alignment: TimelineAlign.manual,
                      lineXY: 0.25.sp,
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
                      startChild: Text(travel.timeOfArrival, style: getMeduimStyle(color: ColorManager.dark)),
                      endChild: Text(travel.placeOfArrival, style: getMeduimStyle(color: ColorManager.dark)),
                    ),
                    separator(),
                    Row(
                      children: [
                        Icon(
                          Icons.chair_outlined,
                          size: AppSize.s30,
                          // color: ColorManager.white,
                        ),
                        SizedBox(width: AppSize.s5),
                        travel.numberOfPlaces > 1
                            ? Icon(
                                Icons.chair_outlined,
                                size: AppSize.s30,
                              )
                            : const SizedBox(),
                        SizedBox(width: AppSize.s5),
                        travel.numberOfPlaces > 2
                            ? Icon(
                                Icons.chair_outlined,
                                size: AppSize.s30,
                              )
                            : const SizedBox(),
                        const Spacer(),
                        Text(
                          AppStrings.forOnePerson.tr(context),
                          style: getSmallRegularStyle(color: ColorManager.darkGrey),
                        ),
                        Text(
                          travel.placePrice.toString(),
                          style: getMeduimStyle(color: ColorManager.dark),
                        ),
                      ],
                    ),
                    separator(),
                    Row(
                      children: [
                        CircleAvatar(
                          radius: AppSize.s30,
                          backgroundColor: ColorManager.lightGrey,
                          backgroundImage: const AssetImage(ImageAsset.profilePicture),
                        ),
                        SizedBox(width: AppSize.s12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('${travel.driver.name} ${travel.driver.familyname}',
                                style: getMeduimStyle(color: ColorManager.dark)),
                            Row(
                              children: [
                                Icon(
                                  Icons.star_purple500_sharp,
                                  size: AppSize.s18,
                                  color: ColorManager.yellow,
                                ),
                                SizedBox(width: AppSize.s5),
                                Text(
                                  travel.driver.feedbackes.length.toString(),
                                  style: getMeduimStyle(color: ColorManager.dark),
                                ),
                              ],
                            )
                          ],
                        ),
                        const Spacer(),
                        IconButton(
                          onPressed: () async {
                            final call = Uri.parse('tel:+213 ${travel.driver.phoneNumber}');
                            if (await canLaunchUrl(call)) {
                              launchUrl(call);
                            } else {
                              throw 'Could not launch $call';
                            }
                          },
                          icon: Icon(
                            FontAwesomeIcons.phoneFlip,
                            size: AppSize.s25,
                            color: ColorManager.green,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: AppSize.s25),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: AppPadding.p10),
                      child: Row(
                        children: [
                          Icon(
                            FontAwesomeIcons.cartFlatbedSuitcase,
                            size: AppSize.s25,
                            color: ColorManager.darkGrey,
                          ),
                          SizedBox(width: AppSize.s25),
                          Text(
                            travel.baggage == "S"
                                ? AppStrings.baggageSAllowed
                                : travel.baggage == "M"
                                    ? AppStrings.baggageMAllowed
                                    : travel.baggage == "L"
                                        ? AppStrings.baggageLAllowed
                                        : AppStrings.baggageSAllowed,
                            style: getSmallRegularStyle(color: ColorManager.dark),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: AppSize.s16),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: AppPadding.p10),
                      child: Row(
                        children: [
                          Stack(
                            children: [
                              Icon(
                                FontAwesomeIcons.cat,
                                size: AppSize.s25,
                                color: ColorManager.darkGrey,
                              ),
                              travel.allowPets
                                  ? const SizedBox()
                                  : Icon(
                                      FontAwesomeIcons.slash,
                                      size: AppSize.s25,
                                      color: Colors.red,
                                    ),
                            ],
                          ),
                          SizedBox(width: AppSize.s25),
                          Text(
                            travel.allowPets ? AppStrings.allowPets : AppStrings.petsNotAllowed.tr(context),
                            style: getSmallRegularStyle(color: ColorManager.dark),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: AppSize.s16),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: AppPadding.p10),
                      child: Row(
                        children: [
                          Stack(
                            children: [
                              Icon(
                                FontAwesomeIcons.smoking,
                                size: AppSize.s25,
                                color: ColorManager.darkGrey,
                              ),
                              travel.allowSmoking
                                  ? const SizedBox()
                                  : Icon(
                                      FontAwesomeIcons.slash,
                                      size: AppSize.s25,
                                      color: Colors.red,
                                    ),
                            ],
                          ),
                          SizedBox(width: AppSize.s25),
                          Text(
                            travel.allowSmoking ? AppStrings.smokingAllowed.tr(context) : AppStrings.dontAllowSmoking,
                            style: getSmallRegularStyle(color: ColorManager.dark),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: AppSize.s16),
                    separator(),
                    Text(
                      travel.carName,
                      style: getMeduimStyle(color: ColorManager.dark),
                    ),
                    SizedBox(height: AppSize.s16),
                    Container(
                      width: double.infinity,
                      // height: AppSize.s70,
                      decoration: BoxDecoration(
                        color: ColorManager.lightGrey,
                        borderRadius: BorderRadius.circular(AppPadding.p10),
                      ),
                      child: Image.asset(ImageAsset.leon),
                    ),
                    separator(),
                  ],
                ),
              ),
            ),
          ),
          bottomNavigationBar: Container(
            height: AppSize.s100,
            width: double.infinity,
            decoration: BoxDecoration(
              color: ColorManager.white,
              boxShadow: [
                BoxShadow(
                  blurStyle: BlurStyle.inner,
                  blurRadius: 3,
                  offset: const Offset(0, 0),
                  color: ColorManager.darkGrey,
                )
              ],
            ),
            child: state is HomeRequestToBookLoadingState
                ? Center(
                    child: CircularProgressIndicator(
                      color: ColorManager.yellow,
                    ),
                  )
                : Center(
                    child: CustomLargeButton(
                      label: AppStrings.requestToBook,
                      onPressed: () {
                        cubit.requestToBook(travel.travelId, context);
                      },
                    ),
                  ),
          ),
        );
      },
    );
  }
}