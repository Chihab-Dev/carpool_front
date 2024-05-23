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
  const DriverMyTravelView(this.myTravel, {super.key});

  final TravelModel myTravel;

  @override
  State<DriverMyTravelView> createState() => _DriverMyTravelViewState();
}

class _DriverMyTravelViewState extends State<DriverMyTravelView> {
  @override
  void initState() {
    super.initState();
    DriverHomeCubit.get(context).calculateAcceptedRequests(widget.myTravel.requests);
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
            child: SingleChildScrollView(
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: kToolbarHeight * 2),
                    Text(
                      widget.myTravel.dateOfDeparture.substring(0, 10),
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
                      startChild:
                          Text((widget.myTravel.timeOfDeparture), style: getMeduimStyle(color: ColorManager.dark)),
                      endChild: Text(widget.myTravel.placeOfDeparture, style: getMeduimStyle(color: ColorManager.dark)),
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
                      startChild: Text(widget.myTravel.timeOfArrival, style: getMeduimStyle(color: ColorManager.dark)),
                      endChild: Text(widget.myTravel.placeOfArrival, style: getMeduimStyle(color: ColorManager.dark)),
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
                        widget.myTravel.numberOfPlaces > 1
                            ? Icon(
                                Icons.chair_outlined,
                                size: AppSize.s30,
                                color: cubit.acceptedRequests > 1 ? ColorManager.green : null,
                              )
                            : const SizedBox(),
                        SizedBox(width: AppSize.s5),
                        widget.myTravel.numberOfPlaces > 2
                            ? Icon(
                                Icons.chair_outlined,
                                size: AppSize.s30,
                                color: cubit.acceptedRequests > 2 ? ColorManager.green : null,
                              )
                            : const SizedBox(),
                        SizedBox(width: AppSize.s5),
                        widget.myTravel.numberOfPlaces > 3
                            ? Icon(
                                Icons.chair_outlined,
                                size: AppSize.s30,
                                color: cubit.acceptedRequests > 3 ? ColorManager.green : null,
                              )
                            : const SizedBox(),
                        SizedBox(width: AppSize.s5),
                        widget.myTravel.numberOfPlaces > 4
                            ? Icon(
                                Icons.chair_outlined,
                                size: AppSize.s30,
                                color: cubit.acceptedRequests > 4 ? ColorManager.green : null,
                              )
                            : const SizedBox(),
                        const Spacer(),
                        Text(
                          '${AppStrings.forOnePerson.tr(context)} ',
                          style: getSmallRegularStyle(color: ColorManager.darkGrey),
                        ),
                        Text(
                          widget.myTravel.placePrice.toString(),
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
                            Text(widget.myTravel.driver.name, style: getMeduimStyle(color: ColorManager.dark)),
                            Row(
                              children: [
                                Icon(
                                  Icons.star_purple500_sharp,
                                  size: AppSize.s18,
                                  color: ColorManager.yellow,
                                ),
                                SizedBox(width: AppSize.s5),
                                Text(widget.myTravel.driver.feedbackes.length.toString(),
                                    style: getMeduimStyle(color: ColorManager.dark)),
                              ],
                            )
                          ],
                        ),
                        const Spacer(),
                        IconButton(
                          onPressed: () async {
                            final call = Uri.parse('tel:+213 ${widget.myTravel.driver.phoneNumber}');
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
                            widget.myTravel.baggage == "S"
                                ? AppStrings.baggageSAllowed.tr(context)
                                : widget.myTravel.baggage == "M"
                                    ? AppStrings.baggageMAllowed.tr(context)
                                    : widget.myTravel.baggage == "L"
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
                              widget.myTravel.allowPets
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
                            widget.myTravel.allowPets
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
                              widget.myTravel.allowSmoking
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
                            widget.myTravel.allowSmoking
                                ? AppStrings.smokingAllowed.tr(context)
                                : AppStrings.dontAllowSmoking.tr(context),
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
                                FontAwesomeIcons.a,
                                size: AppSize.s25,
                                color: ColorManager.darkGrey,
                              ),
                              widget.myTravel.autoAcceptRequests
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
                            widget.myTravel.autoAcceptRequests
                                ? AppStrings.autoAcceptEnabled.tr(context)
                                : AppStrings.autoAcceptNotEnabled.tr(context),
                            style: getSmallRegularStyle(color: ColorManager.dark),
                          ),
                        ],
                      ),
                    ),
                    separator(),
                    Text(
                      widget.myTravel.carName,
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          AppStrings.travelState.tr(context),
                          style: getMeduimStyle(color: ColorManager.dark),
                        ),
                        Text(
                          widget.myTravel.state,
                          style: getMeduimStyle(color: ColorManager.yellow),
                        ),
                      ],
                    ),
                    SizedBox(height: AppSize.s20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomLargeButton(
                          label: AppStrings.travelStarts.tr(context),
                          width: AppSize.s180,
                          onPressed: () {
                            cubit.changeState(context, 'start Travel', widget.myTravel.travelId);
                          },
                          color: ColorManager.yellow,
                        ),
                        CustomLargeButton(
                          label: AppStrings.travelFinished.tr(context),
                          onPressed: () {
                            cubit.changeState(context, 'finished', widget.myTravel.travelId);
                          },
                          color: ColorManager.green,
                          width: AppSize.s180,
                        ),
                      ],
                    ),
                    separator(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          AppStrings.acceptedRequests.tr(context),
                          style: getMeduimStyle(color: ColorManager.dark),
                        ),
                        IconButton(
                          onPressed: () {
                            cubit.getMyTravels(context);
                          },
                          icon: const Icon(Icons.replay_outlined),
                        )
                      ],
                    ),
                    SizedBox(height: AppSize.s16),
                    ListView.builder(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: cubit.acceptRequestsList.length,
                      itemBuilder: (context, index) {
                        return acceptedRequestContianer(
                            context, cubit.acceptRequestsList[index], cubit, cubit.allMyTravels[index]);
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
                            context, cubit.pendingRequestsList[index], widget.myTravel, cubit);
                      },
                    ),
                    separator(),
                    Text(
                      AppStrings.reject.tr(context),
                      style: getMeduimStyle(color: ColorManager.dark),
                    ),
                    SizedBox(height: AppSize.s16),
                    ListView.builder(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: cubit.rejectRequestsList.length,
                      itemBuilder: (context, index) {
                        return rejectRequestContianer(context, cubit.rejectRequestsList[index], cubit, widget.myTravel);
                      },
                    ),
                    separator(),
                    CustomLargeButton(
                      label: AppStrings.updateTheTravel.tr(context),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => UpdateTravelView(widget.myTravel),
                            ));
                      },
                      width: double.infinity,
                    ),
                    SizedBox(height: AppSize.s16),
                    state is DriverDeleteTravelLoadingState
                        ? Center(child: CircularProgressIndicator(color: ColorManager.yellow))
                        : CustomLargeButton(
                            label: AppStrings.deleteTheTravel.tr(context),
                            onPressed: () {
                              cubit.deleteTravel(context, widget.myTravel.travelId);
                            },
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
                cubit.updateRequestState(context, 'accept', requestModel.requestId, travel);
              },
              backgroundColor: ColorManager.yellow,
            ),
            CustomSmallButton(
              label: AppStrings.reject.tr(context),
              onPressed: () {
                cubit.updateRequestState(context, 'reject', requestModel.requestId, travel);
              },
              backgroundColor: Colors.red,
            ),
            SizedBox(width: AppSize.s5),
          ],
        ),
      ],
    );
  }

  Widget acceptedRequestContianer(
      BuildContext context, RequestModel requestModel, DriverHomeCubit cubit, TravelModel travel) {
    return Container(
      margin: EdgeInsets.only(top: AppMargin.m18),
      child: Row(
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
          travel.state == 'finished'
              ? CustomSmallButton(
                  label: AppStrings.feedback.tr(context),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DriverFeedbackView(requestModel.clientId),
                        ));
                  },
                  backgroundColor: ColorManager.yellow,
                )
              : CustomSmallButton(
                  label: AppStrings.reject.tr(context),
                  onPressed: () {
                    cubit.updateRequestState(context, 'reject', requestModel.requestId, travel);
                  },
                  backgroundColor: Colors.red,
                ),
        ],
      ),
    );
  }

  Widget rejectRequestContianer(
      BuildContext context, RequestModel requestModel, DriverHomeCubit cubit, TravelModel travel) {
    return Container(
      margin: EdgeInsets.only(top: AppMargin.m18),
      child: Row(
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
            label: AppStrings.accept.tr(context),
            onPressed: () {
              cubit.updateRequestState(context, 'accept', requestModel.requestId, travel);
            },
            backgroundColor: ColorManager.yellow,
          ),
        ],
      ),
    );
  }
}
