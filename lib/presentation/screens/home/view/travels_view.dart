import 'package:carpool/presentation/components/appsize.dart';
import 'package:carpool/presentation/components/assets_manager.dart';
import 'package:carpool/presentation/components/color_manager.dart';
import 'package:carpool/presentation/components/styles_manager.dart';
import 'package:carpool/presentation/screens/home/cubit/home_cubit.dart';
import 'package:carpool/presentation/screens/home/view/travel_details_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:timeline_tile/timeline_tile.dart';

class TravelsView extends StatelessWidget {
  const TravelsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = HomeCubit.get(context);
        return Scaffold(
          body: Padding(
            padding: EdgeInsets.all(AppSize.s18).copyWith(top: 0.0),
            child: SingleChildScrollView(
              child: Center(
                child: Column(
                  children: [
                    SizedBox(height: MediaQuery.of(context).padding.top),
                    Container(
                      width: AppSize.s350,
                      height: AppSize.s70,
                      decoration: BoxDecoration(
                        color: ColorManager.lightGrey,
                        borderRadius: BorderRadius.circular(AppPadding.p10),
                      ),
                      child: Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: const Icon(Icons.arrow_back_ios_new_rounded),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${cubit.pickedFromLocation?.address.toString().split(',').first}  →  ${cubit.pickedToLocation?.address.toString().split(',').first}',
                                style: getMeduimStyle(color: ColorManager.dark).copyWith(fontSize: AppSize.s16),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                '${cubit.selectedDate.toString().substring(0, 10)}  ,  ${cubit.numberOfPlaces} person',
                                style: getSmallRegularStyle(color: ColorManager.dark),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    travelDetailsContainer(context, cubit),
                    travelDetailsContainer(context, cubit),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget travelDetailsContainer(BuildContext context, HomeCubit cubit) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const TravelDetailsView(),
            ));
      },
      child: Container(
        width: AppSize.s350,
        // height: AppSize.s250,
        margin: EdgeInsets.only(top: AppSize.s25),
        padding: EdgeInsets.all(AppPadding.p18),
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
              startChild: Text(
                '14:00',
                style: getMeduimStyle(color: ColorManager.dark).copyWith(fontSize: AppSize.s16),
              ),
              endChild: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "${cubit.pickedFromLocation?.address.toString().split(',').first}",
                    style: getMeduimStyle(color: ColorManager.dark).copyWith(fontSize: AppSize.s16),
                  ),
                  const Spacer(),
                  Text(
                    "1500DA",
                    style: getMeduimStyle(color: ColorManager.dark).copyWith(fontSize: AppSize.s16),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: AppSize.s50,
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
              startChild: Text(
                '21:00',
                style: getMeduimStyle(color: ColorManager.dark).copyWith(fontSize: AppSize.s16),
              ),
              endChild: Text(
                "${cubit.pickedToLocation?.address.toString().split(',').first}",
                style: getMeduimStyle(color: ColorManager.dark).copyWith(fontSize: AppSize.s16),
              ),
            ),
            SizedBox(height: AppSize.s30),
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
                    Text(
                      "Chihab elhak",
                      style: getMeduimStyle(color: ColorManager.dark).copyWith(fontSize: AppSize.s16),
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.star_purple500_sharp,
                          size: AppSize.s18,
                          color: ColorManager.yellow,
                        ),
                        SizedBox(width: AppSize.s5),
                        Text(
                          "4.5",
                          style: getMeduimStyle(color: ColorManager.dark).copyWith(fontSize: AppSize.s16),
                        ),
                      ],
                    )
                  ],
                ),
                const Spacer(),
                Icon(
                  FontAwesomeIcons.cartFlatbedSuitcase,
                  size: AppSize.s25,
                  color: ColorManager.dark,
                ),
                SizedBox(width: AppSize.s12),
                Text(
                  "L",
                  style: getMeduimStyle(color: ColorManager.dark),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
