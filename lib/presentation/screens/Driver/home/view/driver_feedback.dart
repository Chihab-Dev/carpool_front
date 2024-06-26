import 'package:carpool/app/localizations.dart';
import 'package:carpool/presentation/components/appsize.dart';
import 'package:carpool/presentation/components/color_manager.dart';
import 'package:carpool/presentation/components/strings_manager.dart';
import 'package:carpool/presentation/components/styles_manager.dart';
import 'package:carpool/presentation/components/widgets.dart';
import 'package:carpool/presentation/screens/Driver/home/cubit/driver_home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DriverFeedbackView extends StatelessWidget {
  const DriverFeedbackView(this.clientId, {super.key});

  final String clientId;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DriverHomeCubit, DriverHomeState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = DriverHomeCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            bottomOpacity: 0,
            scrolledUnderElevation: 0,
            title: Text(
              AppStrings.rateTheClient.tr(context),
              style: getRegularStyle(color: ColorManager.dark),
            ),
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: AppPadding.p18),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppStrings.rating.tr(context),
                    style: getRegularStyle(color: ColorManager.dark),
                  ),
                  SizedBox(height: AppSize.s8),
                  Text(
                    AppStrings.howWouldYouRateYourExperience.tr(context),
                    style: getMeduimStyle(color: ColorManager.darkGrey).copyWith(fontWeight: FontWeight.normal),
                  ),
                  SizedBox(height: AppSize.s8),
                  Text(
                    AppStrings.pleaseClickOnStars.tr(context),
                    style: getSmallRegularStyle(color: ColorManager.darkGrey),
                  ),
                  SizedBox(height: AppSize.s12),
                  StarRating(
                    rating: cubit.rating.toDouble(),
                    starCount: 5,
                    size: AppSize.s35,
                    onRatingChanged: (rating) {
                      cubit.changeRating(rating.toInt());
                      cubit.changeFeedbackValidation();
                    },
                  ),
                  SizedBox(height: AppSize.s12),
                  Text(
                    AppStrings.comment.tr(context),
                    style: getRegularStyle(color: ColorManager.dark),
                  ),
                  SizedBox(height: AppSize.s25),
                  CustomLargeFormField(
                    textEditingcontroller: cubit.feedbackCommentController,
                    label: AppStrings.enterYourFeedbackHere.tr(context),
                    keyboardType: TextInputType.text,
                    errorLabel: null,
                    onChanged: (value) {
                      cubit.changeFeedbackValidation();
                    },
                    icon: null,
                  ),
                  SizedBox(height: AppSize.s25),
                  state is DriverSendFeedbackLoadingState
                      ? Center(child: CircularProgressIndicator(color: ColorManager.yellow))
                      : CustomLargeButton(
                          label: AppStrings.send.tr(context),
                          onPressed: cubit.feedbackValid == false
                              ? null
                              : () async {
                                  await cubit.sendFeedback(context, clientId);
                                },
                          width: double.infinity,
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
