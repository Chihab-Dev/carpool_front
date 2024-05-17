import 'package:carpool/app/service_locator.dart';
import 'package:carpool/app/shared_prefrences.dart';
import 'package:carpool/data/models/models.dart';
import 'package:carpool/presentation/components/appsize.dart';
import 'package:carpool/presentation/components/assets_manager.dart';
import 'package:carpool/presentation/components/color_manager.dart';
import 'package:carpool/presentation/components/styles_manager.dart';
import 'package:carpool/presentation/screens/auth/travellerOrDriver/travellerOrDriver.dart';
import 'package:cherry_toast/cherry_toast.dart';
import 'package:cherry_toast/resources/arrays.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:timeline_tile/timeline_tile.dart';

class CustomLargeButton extends StatelessWidget {
  final String label;
  final Function()? onPressed;
  final Color? color;
  final double? width;
  const CustomLargeButton({
    super.key,
    this.color,
    this.width,
    required this.label,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? AppSize.s350,
      height: AppSize.s55,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: color ?? ColorManager.yellow,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppPadding.p10),
          ),
        ),
        child: Text(
          label,
          style: getMeduimStyle(color: ColorManager.white),
        ),
      ),
    );
  }
}

class CustomMediumButton extends StatelessWidget {
  final String label;
  final Function()? onPressed;
  const CustomMediumButton({
    super.key,
    required this.label,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: AppSize.s300,
      height: AppSize.s55,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: ColorManager.yellow,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppPadding.p10),
          ),
        ),
        child: Text(
          label,
          style: getMeduimStyle(color: ColorManager.white),
        ),
      ),
    );
  }
}

class CustomFormField extends StatelessWidget {
  final TextEditingController textEditingcontroller;
  final String label;
  final TextInputType? keyboardType;
  final String? errorLabel;
  final Function(String) onChanged;
  final IconData? icon;
  const CustomFormField({
    super.key,
    required this.textEditingcontroller,
    required this.label,
    required this.keyboardType,
    required this.errorLabel,
    required this.onChanged,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: AppSize.s350,
      child: TextFormField(
        controller: textEditingcontroller,
        keyboardType: keyboardType,
        onChanged: onChanged,
        decoration: InputDecoration(
          errorText: errorLabel,
          suffixIcon: Icon(
            icon,
            color: ColorManager.dark.withOpacity(0.5),
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: AppPadding.p20, vertical: AppPadding.p16),
          // floatingLabelBehavior: FloatingLabelBehavior.never,
          border: InputBorder.none,
          filled: true,
          fillColor: ColorManager.lightGrey,
          alignLabelWithHint: true,
          label: Text(
            label,
            style: getSmallLightStyle(color: ColorManager.dark.withOpacity(0.5)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppSize.s10),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppSize.s10),
            borderSide: BorderSide.none,
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppSize.s10),
            borderSide: BorderSide.none,
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppSize.s10),
            borderSide: BorderSide.none,
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppSize.s10),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}

class CustomPasswordFormField extends StatelessWidget {
  final TextEditingController textEditingcontroller;
  final String label;
  final String? errorLabel;
  final TextInputType keyboardType;
  final Function(String) onChanged;
  final Function() onVisibleChanged;
  final bool isPasswordVisible;

  const CustomPasswordFormField({
    super.key,
    required this.textEditingcontroller,
    required this.label,
    required this.errorLabel,
    required this.keyboardType,
    required this.onChanged,
    required this.onVisibleChanged,
    required this.isPasswordVisible,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: AppSize.s350,
      child: TextFormField(
        keyboardType: keyboardType,
        obscureText: isPasswordVisible,
        onChanged: onChanged,
        controller: textEditingcontroller,
        decoration: InputDecoration(
          suffixIcon: IconButton(
            onPressed: onVisibleChanged,
            icon: Icon(
              isPasswordVisible ? Icons.visibility_off_rounded : Icons.visibility_rounded,
              color: ColorManager.dark.withOpacity(0.5),
            ),
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: AppPadding.p20, vertical: AppPadding.p16),
          // floatingLabelBehavior: FloatingLabelBehavior.never,
          border: InputBorder.none,
          filled: true,
          fillColor: ColorManager.lightGrey,
          alignLabelWithHint: true,
          label: Text(
            label,
            style: getSmallLightStyle(color: ColorManager.dark.withOpacity(0.5)),
          ),
          errorText: errorLabel,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppSize.s10),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppSize.s10),
            borderSide: BorderSide.none,
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppSize.s10),
            borderSide: BorderSide.none,
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppSize.s10),
            borderSide: BorderSide.none,
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppSize.s10),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}

