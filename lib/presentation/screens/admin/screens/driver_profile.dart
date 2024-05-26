import 'package:carpool/app/localizations.dart';
import 'package:carpool/data/models/models.dart';
import 'package:carpool/presentation/components/appsize.dart';
import 'package:carpool/presentation/components/assets_manager.dart';
import 'package:carpool/presentation/components/color_manager.dart';
import 'package:carpool/presentation/components/strings_manager.dart';
import 'package:carpool/presentation/components/styles_manager.dart';
import 'package:carpool/presentation/components/widgets.dart';
import 'package:carpool/presentation/screens/admin/cubit/cubit.dart';
import 'package:carpool/presentation/screens/admin/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdminDriverProfileView extends StatelessWidget {
  const AdminDriverProfileView(this.driver, {super.key});

  final DriverModel driver;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AdminCubit, AdminStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = AdminCubit.get(context);
        return Scaffold(
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            bottomOpacity: 0,
            scrolledUnderElevation: 0,
          ),
          body: Padding(
            padding: EdgeInsets.all(AppPadding.p18),
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: kToolbarHeight),
                    separator(),
                    CircleAvatar(
                      radius: AppSize.s70,
                      backgroundColor: ColorManager.lightGrey,
                      backgroundImage: const AssetImage(ImageAsset.userProfile),
                      foregroundImage: NetworkImage(driver.image),
                    ),
                    SizedBox(height: AppSize.s18),
                    separator(),
                    CustomInformationRow(
                        label: AppStrings.fullName.tr(context), content: " ${driver.familyname} ${driver.name}"),
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
                        Text(driver.feedbackes.length.toString(), style: getMeduimStyle(color: ColorManager.dark)),
                      ],
                    ),
                    separator(),
                    CustomInformationRow(
                        label: "${AppStrings.phoneNumber.tr(context)} : ", content: driver.phoneNumber),
                    separator(),
                    CustomInformationRow(label: "${AppStrings.address.tr(context)} : ", content: driver.address),
                    separator(),
                    CustomInformationRow(
                        label: AppStrings.old.tr(context), content: calculateAgeFromString(driver.birthday)),
                    separator(),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${AppStrings.feedback.tr(context)} : ${driver.feedbackes.length}",
                          style: getRegularStyle(color: ColorManager.dark),
                        ),
                        SizedBox(height: AppSize.s16),
                        ListView.builder(
                          itemCount: driver.feedbackes.length,
                          shrinkWrap: true,
                          padding: EdgeInsets.zero,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            FeedbackModel feedback = driver.feedbackes[index];
                            return Container(
                              margin: EdgeInsets.only(top: AppSize.s12),
                              child: Row(
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
                              ),
                            );
                          },
                        ),
                        separator(),
                      ],
                    ),
                    driver.isAccepted == false
                        ? state is AdminAcceptDriverLoadingState
                            ? CircularProgressIndicator(
                                color: ColorManager.green,
                              )
                            : CustomLargeButton(
                                label: AppStrings.accept.tr(context),
                                onPressed: () {
                                  cubit.acceptDriver(context, driver.id);
                                },
                                color: ColorManager.green,
                              )
                        : Text(
                            AppStrings.accepted.tr(context),
                            style: getMeduimStyle(color: ColorManager.dark),
                          ),
                    separator(),
                    driver.isAccepted == false
                        ? state is AdminRejectDriverLoadingState
                            ? const CircularProgressIndicator(
                                color: Colors.red,
                              )
                            : CustomLargeButton(
                                label: AppStrings.reject.tr(context),
                                onPressed: () {
                                  cubit.rejectDriver(context, driver.id);
                                },
                                color: Colors.red,
                              )
                        : const SizedBox(),
                    driver.isAccepted == false ? separator() : const SizedBox(),
                    state is AdminDeleteDriverLoadingState
                        ? const CircularProgressIndicator(
                            color: Colors.red,
                          )
                        : CustomLargeButton(
                            label: AppStrings.delete.tr(context),
                            onPressed: () {
                              cubit.deleteDriver(context, driver.id);
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

class CustomInformationRow extends StatelessWidget {
  const CustomInformationRow({
    super.key,
    required this.label,
    required this.content,
  });

  final String label;
  final String content;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          label,
          style: getMeduimStyle(color: ColorManager.dark),
        ),
        Text(
          content,
          style: getMeduimStyle(color: ColorManager.dark),
        ),
      ],
    );
  }
}
