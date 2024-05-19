import 'package:carpool/app/localizations.dart';
import 'package:carpool/data/models/models.dart';
import 'package:carpool/presentation/components/appsize.dart';
import 'package:carpool/presentation/components/assets_manager.dart';
import 'package:carpool/presentation/components/color_manager.dart';
import 'package:carpool/presentation/components/strings_manager.dart';
import 'package:carpool/presentation/components/styles_manager.dart';
import 'package:carpool/presentation/components/widgets.dart';
import 'package:carpool/presentation/screens/Driver/home/cubit/driver_home_cubit.dart';
import 'package:carpool/presentation/screens/Driver/home/view/driver_feedback.dart';
import 'package:carpool/presentation/screens/Driver/update%20travel/view/update_travel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:timeline_tile/timeline_tile.dart';
import 'package:url_launcher/url_launcher.dart';

class DriverMyTravelView extends StatefulWidget {
  const DriverMyTravelView({super.key});

  @override
  State<DriverMyTravelView> createState() => _DriverMyTravelViewState();
}

class _DriverMyTravelViewState extends State<DriverMyTravelView> {
  @override
  void initState() {
    if (DriverHomeCubit.get(context).myTravel == null) {
      DriverHomeCubit.get(context).getMyTravel(context);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DriverHomeCubit, DriverHomeState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = DriverHomeCubit.get(context);
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
            child: state is DriverGetTravelByIdLoadingState
                ? Center(
                    child: CircularProgressIndicator(
                    color: ColorManager.yellow,
                  ))
                :

                // cubit.myTravel == null
                //     ? const Center(child: Text('No travel'))
                //     :
                SingleChildScrollView(
                    child: Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: kToolbarHeight * 2),
                          Text(
                            cubit.myTravelTest.dateOfDeparture,
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
                            startChild: cubit.myTravelTest.timeOfDeparture != null
                                ? Text((cubit.myTravelTest.timeOfDeparture),
                                    style: getMeduimStyle(color: ColorManager.dark))
                                : Text("00:00", style: getMeduimStyle(color: ColorManager.dark)),
                            endChild: Text(cubit.myTravelTest.placeOfDeparture,
                                style: getMeduimStyle(color: ColorManager.dark)),
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
                            startChild: cubit.myTravelTest.timeOfArrival != null
                                ? Text(cubit.myTravelTest.timeOfArrival,
                                    style: getMeduimStyle(color: ColorManager.dark))
                                : Text("00:00", style: getMeduimStyle(color: ColorManager.dark)),
                            endChild: Text(cubit.myTravelTest.placeOfArrival,
                                style: getMeduimStyle(color: ColorManager.dark)),
                          ),
                          separator(),
                          Row(
                            children: [
                              Icon(
                                Icons.chair_outlined,
                                size: AppSize.s30,
                                color: cubit.acceptedRequests > 0 ? ColorManager.green : null,
                              ),
                              SizedBox(width: AppSize.s5),
                              cubit.myTravelTest.numberOfPlaces > 1
                                  ? Icon(
                                      Icons.chair_outlined,
                                      size: AppSize.s30,
                                      color: cubit.acceptedRequests > 1 ? ColorManager.green : null,
                                    )
                                  : const SizedBox(),
                              SizedBox(width: AppSize.s5),
                              cubit.myTravelTest.numberOfPlaces > 2
                                  ? Icon(
                                      Icons.chair_outlined,
                                      size: AppSize.s30,
                                      color: cubit.acceptedRequests > 2 ? ColorManager.green : null,
                                    )
                                  : const SizedBox(),
                              const Spacer(),
                              Text(
                                '${AppStrings.forOnePerson.tr(context)} ',
                                style: getSmallRegularStyle(color: ColorManager.darkGrey),
                              ),
                              Text(
                                cubit.myTravelTest.placePrice.toString(),
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
                                  Text(cubit.myTravelTest.driver.name, style: getMeduimStyle(color: ColorManager.dark)),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.star_purple500_sharp,
                                        size: AppSize.s18,
                                        color: ColorManager.yellow,
                                      ),
                                      SizedBox(width: AppSize.s5),
                                      Text(cubit.myTravelTest.driver.feedbackes.length.toString(),
                                          style: getMeduimStyle(color: ColorManager.dark)),
                                    ],
                                  )
                                ],
                              ),
                              const Spacer(),
                              IconButton(
                                onPressed: () async {
                                  final call = Uri.parse('tel:+213 ${cubit.myTravelTest.driver.phoneNumber}');
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
                                  cubit.myTravelTest.baggage == "S"
                                      ? AppStrings.baggageSAllowed.tr(context)
                                      : cubit.myTravelTest.baggage == "M"
                                          ? AppStrings.baggageMAllowed.tr(context)
                                          : cubit.myTravelTest.baggage == "L"
                                              ? AppStrings.baggageLAllowed.tr(context)
                                              : AppStrings.baggageSAllowed.tr(context),
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
                                    cubit.myTravelTest.allowPets
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
                                  cubit.myTravelTest.allowPets
                                      ? AppStrings.allowPets.tr(context)
                                      : AppStrings.petsNotAllowed.tr(context),
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
                                    cubit.myTravelTest.allowSmoking
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
                                  cubit.myTravelTest.allowSmoking
                                      ? AppStrings.smokingAllowed.tr(context)
                                      : AppStrings.dontAllowSmoking.tr(context),
                                  style: getSmallRegularStyle(color: ColorManager.dark),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: AppSize.s16),
                          separator(),
                          Text(
                            cubit.myTravelTest.carName,
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
                            child: cubit.image == null ? Image.asset(ImageAsset.dodgeCar) : Image.file(cubit.image!),
                          ),
                          separator(),
                          Text(
                            AppStrings.acceptedRequests.tr(context),
                            style: getMeduimStyle(color: ColorManager.dark),
                          ),
                          SizedBox(height: AppSize.s16),
                          ListView.builder(
                            padding: EdgeInsets.zero,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: cubit.acceptedRequestsList.length,
                            itemBuilder: (context, index) {
                              return acceptedRequestContianer(context, cubit.acceptedRequestsList[index]);
                            },
                          ),
                          separator(),
                          Text(
                            AppStrings.pendingRequests.tr(context),
                            style: getMeduimStyle(color: ColorManager.dark),
                          ),
                          SizedBox(height: AppSize.s16),
                          ListView.builder(
                            padding: EdgeInsets.zero,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: cubit.pendingRequestsList.length,
                            itemBuilder: (context, index) {
                              return pendingRequestsContainer(
                                  context, cubit.pendingRequestsList[index], cubit.myTravelTest, cubit);
                            },
                          ),
                          separator(),
                          CustomLargeButton(
                            label: AppStrings.updateTheTravel.tr(context),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => UpdateTravelView(
                                      TravelModel(
                                        travelId: 'dkfjkdjflskjdkfjag',
                                        placeOfDeparture: 'kais',
                                        timeOfDeparture: '12:00',
                                        placeOfArrival: 'batna',
                                        timeOfArrival: '03:00',
                                        numberOfPlaces: 5,
                                        carName: 'leon',
                                        carImage: 'image',
                                        placePrice: 1000,
                                        allowSmoking: true,
                                        allowPets: true,
                                        requests: [],
                                        driver: DriverModel(
                                          id: 'id',
                                          name: 'name',
                                          familyname: 'familyname',
                                          address: 'address',
                                          birthday: 'birthday',
                                          phoneNumber: 'phoneNumber',
                                          image: 'image',
                                          password: 'password',
                                          feedbackes: [],
                                          isAccepted: true,
                                          token: 'ddfas',
                                        ),
                                        baggage: 'S',
                                        dateOfDeparture: "11-11-2011",
                                      ),
                                    ),
                                  ));
                            },
                            width: double.infinity,
                          ),
                          SizedBox(height: AppSize.s16),
                          CustomLargeButton(
                            label: AppStrings.deleteTheTravel.tr(context),
                            onPressed: () {},
                            color: Colors.red,
                            width: double.infinity,
                          ),
                          separator(),
                        ],
                      ),
                    ),
                  ),
          ),
        );
      },
    );
  }

  Row pendingRequestsContainer(
      BuildContext context, RequestModel requestModel, TravelModel travel, DriverHomeCubit cubit) {
    return Row(
      children: [
        CircleAvatar(
          radius: AppSize.s30,
          backgroundColor: ColorManager.lightGrey,
          backgroundImage: const AssetImage(ImageAsset.userProfile),
        ),
        SizedBox(width: AppSize.s12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                requestModel.name,
                overflow: TextOverflow.ellipsis,
                style: getMeduimStyle(color: ColorManager.dark),
              ),
              Text(
                requestModel.phoneNumber,
                style: getMeduimStyle(color: ColorManager.dark),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
        SizedBox(width: AppSize.s20),
        Column(
          children: [
            CustomSmallButton(
              label: AppStrings.accept.tr(context),
              onPressed: () {
                cubit.updateRequestState(context, 'accept', requestModel.requestId, travel.travelId);
              },
              backgroundColor: ColorManager.yellow,
            ),
            CustomSmallButton(
              label: AppStrings.reject.tr(context),
              onPressed: () {
                cubit.updateRequestState(context, 'reject', requestModel.requestId, travel.travelId);
              },
              backgroundColor: Colors.red,
            ),
            SizedBox(width: AppSize.s5),
          ],
        ),
      ],
    );
  }

  Row acceptedRequestContianer(BuildContext context, RequestModel requestModel) {
    return Row(
      children: [
        CircleAvatar(
          radius: AppSize.s30,
          backgroundColor: ColorManager.lightGrey,
          backgroundImage: const AssetImage(ImageAsset.userProfile),
        ),
        SizedBox(width: AppSize.s12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                requestModel.name,
                overflow: TextOverflow.ellipsis,
                style: getMeduimStyle(color: ColorManager.dark),
              ),
              Text(
                requestModel.phoneNumber,
                style: getMeduimStyle(color: ColorManager.dark),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
        SizedBox(width: AppSize.s20),
        CustomSmallButton(
          label: AppStrings.feedback.tr(context),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DriverFeedbackView(requestModel.clientId),
                ));
          },
          backgroundColor: ColorManager.yellow,
        ),
      ],
    );
  }
}
