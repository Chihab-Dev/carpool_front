import 'package:carpool/data/models/models.dart';
import 'package:carpool/presentation/components/appsize.dart';
import 'package:carpool/presentation/components/assets_manager.dart';
import 'package:carpool/presentation/components/color_manager.dart';
import 'package:carpool/presentation/components/styles_manager.dart';
import 'package:carpool/presentation/components/widgets.dart';
import 'package:carpool/presentation/screens/Client/home/cubit/home_cubit.dart';
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
        return cubit.clientModel == null
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
                          "${cubit.clientModel!.familyname} ${cubit.clientModel!.name}",
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
                            Text(cubit.clientModel!.feedbackes.length.toString(),
                                style: getMeduimStyle(color: ColorManager.dark))
                          ],
                        ),
                        Text(
                          cubit.clientModel!.phoneNumber,
                          style: getSmallRegularStyle(color: ColorManager.dark),
                        ),
                        Text(
                          cubit.clientModel!.address,
                          style: getSmallRegularStyle(color: ColorManager.dark),
                        ),
                        Text(
                          calculateAgeFromString(cubit.clientModel!.dateofbirth),
                          style: getSmallRegularStyle(color: ColorManager.dark),
                        ),
                        separator(),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Feedbacks ${cubit.clientModel!.feedbackes.length}",
                              style: getRegularStyle(color: ColorManager.dark),
                            ),
                            SizedBox(height: AppSize.s16),
                            ListView.builder(
                              itemCount: cubit.clientModel!.feedbackes.length,
                              shrinkWrap: true,
                              padding: EdgeInsets.zero,
                              itemBuilder: (context, index) {
                                FeedbackModel feedback = cubit.clientModel!.feedbackes[index];
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
