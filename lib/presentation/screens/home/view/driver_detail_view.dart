import 'package:carpool/presentation/components/appsize.dart';
import 'package:carpool/presentation/components/assets_manager.dart';
import 'package:carpool/presentation/components/color_manager.dart';
import 'package:carpool/presentation/components/styles_manager.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DriverDetailsView extends StatelessWidget {
  const DriverDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        bottomOpacity: 0,
        scrolledUnderElevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.all(AppSize.s18).copyWith(top: 0.0),
        child: Center(
          child: Column(
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: AppSize.s50,
                    backgroundColor: ColorManager.lightGrey,
                    backgroundImage: const AssetImage(ImageAsset.profilePicture),
                  ),
                  SizedBox(width: AppSize.s20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Chihab elhak",
                        style: getMeduimStyle(color: ColorManager.dark),
                      ),
                      Text(
                        "male, 26 years old",
                        style: getSmallRegularStyle(color: ColorManager.dark),
                      ),
                      Text(
                        "member since nov. 2021",
                        style: getSmallRegularStyle(color: ColorManager.dark),
                      ),
                    ],
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: AppSize.s25),
                width: double.infinity,
                height: AppSize.s1,
                color: ColorManager.darkGrey,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      Icon(
                        FontAwesomeIcons.user,
                        size: AppSize.s40,
                      ),
                      SizedBox(height: AppSize.s10),
                      Text(
                        "14",
                        style:
                            getMeduimStyle(color: ColorManager.dark.withOpacity(0.7)).copyWith(fontSize: AppSize.s16),
                      ),
                      Text(
                        "Driving",
                        style:
                            getMeduimStyle(color: ColorManager.dark.withOpacity(0.7)).copyWith(fontSize: AppSize.s16),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Icon(
                        FontAwesomeIcons.car,
                        size: AppSize.s40,
                      ),
                      SizedBox(height: AppSize.s10),
                      Text(
                        "5",
                        style:
                            getMeduimStyle(color: ColorManager.dark.withOpacity(0.7)).copyWith(fontSize: AppSize.s16),
                      ),
                      Text(
                        "Rides Tiken",
                        style:
                            getMeduimStyle(color: ColorManager.dark.withOpacity(0.7)).copyWith(fontSize: AppSize.s16),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Icon(
                        FontAwesomeIcons.star,
                        size: AppSize.s40,
                      ),
                      SizedBox(height: AppSize.s10),
                      Text(
                        "4.5",
                        style:
                            getMeduimStyle(color: ColorManager.dark.withOpacity(0.7)).copyWith(fontSize: AppSize.s16),
                      ),
                      Text(
                        "Rate",
                        style:
                            getMeduimStyle(color: ColorManager.dark.withOpacity(0.7)).copyWith(fontSize: AppSize.s16),
                      ),
                    ],
                  )
                ],
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: AppSize.s25),
                width: double.infinity,
                height: AppSize.s1,
                color: ColorManager.darkGrey,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
