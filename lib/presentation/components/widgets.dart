import 'package:carpool/presentation/components/appsize.dart';
import 'package:carpool/presentation/components/color_manager.dart';
import 'package:carpool/presentation/components/styles_manager.dart';
import 'package:cherry_toast/cherry_toast.dart';
import 'package:cherry_toast/resources/arrays.dart';
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
      width: AppSize.s350,
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
      width: 350,
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
      width: 350,
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
