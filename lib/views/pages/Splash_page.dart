// ignore_for_file: file_names, unused_element, avoid_print

import 'package:flutter/material.dart';
import 'package:minimall_store/constants/app_assets.dart';
import 'package:minimall_store/constants/app_colors.dart';
import 'package:minimall_store/services/api_services.dart';
import 'package:minimall_store/views/pages/Bottombar_page.dart';
import 'package:minimall_store/views/pages/select_language.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  bool? isLogin;
  String? userType;

  ApiServices apiServices = ApiServices();
  _getData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isLogin = prefs.getBool('status');
      userType = prefs.getString('userType');
      prefs.setBool('ispopupShow', false);
    });
  }

  Future<dynamic> getData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final data = await apiServices.getTermsAndCondition();
    print(data['data']['privacy_policy_url']);
    prefs.setString('privacy_policy_url', data['data']['privacy_policy_url']);
    print("GET DATA PRIVACY POLICY:- ${data['data']}");
    return data['data'];
  }

  @override
  void initState() {
    _getData();
 getData();
    Future.delayed(const Duration(seconds: 3), () {
      (isLogin == true)
          ? Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => BottomBarPage(
                        index: 0,
                      )))
          : Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => const SelectLanguagePage()));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.WHITE_COLOR,
      body: Center(
          child: Image.asset(
        AppAssets.LABHAM_LOGO,
        height: 30.h,
      )),
    );
  }
}
