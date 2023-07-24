// ignore_for_file: use_build_context_synchronously, unused_local_variable

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:minimall_store/constants/app_colors.dart';
import 'package:minimall_store/views/comman/app_button.dart';
import 'package:minimall_store/views/comman/app_text.dart';
import 'package:minimall_store/views/pages/intro_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import '../../main.dart';

class SelectLanguagePage extends StatefulWidget {
  const SelectLanguagePage({super.key});

  @override
  State<SelectLanguagePage> createState() => _SelectLanguagePageState();
}

class _SelectLanguagePageState extends State<SelectLanguagePage> {
  Locale? _temp;
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8),
                child: appText(
                  title: 'Select Language',
                  letterSpacing: 1,
                  fontSize: 24,
                  maxLines: 4,
                  textAlign: TextAlign.center,
                  fontWeight: FontWeight.bold,
                  height: 1.5,
                ),
              ),
              SizedBox(
                height: 1.h,
              ),
              appButton(
                child: Center(
                  child: appText(
                    title: 'English',
                    color: AppColors.WHITE_COLOR,
                  ),
                ),
                color: AppColors.PRIMERY_COLOR,
                onTap: () async {
                  final prefs = await SharedPreferences.getInstance();
                  setState(() {
                    _temp = const Locale('en', 'US');
                    prefs.setString("language", 'en');
                    MyApp.setLocale(context, _temp!);
                  });

                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const IntroPage()));
                },
                // onTap: () async {
                //   final prefs = await SharedPreferences.getInstance();
                //   prefs.setString("language", 'en');
                //   prefs.setString("languageCode", 'US');
                //   setState(() {
                //     _temp = const Locale('en', 'US');

                //     MyApp.setLocale(context, _temp!);
                //   });
                //   Navigator.pushReplacement(
                //       context,
                //       MaterialPageRoute(
                //           builder: (context) => const IntroPage()));
                // },
              ),
              SizedBox(
                height: 3.h,
              ),
              appButton(
                child: Center(
                  child: appText(
                    title: 'ગુજરાતી',
                    color: AppColors.WHITE_COLOR,
                  ),
                ),
                color: AppColors.PRIMERY_COLOR,
                onTap: () async {
                  final prefs = await SharedPreferences.getInstance();
                  setState(() {
                    _temp = const Locale('gu', 'US');
                    
                    prefs.setString("language", 'gu');
                    MyApp.setLocale(context, _temp!);
                  });
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const IntroPage()));
                },
                // onTap: () async {
                //   final prefs = await SharedPreferences.getInstance();
                //   prefs.setString("language", 'gu');
                //   prefs.setString("languageCode", 'US');
                //   setState(() {
                //     _temp = const Locale('gu', 'US');

                //     MyApp.setLocale(context, _temp!);
                //   });
                //   Navigator.pushReplacement(
                //       context,
                //       MaterialPageRoute(
                //           builder: (context) => const IntroPage()));
                // },
              )
            ],
          ),
        ),
      ),
    );
  }
}
