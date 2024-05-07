import 'package:carpool/data/models/models.dart';
import 'package:carpool/presentation/components/appsize.dart';
import 'package:carpool/presentation/components/assets_manager.dart';
import 'package:carpool/presentation/components/color_manager.dart';
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
                    CircleAvatar(
                      radius: AppSize.s70,
                      backgroundColor: ColorManager.lightGrey,
                      backgroundImage: const AssetImage(ImageAsset.profilePicture),
                    ),
                    SizedBox(height: AppSize.s18),
                    separator(),
                    CustomInformationRow(label: 'Full name :', content: "${client.familyname} ${client.name}"),
                    separator(),
                    Row(
                      children: [
                        Text(
                          "Rate : ",
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
                    CustomInformationRow(label: "Phone number : ", content: client.phoneNumber),
                    separator(),
                    CustomInformationRow(label: "Address : ", content: client.address),
                    separator(),
                    CustomInformationRow(label: "Old : ", content: calculateAgeFromString(client.dateofbirth)),
                    separator(),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Feedbacks : ${client.feedbackes.length}",
                          style: getRegularStyle(color: ColorManager.dark),
                        ),
                        SizedBox(height: AppSize.s16),
                        ListView.builder(
                          itemCount: client.feedbackes.length,
                          shrinkWrap: true,
                          padding: EdgeInsets.zero,
                          itemBuilder: (context, index) {
                            FeedbackModel feedback = client.feedbackes[index];
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
                    ),
                    state is AdminDeleteClientLoadingState
                        ? const CircularProgressIndicator(
                            color: Colors.red,
                          )
                        : CustomLargeButton(
                            label: 'Delete client',
                            onPressed: () {
                              cubit.deleteClient(context, client.id);
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
