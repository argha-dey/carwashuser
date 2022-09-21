import 'package:famous_steam_user/const/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final String hintText;
  final bool? obscureText;
  final String? Function(String?)? validateName;
  final Function(String)? onFieldSubmitted;
  final Function(String)? onchange;

  final TextInputType? textInputType;
  final TextInputAction? textInputAction;
  final TextInputType? keyboardType;
  final FocusNode focusNode;
  final bool? enableDisable;
  final GestureTapCallback ontap;
  const CustomTextField({
    Key? key,
    required this.controller,
    required this.labelText,
    required this.hintText,
    this.obscureText,
    this.validateName,
    this.onFieldSubmitted,
    this.onchange,
    this.textInputType,
    this.keyboardType,
    required this.focusNode,
    this.textInputAction,
    this.enableDisable,
    required this.ontap,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: ontap,
      onChanged: onchange,
      controller: controller,
      autovalidateMode: AutovalidateMode.disabled,
      validator: validateName,
      keyboardType: keyboardType ?? TextInputType.emailAddress,
      textInputAction: textInputAction,
      onFieldSubmitted: onFieldSubmitted,
      focusNode: focusNode,
      obscureText: obscureText ?? false,
      enabled: enableDisable,
      style:
          GoogleFonts.montserrat(fontSize: 12.sp, color: AppColor.greyColor1),
      decoration: InputDecoration(
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: AppColor.appColor),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(3.w),
          borderSide: const BorderSide(
            color: AppColor.appColor,
          ),
        ),
        labelText: labelText,
        labelStyle: GoogleFonts.montserrat(
          fontSize: 11.sp,
          color: AppColor.greyColor1.withOpacity(0.5),
        ),
        hintText: hintText,
        hintStyle: GoogleFonts.montserrat(
          fontSize: 12.sp,
          color: AppColor.greyColor1,
        ),
      ),
    );
  }
}
