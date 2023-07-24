import 'package:flutter/cupertino.dart';
import 'package:sizer/sizer.dart';
import '../../constants/app_assets.dart';
import '../../constants/app_colors.dart';
import 'app_text.dart';

Widget noFound({
  title,
  height
}) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
    Image.asset(
      AppAssets.LABHAM_LOGO,
      color: AppColors.LIGHT_GREY,
      scale: height?? 0.5.h,
    ),
    appText(title: title, color: AppColors.GREY)
  ]);
}
