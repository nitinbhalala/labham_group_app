import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:minimall_store/views/comman/app_text.dart';
import 'package:sizer/sizer.dart';
import '../../Localization/app_localization.dart';
import '../../constants/app_assets.dart';
import '../../constants/app_colors.dart';
import 'app_button.dart';

class FailOrder {
  FailOrder._();

  static void showDialog(BuildContext context) {
    var lang = AppLocalization.of(context);
    showCupertinoDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return Dialog(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4.w),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 3.h),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                 Row(
                  children: [
                    Icon(
                      Icons.cancel,
                      color: AppColors.FONT_COLOR,
                    ),
                  ],
                ),
                Image.asset(
                  AppAssets.FAIL_ORDER,
                  height: 20.h,
                  width: 35.w,
                ),
                SizedBox(height: 1.h),
                appText(
                  title: lang?.getTranslatedValue('Oops! Order Failed'),
                  fontSize: 2.h,
                  fontWeight: FontWeight.w600,
                ),
                SizedBox(height: 1.h),
                appText(
                  title:
                      lang?.getTranslatedValue('Something went tembly wrong.'),
                  textAlign: TextAlign.center,
                  fontSize: 1.8.h,
                  color: AppColors.GREY,
                ),
                SizedBox(height: 1.h),
                appButton(
                  height: 7.h,
                  child: Center(
                    child: appText(
                        title: lang?.getTranslatedValue('Please Try Again'),
                        color: AppColors.WHITE_COLOR,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                SizedBox(
                  height: 1.h,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: appText(
                      title: lang?.getTranslatedValue('Back to home'),
                      textAlign: TextAlign.center,
                      fontSize: 2.h,
                      fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
