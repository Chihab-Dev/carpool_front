import 'package:carpool/data/models/models.dart';
import 'package:carpool/presentation/components/appsize.dart';
import 'package:carpool/presentation/components/assets_manager.dart';
import 'package:carpool/presentation/components/color_manager.dart';
import 'package:carpool/presentation/components/styles_manager.dart';
import 'package:carpool/presentation/components/widgets.dart';
import 'package:carpool/presentation/screens/Driver/home/cubit/driver_home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DriverProfileView extends StatefulWidget {
  const DriverProfileView({super.key});

  @override
  State<DriverProfileView> createState() => _DriverProfileViewState();
}

class _DriverProfileViewState extends State<DriverProfileView> {
  @override
  void initState() {
    super.initState();
    if (DriverHomeCubit.get(context).driverModel == null) {
      DriverHomeCubit.get(context).getDriverById(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DriverHomeCubit, DriverHomeState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = DriverHomeCubit.get(context);
        return cubit.driverModel == null
            ? CircularProgressIndicator(color: ColorManager.yellow)
            : Scaffold(
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
                          "${cubit.driverModel!.familyname} ${cubit.driverModel!.name}",
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
                            Text(cubit.driverModel!.feedbackes.length.toString(),
                                style: getMeduimStyle(color: ColorManager.dark))
                          ],
                        ),
                        Text(
                          cubit.driverModel!.phoneNumber,
                          style: getSmallRegularStyle(color: ColorManager.dark),
                        ),
                        Text(
                          cubit.driverModel!.address,
                          style: getSmallRegularStyle(color: ColorManager.dark),
                        ),
                        Text(
                          calculateAgeFromString(cubit.driverModel!.birthday),
                          style: getSmallRegularStyle(color: ColorManager.dark),
                        ),
                        separator(),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Feedbacks ${cubit.driverModel!.feedbackes.length}",
                              style: getRegularStyle(color: ColorManager.dark),
                            ),
                            SizedBox(height: AppSize.s16),
                            ListView.builder(
                              itemCount: cubit.driverModel!.feedbackes.length,
                              shrinkWrap: true,
                              padding: EdgeInsets.zero,
                              itemBuilder: (context, index) {
                                FeedbackModel feedback = cubit.driverModel!.feedbackes[index];
                                return Row(
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
                                                'USER',
                                                overflow: TextOverflow.ellipsis,
                                                style: getMeduimStyle(color: ColorManager.dark),
                                              ),
                                              Icon(
                                                Icons.star_purple500_sharp,
                                                color: ColorManager.yellow,
                                              ),
                                              SizedBox(width: AppSize.s5),
                                              Text(feedback.note.toString(),
                                                  style: getMeduimStyle(color: ColorManager.dark))
                                            ],
                                          ),
                                          Text(
                                            feedback.comment,
                                            style: getSmallRegularStyle(color: ColorManager.darkGrey),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                            separator(),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              );
      },
    );
  }
}
