import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:minimall_store/views/comman/app_button.dart';
import 'package:minimall_store/views/comman/app_text.dart';
import 'package:sizer/sizer.dart';

import '../../Localization/app_localization.dart';
import '../../constants/app_assets.dart';
import '../../constants/app_colors.dart';

class AppDialog {
  AppDialog._();

  static Future<bool> showDialog(BuildContext context,
      {String? title, String? message}) async {
    var lang = AppLocalization.of(context);
    return await showCupertinoDialog(
      context: context,
      builder: (context) {
        return Dialog(
          elevation: 0,
          backgroundColor: AppColors.WHITE_COLOR,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(2.h),
          ),
          child: Container(
            padding: EdgeInsets.all(2.h),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                appText(
                    title: title,
                    maxLines: 2,
                    color: AppColors.PRIMERY_COLOR,
                    fontWeight: FontWeight.w600),
                SizedBox(height: 2.h),
                appText(
                  title: message,
                  textAlign: TextAlign.center,
                  maxLines: 3,
                ),
                SizedBox(height: 3.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    appButton(
                      height: 6.h,
                      width: 25.w,
                      child: Center(
                          child: appText(
                              title: '${lang?.getTranslatedValue('No')}',
                              color: AppColors.WHITE_COLOR,
                              fontWeight: FontWeight.w600)),
                      onTap: () {
                        Navigator.pop(context, false);
                      },
                    ),
                    appButton(
                      height: 6.h,
                      width: 25.w,
                      child: Center(
                        child: appText(
                            title: '${lang?.getTranslatedValue('Yes')}',
                            color: AppColors.WHITE_COLOR,
                            fontWeight: FontWeight.w600),
                      ),
                      onTap: () {
                        Navigator.pop(context, true);
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  static Future<bool> showInternetDialog(BuildContext context,
      {VoidCallback? onTap}) async {
    var lang = AppLocalization.of(context);
    return await showCupertinoDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return WillPopScope(
          onWillPop: () async{
            return false;
          },
          child: Dialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: SizedBox(
              height: 40.h,
              child: Column(
                children: [
                  SizedBox(
                    height: 2.h,
                  ),
                  appText(
                      title: lang?.getTranslatedValue('No Internet Connection'),
                      maxLines: 2,
                      textOverflow: TextOverflow.ellipsis,
                      fontWeight: FontWeight.w600),
                  SizedBox(
                    height: 2.h,
                  ),
                  Image.asset(
                    AppAssets.INTERNET,
                    scale: 2.h,
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  appText(
                      title: lang?.getTranslatedValue(
                          'Please check your internet connection.'),
                      maxLines: 2,
                      textOverflow: TextOverflow.ellipsis),
                  SizedBox(
                    height: 2.h,
                  ),
                  appButton(
                      width: 60.w,
                      onTap: onTap,
                      child: Center(
                        child: appText(
                            title: lang?.getTranslatedValue('Retry'),
                            color: AppColors.WHITE_COLOR,
                            maxLines: 2),
                      ))
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
