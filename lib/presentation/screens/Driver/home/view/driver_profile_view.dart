import 'package:carpool/app/localizations.dart';
import 'package:carpool/data/models/models.dart';
import 'package:carpool/presentation/components/appsize.dart';
import 'package:carpool/presentation/components/assets_manager.dart';
import 'package:carpool/presentation/components/color_manager.dart';
import 'package:carpool/presentation/components/strings_manager.dart';
import 'package:carpool/presentation/components/styles_manager.dart';
import 'package:carpool/presentation/components/widgets.dart';
import 'package:carpool/presentation/screens/Driver/home/cubit/driver_home_cubit.dart';
import 'package:carpool/presentation/screens/admin/screens/client_profile.dart';
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
        return state is DriverGetDriverLoadingState
            ? CircularProgressIndicator(color: ColorManager.yellow)
            : cubit.driverModel == null
                ? const SizedBox()
                : Scaffold(
                    body: Padding(
                      padding: EdgeInsets.symmetric(horizontal: AppPadding.p18),
                      child: SingleChildScrollView(
                        child: Center(
                          child: Column(
                            children: [
                              const SizedBox(height: kToolbarHeight),
                              separator(),
                              CircleAvatar(
                                radius: AppSize.s70,
                                backgroundColor: ColorManager.lightGrey,
                                backgroundImage: const AssetImage(ImageAsset.profilePicture),
                              ),
                              SizedBox(height: AppSize.s18),
                              separator(),
                              CustomInformationRow(
                                  label: AppStrings.fullName.tr(context),
                                  content: "${cubit.driverModel!.familyname} ${cubit.driverModel!.name}"),
                              separator(),
                              Row(
                                children: [
                                  Text(
                                    AppStrings.rate.tr(context),
                                    style: getMeduimStyle(color: ColorManager.dark),
                                  ),
                                  Icon(
                                    Icons.star_purple500_sharp,
                                    color: ColorManager.yellow,
                                  ),
                                  SizedBox(width: AppSize.s5),
                                  Text(
                                    cubit.calculateRate(cubit.driverModel!.feedbackes).toString(),
                                    style: getMeduimStyle(color: ColorManager.dark),
                                  ),
                                ],
                              ),
                              separator(),
                              CustomInformationRow(
                                  label: '${AppStrings.phoneNumber.tr(context)} : ',
                                  content: cubit.driverModel!.phoneNumber),
                              separator(),
                              CustomInformationRow(
                                  label: "${AppStrings.address.tr(context)} : ", content: cubit.driverModel!.address),
                              separator(),
                              CustomInformationRow(
                                  label: AppStrings.old.tr(context),
                                  content: calculateAgeFromString(cubit.driverModel!.birthday)),
                              separator(),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${AppStrings.feedback.tr(context)} : ${cubit.driverModel!.feedbackes.length}",
                                    style: getRegularStyle(color: ColorManager.dark),
                                  ),
                                  SizedBox(height: AppSize.s16),
                                  ListView.builder(
                                    itemCount: cubit.driverModel!.feedbackes.length,
                                    shrinkWrap: true,
                                    padding: EdgeInsets.zero,
                                    physics: const NeverScrollableScrollPhysics(),
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
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  children: [
                                                    Text(
                                                      feedback.name.toString(),
                                                      overflow: TextOverflow.ellipsis,
                                                      style: getMeduimStyle(color: ColorManager.dark),
                                                    ),
                                                    const Spacer(),
                                                    Icon(
                                                      Icons.star_purple500_sharp,
                                                      color: ColorManager.yellow,
                                                    ),
                                                    SizedBox(width: AppSize.s5),
                                                    Text(
                                                      feedback.note.toString(),
                                                      style: getMeduimStyle(color: ColorManager.dark),
                                                    )
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
                              ),
                              CustomLargeButton(
                                label: AppStrings.logout.tr(context),
                                width: double.infinity,
                                onPressed: () {
                                  logout(context);
                                },
                                color: Colors.red,
                              ),
                              separator(),
                              const SizedBox(height: kToolbarHeight),
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
