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

class AdminClientProfileView extends StatelessWidget {
  const AdminClientProfileView(this.client, {super.key});

  final ClientModel client;

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
                      foregroundImage: NetworkImage(client.image),
                    ),
                    SizedBox(height: AppSize.s18),
                    separator(),
                    CustomInformationRow(
                        label: '${AppStrings.fullName.tr(context)} : ', content: "${client.familyname} ${client.name}"),
                    separator(),
                    Row(
                      children: [
                        Text(
                          "${AppStrings.rate.tr(context)} : ",
                          style: getMeduimStyle(color: ColorManager.dark),
                        ),
                        Icon(
                          Icons.star_purple500_sharp,
                          color: ColorManager.yellow,
                        ),
                        SizedBox(width: AppSize.s5),
                        Text(client.feedbackes.length.toString(), style: getMeduimStyle(color: ColorManager.dark)),
                      ],
                    ),
                    separator(),
                    CustomInformationRow(
                        label: "${AppStrings.phoneNumber.tr(context)} : ", content: client.phoneNumber),
                    separator(),
                    CustomInformationRow(label: "${AppStrings.address.tr(context)} : ", content: client.address),
                    separator(),
                    CustomInformationRow(
                        label: "${AppStrings.old.tr(context)} : ", content: calculateAgeFromString(client.dateofbirth)),
                    separator(),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${AppStrings.feedback.tr(context)} : ${client.feedbackes.length}",
                          style: getRegularStyle(color: ColorManager.dark),
                        ),
                        SizedBox(height: AppSize.s16),
                        ListView.builder(
                          itemCount: client.feedbackes.length,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          padding: EdgeInsets.zero,
                          itemBuilder: (context, index) {
                            FeedbackModel feedback = client.feedbackes[index];
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
                    state is AdminDeleteClientLoadingState
                        ? const CircularProgressIndicator(
                            color: Colors.red,
                          )
                        : CustomLargeButton(
                            label: AppStrings.delete.tr(context),
                            onPressed: () {
                              cubit.deleteClient(context, client.id);
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
