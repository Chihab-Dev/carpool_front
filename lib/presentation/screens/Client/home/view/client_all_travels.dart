import 'package:carpool/app/localizations.dart';
import 'package:carpool/presentation/components/appsize.dart';
import 'package:carpool/presentation/components/assets_manager.dart';
import 'package:carpool/presentation/components/color_manager.dart';
import 'package:carpool/presentation/components/strings_manager.dart';
import 'package:carpool/presentation/components/styles_manager.dart';
import 'package:carpool/presentation/components/widgets.dart';
import 'package:carpool/presentation/screens/Client/home/cubit/home_cubit.dart';
import 'package:carpool/presentation/screens/Client/home/view/client_travel_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

class ClientAllTravelsView extends StatefulWidget {
  const ClientAllTravelsView({super.key});

  @override
  State<ClientAllTravelsView> createState() => _ClientAllTravelsViewState();
}

class _ClientAllTravelsViewState extends State<ClientAllTravelsView> {
  @override
  void initState() {
    super.initState();
    if (HomeCubit.get(context).myTravels.isEmpty) {
      HomeCubit.get(context).getClientTravels(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = HomeCubit.get(context);
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
                    cubit.getClientTravels(context);
                  },
                  icon: const Icon(Icons.replay_outlined))
            ],
          ),
          body: state is HomeGetTravelsLoadingState
              ? Center(
                  child: CircularProgressIndicator(
                    color: ColorManager.yellow,
                  ),
                )
              : cubit.myTravels.isEmpty
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
                                itemCount: cubit.myTravels.length,
                                itemBuilder: (context, index) {
                                  return travelDetailsContainer(
                                    context,
                                    cubit.myTravels[index],
                                    ClientTravelView(
                                      cubit.myTravels[index],
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