Container separator() {
  return Container(
    margin: EdgeInsets.symmetric(vertical: AppSize.s25),
    width: double.infinity,
    height: AppSize.s4,
    color: ColorManager.darkGrey.withOpacity(0.2),
  );
}

Row customSeparator(String text) {
  return Row(
    children: [
      Expanded(
        child: separator(),
      ),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: AppPadding.p18),
        child: Text(
          text,
          style: getMeduimStyle(color: ColorManager.dark),
        ),
      ),
      Expanded(
        child: separator(),
      ),
    ],
  );
}

class CustomSmallButton extends StatelessWidget {
  final String label;
  final Function()? onPressed;
  final Color? backgroundColor;
  const CustomSmallButton({super.key, required this.label, required this.onPressed, required this.backgroundColor});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // width: AppSize.s100,
      // height: AppSize.s55,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppPadding.p10),
          ),
        ),
        child: Text(
          label,
          style: getMeduimStyle(color: ColorManager.white).copyWith(fontSize: AppSize.s15),
        ),
      ),
    );
  }
}

// Toasts ::

CherryToast errorToast(String msg) {
  return CherryToast.error(
    title: Text(msg, style: const TextStyle(color: Colors.red)),
    backgroundColor: ColorManager.white,
    toastPosition: Position.bottom,
    toastDuration: const Duration(seconds: 5),
  );
}

CherryToast successToast(String msg) {
  return CherryToast.success(
    title: Text(msg, style: TextStyle(color: ColorManager.yellow)),
    toastPosition: Position.bottom,
    toastDuration: const Duration(seconds: 5),
  );
}

String calculateAgeFromString(String dobString) {
  DateTime dateOfBirth = DateTime.parse(dobString.substring(0, 10));
  final now = DateTime.now();
  int age = now.year - dateOfBirth.year;
  if (now.month < dateOfBirth.month || (now.month == dateOfBirth.month && now.day < dateOfBirth.day)) {
    age--;
  }
  return "$age years old";
}

Widget travelDetailsContainer(BuildContext context, TravelModel travel, Widget onTapWidget) {
  return InkWell(
    onTap: () {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => onTapWidget,
          ));
    },
    child: Container(
      width: AppSize.s350,
      // height: AppSize.s250,
      margin: EdgeInsets.symmetric(horizontal: AppSize.s20, vertical: AppSize.s15),
      padding: EdgeInsets.all(AppPadding.p18),
      decoration: BoxDecoration(
        color: ColorManager.white,
        borderRadius: BorderRadius.circular(AppSize.s10),
        boxShadow: [
          BoxShadow(
            blurRadius: 3,
            blurStyle: BlurStyle.inner,
            offset: const Offset(0, 0),
            color: ColorManager.dark,
          )
        ],
      ),
      child: Column(
        children: [
          TimelineTile(
            alignment: TimelineAlign.manual,
            lineXY: 0.25.sp,
            isFirst: true,
            indicatorStyle: IndicatorStyle(
              height: 25,
              width: 25,
              color: ColorManager.yellow,
              padding: EdgeInsets.symmetric(horizontal: AppPadding.p10),
              iconStyle: IconStyle(
                color: Colors.white,
                iconData: Icons.home,
                fontSize: 20,
              ),
            ),
            startChild: Text(
              travel.timeOfDeparture,
              style: getMeduimStyle(color: ColorManager.dark).copyWith(fontSize: AppSize.s16),
            ),
            endChild: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    travel.placeOfDeparture.split(',').first,
                    style: getMeduimStyle(color: ColorManager.dark).copyWith(fontSize: AppSize.s16),
                  ),
                ),
                // const Spacer(),
                SizedBox(width: AppSize.s20),
                Text(
                  "${travel.placePrice} DA",
                  style: getMeduimStyle(color: ColorManager.dark).copyWith(fontSize: AppSize.s16),
                ),
              ],
            ),
          ),
          SizedBox(
            height: AppSize.s50,
            child: TimelineTile(
              alignment: TimelineAlign.manual,
              lineXY: 0.25.sp,
              hasIndicator: false,
            ),
          ),
          TimelineTile(
            alignment: TimelineAlign.manual,
            lineXY: 0.25.sp,
            isLast: true,
            indicatorStyle: IndicatorStyle(
              height: 25,
              width: 25,
              color: ColorManager.yellow,
              padding: EdgeInsets.symmetric(horizontal: AppPadding.p10),
              iconStyle: IconStyle(
                color: Colors.white,
                iconData: Icons.location_on,
                fontSize: 20,
              ),
            ),
            startChild: Text(
              travel.timeOfArrival,
              style: getMeduimStyle(color: ColorManager.dark).copyWith(fontSize: AppSize.s16),
            ),
            endChild: Text(
              travel.placeOfArrival.split(',').first,
              style: getMeduimStyle(color: ColorManager.dark).copyWith(fontSize: AppSize.s16),
            ),
          ),
          SizedBox(height: AppSize.s30),
          Row(
            children: [
              CircleAvatar(
                radius: AppSize.s30,
                backgroundColor: ColorManager.lightGrey,
                backgroundImage: const AssetImage(ImageAsset.profilePicture),
              ),
              SizedBox(width: AppSize.s12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${travel.driver.name} ${travel.driver.familyname}',
                    style: getMeduimStyle(color: ColorManager.dark).copyWith(fontSize: AppSize.s16),
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.star_purple500_sharp,
                        size: AppSize.s18,
                        color: ColorManager.yellow,
                      ),
                      SizedBox(width: AppSize.s5),
                      Text(
                        travel.driver.feedbackes.length.toString(),
                        style: getMeduimStyle(color: ColorManager.dark).copyWith(fontSize: AppSize.s16),
                      ),
                    ],
                  )
                ],
              ),
              const Spacer(),
              SizedBox(width: AppSize.s12),
              Icon(
                FontAwesomeIcons.cartFlatbedSuitcase,
                size: AppSize.s25,
                color: ColorManager.dark,
              ),
              SizedBox(width: AppSize.s12),
              Text(
                travel.baggage,
                style: getMeduimStyle(color: ColorManager.dark),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}

