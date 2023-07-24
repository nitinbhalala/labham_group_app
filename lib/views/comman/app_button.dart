import 'package:flutter/material.dart';
import 'package:minimall_store/constants/app_colors.dart';
import 'package:sizer/sizer.dart';

Widget appButton({
  Widget? child,
  VoidCallback? onTap,
  Color? color,
  Color? borderColor,
  double? margin,
  double? width,
  double? height,
  verticalmargin,
  double? radius,
  Widget? icon,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
        height: height ?? 7.h,
        width: width ?? 80.w,
      
        decoration: BoxDecoration(
          color: color ?? AppColors.PRIMERY_COLOR,
          borderRadius: BorderRadius.circular(radius ?? 7.h),
        ),
        child: Center(child: child)),
  );
}
