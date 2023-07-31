import 'package:flutter/material.dart';
import 'package:minimall_store/constants/app_assets.dart';
import 'package:minimall_store/constants/app_colors.dart';
import 'package:minimall_store/views/comman/app_text.dart';
import 'package:minimall_store/views/pages/authPage/login_page.dart';
import 'package:sizer/sizer.dart';

import '../../Localization/app_localization.dart';
import '../comman/app_button.dart';

class IntroPage extends StatelessWidget {
  const IntroPage({super.key});

  @override
  Widget build(BuildContext context) {
    var lang = AppLocalization.of(context);
    return Scaffold(
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Image.asset(
            AppAssets.INTRO_IMAGE,
            filterQuality: FilterQuality.high,
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          Padding(
            padding:  EdgeInsets.symmetric(horizontal: 0.5.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
               
                appText(
                    title: lang?.getTranslatedValue('Welcome To Labham Group'),
                    color: AppColors.WHITE_COLOR,
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    fontSize: 4.h,
                    fontWeight: FontWeight.w600),
              
                SizedBox(
                  height: 3.h,
                ),
                appButton(
                  onTap: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginPage(),
                        ));
                  },
                  child: Center(
                    child: appText(
                        title: lang?.getTranslatedValue('Get Started') ?? '',
                        color: AppColors.WHITE_COLOR,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                SizedBox(
                  height: 8.h,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
