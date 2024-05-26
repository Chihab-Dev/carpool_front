import 'package:carpool/data/models/models.dart';
import 'package:carpool/presentation/components/appsize.dart';
import 'package:carpool/presentation/components/assets_manager.dart';
import 'package:carpool/presentation/components/color_manager.dart';
import 'package:carpool/presentation/components/widgets.dart';
import 'package:carpool/presentation/screens/admin/cubit/cubit.dart';
import 'package:carpool/presentation/screens/admin/cubit/states.dart';
import 'package:carpool/presentation/screens/admin/screens/travel_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

class AdminTravelsView extends StatelessWidget {
  const AdminTravelsView({super.key});

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
            padding: EdgeInsets.symmetric(horizontal: AppPadding.p18),
            child: SingleChildScrollView(
              physics: const ScrollPhysics(),
              child: Center(
                child: state is AdminGetAllTravelsLoadingState
                    ? CircularProgressIndicator(
                        color: ColorManager.yellow,
                      )
                    : cubit.travels.isEmpty
                        ? Center(
                            child: Lottie.asset(LottieAsset.empty),
                          )
                        : Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: cubit.travels.length,
                                itemBuilder: (context, index) {
                                  TravelModel travel = cubit.travels[index];
                                  return Column(
                                    children: [
                                      travelDetailsContainer(context, travel, AdminTravelDetailsView(travel)),
                                      SizedBox(height: AppSize.s18),
                                    ],
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
