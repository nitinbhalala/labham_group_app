// ignore_for_file: must_be_immutable, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:minimall_store/constants/app_colors.dart';
import 'package:sizer/sizer.dart';
import '../../constants/app_fonts.dart';

Widget appTextfild(
    {hint,
    String? label,
    double? borderRadius,
    bool? isdense,
    hight,
    color,
    image,
    maxLines,
    keyboardType,
    validator,
    title,
    minline,
    controller,
    suffixIcon,
    obscureText,
    prefixIcon,
    readOnly,
    onTap,
    inputFormatters,
    horizontalpadding,
    verticalpading,
    onEditingComplete,
    textInputAction,
    Border? border,
    onChanged,
    backgroundcolor,
    enabledBorder,
    focusedBorder,
    focusedErrorBorder,
    errorBorder}) {
  return TextFormField(
    cursorColor: AppColors.GREY,
    onEditingComplete: onEditingComplete,
    onChanged: onChanged,
    onTap: onTap,
    validator: validator,
    keyboardType: keyboardType,
    controller: controller,
    inputFormatters: inputFormatters,
    autofocus: false,
    textInputAction: textInputAction ?? TextInputAction.done,
    autovalidateMode: AutovalidateMode.onUserInteraction,
    readOnly: readOnly ?? false,
    obscureText: obscureText ?? false,
    style: TextStyle(
        fontSize: 2.5.h,
        letterSpacing: 0.2,
        color: AppColors.FONT_COLOR,
        fontFamily: AppFonts.latoReguler),
    decoration: InputDecoration(
     
      isDense: isdense,
      enabledBorder: OutlineInputBorder(
        borderRadius:  BorderRadius.circular(borderRadius ??  3.w),
        borderSide: const BorderSide(width: 0.3, color: AppColors.GREY),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(borderRadius ??3.w),
        borderSide: const BorderSide(width: 0.3, color: AppColors.GREY),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(borderRadius ??3.w),
        borderSide: const BorderSide(width: 0.3, color: AppColors.RED_COLOR),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(borderRadius ??3.w),
        borderSide: const BorderSide(width: 0.3, color: AppColors.RED_COLOR),
      ),
      suffixIcon: suffixIcon,
      icon: prefixIcon,
      hintText: hint,
      errorMaxLines: 2,
      errorStyle: const TextStyle(fontSize: 10),
      hintStyle: const TextStyle(color: Color(0xFF757570), fontSize: 14),
      border: InputBorder.none,
    ),
  );
}
