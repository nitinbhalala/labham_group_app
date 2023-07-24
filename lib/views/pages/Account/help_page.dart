// ignore_for_file: implementation_imports, avoid_print

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../../Localization/app_localization.dart';
import '../../../constants/app_colors.dart';
import '../../../constants/app_fonts.dart';
import '../../../constants/constants.dart';
import '../../comman/app_button.dart';
import '../../comman/app_text.dart';
import '../../comman/function.dart';

class HelpPage extends StatefulWidget {
  const HelpPage({super.key});

  @override
  State<HelpPage> createState() => _HelpPageState();
}

class _HelpPageState extends State<HelpPage> {

   Functions functions = Functions();
 

  @override
  Widget build(BuildContext context) {
    var lang = AppLocalization.of(context);
    return Scaffold(
      backgroundColor: AppColors.PRIMERY_COLOR,
      appBar: AppBar(
        backgroundColor: AppColors.PRIMERY_COLOR,
        centerTitle: true,
        automaticallyImplyLeading: true,
          iconTheme: const IconThemeData(color: AppColors.WHITE_COLOR),
        title: appText(
          title: lang?.getTranslatedValue('Help'),
          fontFamily: AppFonts.latoBold,
          fontWeight: FontWeight.w700,
          color: AppColors.WHITE_COLOR,
        ),
        elevation: 0,
      ),
      body: Container(
         height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
            color: AppColors.WHITE_COLOR,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(7.w), topRight: Radius.circular(7.w))),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 5.h,
              ),
              Container(
                height: 10.h,
                width: 90.w,
                decoration: BoxDecoration(
                    color: AppColors.PRODUCT_BACK,
                    borderRadius: BorderRadius.circular(4.w)),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 2.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.smartphone,
                            size: 3.5.h,
                          ),
                          SizedBox(
                            width: 3.w,
                          ),
                          appText(
                            title: lang?.getTranslatedValue('Call us'),
                            fontFamily: AppFonts.latoBold,
                            fontSize: 2.5.h,
                            fontWeight: FontWeight.w700,
                            color: AppColors.FONT_COLOR,
                          ),
                        ],
                      ),
                      appButton(
                        height: 10.w,
                        width: 10.w,
                        child: const Center(
                          child: Icon(
                            Icons.call_outlined,
                            color: AppColors.WHITE_COLOR,
                          ),
                        ),
                        color: AppColors.PRIMERY_COLOR,
                        onTap: () {
                        functions.launchPhoneCall(Constants.phone);
                        },
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 2.h,
              ),
              Container(
                height: 10.h,
                width: 90.w,
                decoration: BoxDecoration(
                    color: AppColors.PRODUCT_BACK,
                    borderRadius: BorderRadius.circular(4.w)),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 2.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.email,
                            size: 3.5.h,
                          ),
                          SizedBox(
                            width: 3.w,
                          ),
                          appText(
                            title: lang?.getTranslatedValue('Email us'),
                            fontFamily: AppFonts.latoBold,
                            fontSize: 2.5.h,
                            letterSpacing: 0,
                            fontWeight: FontWeight.w700,
                            color: AppColors.FONT_COLOR,
                          ),
                        ],
                      ),
                      appButton(
                        height: 10.w,
                        width: 10.w,
                        child: const Center(
                          child: Icon(
                            Icons.email,
                            color: AppColors.WHITE_COLOR,
                          ),
                        ),
                        color: AppColors.PRIMERY_COLOR,
                        onTap: () {
                          functions.launchEmail(Constants.email);
                        },
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
