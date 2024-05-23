import 'package:carpool/app/localizations.dart';
import 'package:carpool/presentation/components/appsize.dart';
import 'package:carpool/presentation/components/assets_manager.dart';
import 'package:carpool/presentation/components/color_manager.dart';
import 'package:carpool/presentation/components/strings_manager.dart';
import 'package:carpool/presentation/components/styles_manager.dart';
import 'package:carpool/presentation/components/widgets.dart';
import 'package:carpool/presentation/screens/Driver/home/cubit/driver_home_cubit.dart';
import 'package:carpool/presentation/screens/Driver/home/view/driver_my_travel_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

class DriverAllTravelsView extends StatefulWidget {
  const DriverAllTravelsView({super.key});

  @override
  State<DriverAllTravelsView> createState() => _DriverAllTravelsViewState();
}

class _DriverAllTravelsViewState extends State<DriverAllTravelsView> {
  @override
  void initState() {
    super.initState();
    if (DriverHomeCubit.get(context).allMyTravels.isEmpty) {
      DriverHomeCubit.get(context).getMyTravels(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DriverHomeCubit, DriverHomeState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = DriverHomeCubit.get(context);
        return Scaffold(
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            bottomOpacity: 0,
            scrolledUnderElevation: 0,
            title: Text(
              AppStrings.yourTravels.tr(context),
              style: getRegularStyle(color: ColorManager.dark),
            ),
            actions: [
              IconButton(
                  onPressed: () {
                    cubit.getMyTravels(context);
                  },
                  icon: const Icon(Icons.replay_outlined))
            ],
          ),
          body: state is DriverGetTravelByIdLoadingState
              ? Center(
                  child: CircularProgressIndicator(
                    color: ColorManager.yellow,
                  ),
                )
              : cubit.allMyTravels.isEmpty
                  ? Center(
                      child: Lottie.asset(LottieAsset.empty),
                    )
                  : Padding(
                      padding: EdgeInsets.symmetric(horizontal: AppPadding.p18),
                      child: Center(
                        child: Column(
                          children: [
                            Expanded(
                              child: ListView.builder(
                                shrinkWrap: false,
                                itemCount: cubit.allMyTravels.length,
                                itemBuilder: (context, index) {
                                  return travelDetailsContainer(
                                    context,
                                    cubit.allMyTravels[index],
                                    DriverMyTravelView(
                                      cubit.allMyTravels[index],
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
        );
      },
    );
  }
}
