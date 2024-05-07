import 'package:carpool/presentation/components/appsize.dart';
import 'package:carpool/presentation/components/color_manager.dart';
import 'package:carpool/presentation/components/styles_manager.dart';
import 'package:carpool/presentation/components/widgets.dart';
import 'package:carpool/presentation/screens/Client/home/cubit/home_cubit.dart';
import 'package:carpool/presentation/screens/Client/home/view/travel_details_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TravelsView extends StatelessWidget {
  const TravelsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = HomeCubit.get(context);
        return Scaffold(
          body: Padding(
            padding: EdgeInsets.all(AppSize.s18).copyWith(top: 0.0),
            child: SingleChildScrollView(
              physics: const ScrollPhysics(),
              child: Center(
                child: Column(
                  children: [
                    SizedBox(height: MediaQuery.of(context).padding.top),
                    Container(
                      width: AppSize.s350,
                      height: AppSize.s70,
                      decoration: BoxDecoration(
                        color: ColorManager.lightGrey,
                        borderRadius: BorderRadius.circular(AppPadding.p10),
                      ),
                      child: Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: const Icon(Icons.arrow_back_ios_new_rounded),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${cubit.pickedFromLocation?.address.toString().split(',').first}  →  ${cubit.pickedToLocation?.address.toString().split(',').first}',
                                style: getMeduimStyle(color: ColorManager.dark).copyWith(fontSize: AppSize.s16),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                '${cubit.selectedDate.toString().substring(0, 10)}  ,  ${cubit.numberOfPlaces} person',
                                style: getSmallRegularStyle(color: ColorManager.dark),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    state is HomeGetTravelLoadingState
                        ? Container(
                            margin: EdgeInsets.only(top: AppSize.s50),
                            child: CircularProgressIndicator(
                              color: ColorManager.yellow,
                            ),
                          )
                        : ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: cubit.travels.length,
                            itemBuilder: (context, index) {
                              return travelDetailsContainer(
                                  context, cubit.travels[index], TravelDetailsView(cubit.travels[index]));
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
