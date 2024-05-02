import 'package:carpool/presentation/components/appsize.dart';
import 'package:carpool/presentation/components/assets_manager.dart';
import 'package:carpool/presentation/components/color_manager.dart';
import 'package:carpool/presentation/components/styles_manager.dart';
import 'package:carpool/presentation/components/widgets.dart';
import 'package:flutter/material.dart';

class DriverprofileView22 extends StatelessWidget {
  const DriverprofileView22({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(AppPadding.p18),
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: kToolbarHeight),
              CircleAvatar(
                radius: AppSize.s70,
                backgroundColor: ColorManager.lightGrey,
                backgroundImage: const AssetImage(ImageAsset.profilePicture),
              ),
              SizedBox(height: AppSize.s18),
              Text(
                "Chihab elhak",
                style: getRegularStyle(color: ColorManager.dark),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.star_purple500_sharp,
                    color: ColorManager.yellow,
                  ),
                  SizedBox(width: AppSize.s5),
                  Text("4.9", style: getMeduimStyle(color: ColorManager.dark))
                ],
              ),
              Text(
                "+213656933390",
                style: getSmallRegularStyle(color: ColorManager.dark),
              ),
              separator(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Feedbacks",
                    style: getRegularStyle(color: ColorManager.dark),
                  ),
                  SizedBox(height: AppSize.s16),
                  Row(
                    children: [
                      CircleAvatar(
                        radius: AppSize.s30,
                        backgroundColor: ColorManager.lightGrey,
                        backgroundImage: const AssetImage(ImageAsset.userProfile),
                      ),
                      SizedBox(width: AppSize.s10),
                      Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  "Chaouki mansouri",
                                  overflow: TextOverflow.ellipsis,
                                  style: getMeduimStyle(color: ColorManager.dark),
                                ),
                                Icon(
                                  Icons.star_purple500_sharp,
                                  color: ColorManager.yellow,
                                ),
                                SizedBox(width: AppSize.s5),
                                Text("4.9", style: getMeduimStyle(color: ColorManager.dark))
                              ],
                            ),
                            Text(
                              'Excellent service from the driver! They were punctual, courteous, and drove safely throughout the journey',
                              style: getSmallRegularStyle(color: ColorManager.darkGrey),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: AppSize.s16),
                  Row(
                    children: [
                      CircleAvatar(
                        radius: AppSize.s30,
                        backgroundColor: ColorManager.lightGrey,
                        backgroundImage: const AssetImage(ImageAsset.userProfile),
                      ),
                      SizedBox(width: AppSize.s10),
                      Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  "Chihab lahmari",
                                  overflow: TextOverflow.ellipsis,
                                  style: getMeduimStyle(color: ColorManager.dark),
                                ),
                                Icon(
                                  Icons.star_purple500_sharp,
                                  color: ColorManager.yellow,
                                ),
                                SizedBox(width: AppSize.s5),
                                Text("4.9", style: getMeduimStyle(color: ColorManager.dark))
                              ],
                            ),
                            Text(
                              'Excellent service from the driver! They were punctual, courteous, and drove safely throughout the journey',
                              style: getSmallRegularStyle(color: ColorManager.darkGrey),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  separator(),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
