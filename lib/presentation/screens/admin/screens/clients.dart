import 'package:carpool/data/models/models.dart';
import 'package:carpool/presentation/components/appsize.dart';
import 'package:carpool/presentation/components/assets_manager.dart';
import 'package:carpool/presentation/components/color_manager.dart';
import 'package:carpool/presentation/components/styles_manager.dart';
import 'package:carpool/presentation/screens/admin/cubit/cubit.dart';
import 'package:carpool/presentation/screens/admin/cubit/states.dart';
import 'package:carpool/presentation/screens/admin/screens/client_profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AdminClientsView extends StatelessWidget {
  const AdminClientsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AdminCubit, AdminStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = AdminCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            bottomOpacity: 0,
            scrolledUnderElevation: 0,
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: AppPadding.p18),
            child: SingleChildScrollView(
              physics: const ScrollPhysics(),
              child: Center(
                child: state is AdminGetAllClientsLoadingState
                    ? CircularProgressIndicator(
                        color: ColorManager.yellow,
                      )
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: cubit.clients.length,
                            itemBuilder: (context, index) {
                              ClientModel client = cubit.clients[index];
                              return Padding(
                                padding: EdgeInsets.only(bottom: AppPadding.p18),
                                child: Row(
                                  children: [
                                    CircleAvatar(
                                      radius: AppSize.s30,
                                      backgroundColor: ColorManager.lightGrey,
                                      backgroundImage: const AssetImage(ImageAsset.userProfile),
                                      foregroundImage: NetworkImage(client.image),
                                    ),
                                    SizedBox(width: AppSize.s12),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '${client.familyname} ${client.name}',
                                          style:
                                              getMeduimStyle(color: ColorManager.dark).copyWith(fontSize: AppSize.s16),
                                        ),
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.phone,
                                              size: AppSize.s18,
                                              color: ColorManager.green,
                                            ),
                                            SizedBox(width: AppSize.s5),
                                            Text(
                                              client.phoneNumber,
                                              style: getMeduimStyle(color: ColorManager.dark)
                                                  .copyWith(fontSize: AppSize.s16),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    const Spacer(),
                                    SizedBox(width: AppSize.s12),
                                    IconButton(
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => AdminClientProfileView(client),
                                          ),
                                        );
                                      },
                                      icon: Icon(
                                        FontAwesomeIcons.arrowRight,
                                        size: AppSize.s25,
                                        color: ColorManager.yellow,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
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
