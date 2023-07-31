// ignore_for_file: implementation_imports, avoid_print, deprecated_member_use

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:minimall_store/constants/app_assets.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../Localization/app_localization.dart';
import '../../../constants/app_colors.dart';
import '../../../constants/app_fonts.dart';
import '../../../constants/constants.dart';
import '../../comman/app_text.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({super.key});

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  String? _version;

  void _getAppVersion() async {
    final PackageInfo packageInfo = await PackageInfo.fromPlatform();
    final version = packageInfo.version;
    setState(() {
      _version = version;
    });
  }

  @override
  void initState() {
    _getAppVersion();
    super.initState();
  }

  void openSoftXWebsite() async {
    const url = Constants.softXWebsite;
    if (await canLaunch(url)) {
      await launch(url);
      //  Navigator.pop(context);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    var lang = AppLocalization.of(context);
    return Scaffold(
      backgroundColor: AppColors.PRIMERY_COLOR,
      appBar: AppBar(
        backgroundColor: AppColors.PRIMERY_COLOR,
         iconTheme: const IconThemeData(color: AppColors.WHITE_COLOR),
        centerTitle: true,
        automaticallyImplyLeading: true,
        title: appText(
          title: lang?.getTranslatedValue('About'),
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
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: 5.h,
              ),
              Container(
                width: 80.w,
                padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 3.w),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(1.6.h),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.withOpacity(0.5), blurRadius: 20)
                    ]),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Image.asset(
                      AppAssets.LABHAM_LOGO,
                      scale: 1.5.h,
                    ),
                    SizedBox(
                      height: 1.6.h,
                    ),
                    appText(
                        title: lang?.getTranslatedValue('Labham Group'),
                        color: AppColors.FONT_COLOR,
                        fontWeight: FontWeight.w600,
                        fontSize: 2.5.h),
                    SizedBox(
                      height: 2.h,
                    ),
                    appText(
                        title: _version,
                        color: AppColors.FONT_COLOR,
                        fontSize: 1.8.h),
                    SizedBox(
                      height: 1.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        appText(
                            title: lang?.getTranslatedValue('Made with ❤ By'),
                            color: AppColors.FONT_COLOR,
                            fontSize: 1.5.h),
                        SizedBox(
                          height: 4.h,
                          child: GestureDetector(
                            onTap: () {
                              openSoftXWebsite();
                            },
                            child: CachedNetworkImage(
                                imageUrl: AppAssets.SOFTX,
                                progressIndicatorBuilder:
                                    (context, url, progress) {
                                  return Center(
                                      child:
                                          Image.asset(AppAssets.LABHAM_LOGO));
                                }),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
