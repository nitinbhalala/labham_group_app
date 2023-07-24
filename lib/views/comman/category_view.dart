import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_fonts.dart';
import 'app_text.dart';

Widget categoryView({
  String? title,
  String? image,
  Color? color,
  String? subtitle,
  String? fakePrice,
  String? unitnumber,
  String? price,
 
  double? width,
  double? conWidth,
  double? titleWidth,
  Widget? cachedNetworkImage,
  VoidCallback? onTap,
  VoidCallback? onAddTap,
  Widget? icon,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      height: 20.h,
      width: 40.w,
      padding: EdgeInsets.symmetric(horizontal: 1.h),
      margin: EdgeInsets.symmetric(horizontal: 1.w),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(1.8.h),
       color: AppColors.WHITE_COLOR,
      boxShadow:  [
        BoxShadow(color: AppColors.GREY.withOpacity(0.3),blurRadius: 5)
      ]
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 1.h,
          ),
          Center(
            child: SizedBox(
              height: 13.h,
              child: cachedNetworkImage ?? Image.asset(image ?? '',scale: 1.5.h,color: AppColors.PRIMERY_COLOR,),
            ),
          ),
          SizedBox(height: 0.5.h),
          SizedBox(
            width: titleWidth,
            child: appText(
                title: title,
                fontWeight: FontWeight.w600,
                fontFamily: AppFonts.latoBold,
                color: AppColors.FONT_COLOR,
                maxLines: 1,
                textOverflow: TextOverflow.ellipsis),
          ),
          SizedBox(
            height: 0.5.h,
          )
        ],
      ),
    ),
  );
}
