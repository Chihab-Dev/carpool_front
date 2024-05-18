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
                : cubit.myTravel == null
                    ? const Center(child: Text('No travel'))
                    : SingleChildScrollView(
                        child: Center(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: kToolbarHeight * 2),
                              Text(
                                cubit.selectedDate.toString().substring(0, 10),
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
                                startChild: cubit.pickedFromTime != null
                                    ? Text(("${cubit.pickedFromTime}"), style: getMeduimStyle(color: ColorManager.dark))
                                    : Text("00:00", style: getMeduimStyle(color: ColorManager.dark)),
                                endChild: Text("${cubit.pickedFromLocation?.address.toString()}",
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
                                startChild: cubit.pickedtoTime != null
                                    ? Text("${cubit.pickedtoTime}", style: getMeduimStyle(color: ColorManager.dark))
                                    : Text("00:00", style: getMeduimStyle(color: ColorManager.dark)),
                                endChild: Text("${cubit.pickedToLocation?.address.toString()}",
                                    style: getMeduimStyle(color: ColorManager.dark)),
                              ),
                              separator(),
                              Row(
                                children: [
                                  Icon(
                                    Icons.chair_outlined,
                                    size: AppSize.s30,
                                    color: ColorManager.yellow,
                                  ),
                                  SizedBox(width: AppSize.s5),
                                  Icon(
                                    Icons.chair_outlined,
                                    size: AppSize.s30,
                                  ),
                                  SizedBox(width: AppSize.s5),
                                  Icon(
                                    Icons.chair_outlined,
                                    size: AppSize.s30,
                                  ),
                                  const Spacer(),
                                  Text(
                                    AppStrings.forOnePerson.tr(context),
                                    style: getSmallRegularStyle(color: ColorManager.darkGrey),
                                  ),
                                  Text(
                                    "${cubit.placePrice}DA",
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
                                      Text("Chihab elhak", style: getMeduimStyle(color: ColorManager.dark)),
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.star_purple500_sharp,
                                            size: AppSize.s18,
                                            color: ColorManager.yellow,
                                          ),
                                          SizedBox(width: AppSize.s5),
                                          Text("4.5", style: getMeduimStyle(color: ColorManager.dark)),
                                        ],
                                      )
                                    ],
                                  ),
                                  const Spacer(),
                                  IconButton(
                                    onPressed: () {},
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
                                      AppStrings.baggageAllowed,
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
                                        Icon(
                                          FontAwesomeIcons.slash,
                                          size: AppSize.s25,
                                          color: Colors.red,
                                        ),
                                      ],
                                    ),
                                    SizedBox(width: AppSize.s25),
                                    Text(
                                      AppStrings.petsNotAllowed.tr(context),
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
                                    Icon(
                                      FontAwesomeIcons.smoking,
                                      size: AppSize.s25,
                                      color: ColorManager.darkGrey,
                                    ),
                                    SizedBox(width: AppSize.s25),
                                    Text(
                                      AppStrings.smokingAllowed.tr(context),
                                      style: getSmallRegularStyle(color: ColorManager.dark),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: AppSize.s16),
                              separator(),
                              Text(
                                cubit.carNameController.text,
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
                                child:
                                    cubit.image == null ? Image.asset(ImageAsset.dodgeCar) : Image.file(cubit.image!),
                              ),
                              separator(),
                              Text(
                                AppStrings.acceptedRequests,
                                style: getMeduimStyle(color: ColorManager.dark),
                              ),
                              SizedBox(height: AppSize.s16),
                              Row(
                                children: [
                                  CircleAvatar(
                                    radius: AppSize.s30,
                                    backgroundColor: ColorManager.lightGrey,
                                    backgroundImage: const AssetImage(ImageAsset.userProfile),
                                  ),
                                  SizedBox(width: AppSize.s12),
                                  Flexible(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Chaouki mansouri",
                                          overflow: TextOverflow.ellipsis,
                                          style: getMeduimStyle(color: ColorManager.dark),
                                        ),
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.star_purple500_sharp,
                                              size: AppSize.s18,
                                              color: ColorManager.yellow,
                                            ),
                                            SizedBox(width: AppSize.s5),
                                            Text("4.9", style: getMeduimStyle(color: ColorManager.dark)),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                  // const Spacer(),
                                  // CustomSmallButton(
                                  //   label: AppStrings.accepted,
                                  //   onPressed: () {},
                                  //   backgroundColor: ColorManager.green,
                                  // ),
                                  CustomSmallButton(
                                    label: AppStrings.feedback,
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => const DriverFeedbackView('662d0917155f9414c4d1d0ee'),
                                          ));
                                    },
                                    backgroundColor: ColorManager.yellow,
                                  ),
                                ],
                              ),
                              separator(),
                              Text(
                                AppStrings.pendingRequests,
                                style: getMeduimStyle(color: ColorManager.dark),
                              ),
                              SizedBox(height: AppSize.s16),
                              Row(
                                children: [
                                  CircleAvatar(
                                    radius: AppSize.s30,
                                    backgroundColor: ColorManager.lightGrey,
                                    backgroundImage: const AssetImage(ImageAsset.userProfile),
                                  ),
                                  SizedBox(width: AppSize.s12),
                                  Flexible(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Riadh saidi",
                                          overflow: TextOverflow.ellipsis,
                                          style: getMeduimStyle(color: ColorManager.dark),
                                        ),
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.star_purple500_sharp,
                                              size: AppSize.s18,
                                              color: ColorManager.yellow,
                                            ),
                                            SizedBox(width: AppSize.s5),
                                            Text("4.9", style: getMeduimStyle(color: ColorManager.dark)),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                  // const Spacer(),
                                  CustomSmallButton(
                                    label: AppStrings.reject,
                                    onPressed: () {},
                                    backgroundColor: Colors.red,
                                  ),
                                  SizedBox(width: AppSize.s5),
                                  CustomSmallButton(
                                    label: AppStrings.accept,
                                    onPressed: () {},
                                    backgroundColor: ColorManager.yellow,
                                  ),
                                ],
                              ),
                              separator(),
                              CustomLargeButton(
                                label: 'Update the travel',
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
                                label: 'Delete the travel',
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
}
