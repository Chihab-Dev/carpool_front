import 'package:carpool/presentation/components/appsize.dart';
import 'package:carpool/presentation/components/color_manager.dart';
import 'package:carpool/presentation/components/styles_manager.dart';
import 'package:flutter/material.dart';

class CustomLargeButton extends StatelessWidget {
  final String label;
  final Function()? onPressed;
  const CustomLargeButton({
    super.key,
    required this.label,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 350,
      height: 50,
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