typedef RatingChangeCallback = void Function(double rating);

class StarRating extends StatelessWidget {
  final int starCount;
  final double rating;
  final RatingChangeCallback? onRatingChanged;
  final double? size;

  const StarRating({super.key, this.starCount = 5, this.rating = .0, this.onRatingChanged, this.size});

  Widget buildStar(BuildContext context, int index) {
    Icon icon;
    if (index >= rating) {
      icon = Icon(
        Icons.star_border,
        size: size,
        color: ColorManager.darkGrey,
      );
    } else if (index > rating - 1 && index < rating) {
      icon = Icon(
        Icons.star_half,
        size: size,
        color: ColorManager.yellow,
      );
    } else {
      icon = Icon(
        Icons.star,
        size: size,
        color: ColorManager.yellow,
      );
    }
    return InkResponse(
      onTap: onRatingChanged == null ? null : () => onRatingChanged!(index + 1.0),
      child: icon,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(children: List.generate(starCount, (index) => buildStar(context, index)));
  }
}

class CustomLargeFormField extends StatelessWidget {
  final TextEditingController textEditingcontroller;
  final String label;
  final TextInputType? keyboardType;
  final String? errorLabel;
  final Function(String) onChanged;
  final IconData? icon;
  const CustomLargeFormField({
    super.key,
    required this.textEditingcontroller,
    required this.label,
    required this.keyboardType,
    required this.errorLabel,
    required this.onChanged,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: 12,
      maxLength: 200,
      controller: textEditingcontroller,
      keyboardType: keyboardType,
      onChanged: onChanged,
      decoration: InputDecoration(
        errorText: errorLabel,
        suffixIcon: Icon(
          icon,
          color: ColorManager.dark.withOpacity(0.5),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: AppPadding.p14, vertical: AppPadding.p16),
        // floatingLabelBehavior: FloatingLabelBehavior.never,
        border: InputBorder.none,
        filled: true,
        fillColor: ColorManager.lightGrey,
        alignLabelWithHint: true,
        label: Text(
          label,
          style: getSmallLightStyle(color: ColorManager.dark.withOpacity(0.5)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSize.s10),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSize.s10),
          borderSide: BorderSide.none,
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSize.s10),
          borderSide: BorderSide.none,
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSize.s10),
          borderSide: BorderSide.none,
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSize.s10),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}

void logout(BuildContext context) {
  AppPrefences appPrefences = AppPrefences(getIt());
  appPrefences.removeId();
  appPrefences.removeRole();
  appPrefences.removeToken();
  Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => const TravellerOrDriverView(),
      ),
      (route) => false);
}
