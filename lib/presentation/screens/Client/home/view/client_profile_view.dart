import 'package:carpool/app/localizations.dart';
import 'package:carpool/data/models/models.dart';
import 'package:carpool/presentation/components/appsize.dart';
import 'package:carpool/presentation/components/assets_manager.dart';
import 'package:carpool/presentation/components/color_manager.dart';
import 'package:carpool/presentation/components/strings_manager.dart';
import 'package:carpool/presentation/components/styles_manager.dart';
import 'package:carpool/presentation/components/widgets.dart';
import 'package:carpool/presentation/screens/Client/home/cubit/home_cubit.dart';
import 'package:carpool/presentation/screens/admin/screens/client_profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ClientProfileView extends StatefulWidget {
  const ClientProfileView({super.key});

  @override
  State<ClientProfileView> createState() => _ClientProfileViewState();
}

class _ClientProfileViewState extends State<ClientProfileView> {
  @override
  void initState() {
    super.initState();
    if (HomeCubit.get(context).clientModel == null) {
      HomeCubit.get(context).getClientById(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = HomeCubit.get(context);
        return state is HomeGetClientLoadingState
            ? CircularProgressIndicator(color: ColorManager.yellow)
            : cubit.clientModel == null
                ? const SizedBox()
                : Scaffold(
                    body: Padding(
                      padding: EdgeInsets.all(AppPadding.p18),
                      child: SingleChildScrollView(
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
                              separator(),
                              CustomInformationRow(
                                  label: AppStrings.fullName.tr(context),
                                  content: "${cubit.clientModel!.familyname} ${cubit.clientModel!.name}"),
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
                                    cubit.calculateRate(cubit.clientModel!.feedbackes).toString(),
                                    style: getMeduimStyle(color: ColorManager.dark),
                                  ),
                                ],
                              ),
                              separator(),
                              CustomInformationRow(
                                  label: "${AppStrings.phoneNumber.tr(context)} : ",
                                  content: cubit.clientModel!.phoneNumber),
                              separator(),
                              CustomInformationRow(
                                  label: '${AppStrings.address.tr(context)} : ', content: cubit.clientModel!.address),
                              separator(),
                              CustomInformationRow(
                                  label: AppStrings.old.tr(context),
                                  content: calculateAgeFromString(cubit.clientModel!.dateofbirth)),
                              separator(),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        "${AppStrings.feedback.tr(context)} : ",
                                        style: getRegularStyle(color: ColorManager.dark),
                                      ),
                                      Text(
                                        "${cubit.clientModel!.feedbackes.length}",
                                        style: getRegularStyle(color: ColorManager.dark),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: AppSize.s16),
                                  ListView.builder(
                                    itemCount: cubit.clientModel!.feedbackes.length,
                                    shrinkWrap: true,
                                    physics: const NeverScrollableScrollPhysics(),
                                    padding: EdgeInsets.zero,
                                    itemBuilder: (context, index) {
                                      FeedbackModel feedback = cubit.clientModel!.feedbackes[index];
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
                              CustomLargeButton(
                                label: AppStrings.logout.tr(context),
                                width: double.infinity,
                                onPressed: () {
                                  logout(context);
                                },
                                color: Colors.red,
                              ),
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
