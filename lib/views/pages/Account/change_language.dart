// ignore_for_file: implementation_imports, use_build_context_synchronously, unused_local_variable, unnecessary_brace_in_string_interps, avoid_print

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:minimall_store/services/api_services.dart';
import 'package:minimall_store/views/comman/loader.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import '../../../Localization/app_localization.dart';
import '../../../constants/app_colors.dart';
import '../../../constants/app_fonts.dart';
import '../../../main.dart';
import '../../comman/app_button.dart';
import '../../comman/app_dialogs.dart';
import '../../comman/app_text.dart';
import '../../comman/connectivity_check.dart';

class ChangeLanguagePage extends StatefulWidget {
  const ChangeLanguagePage({super.key});

  @override
  State<ChangeLanguagePage> createState() => _PromocardPageState();
}

class _PromocardPageState extends State<ChangeLanguagePage> {
  Locale? _temp;
  bool? isConnected;
  getinternet() async {
    isConnected = await ConnectivityService.isConnected;
    if (isConnected == false) {
      AppDialog.showInternetDialog(
        context,
        onTap: () {
          Navigator.pop(context);
          getinternet();
        },
      );
    }
  }

  ApiServices apiServices = ApiServices();

  bool isLoading = false;
  bool isGujLoading = false;

  @override
  void initState() {
    getinternet();
    super.initState();
  }

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
          title: lang?.getTranslatedValue('Change Language'),
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
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              isLoading == false
                  ? appButton(
                      child: Center(
                        child: isLoading == false
                            ? appText(
                                title: 'English',
                                color: AppColors.WHITE_COLOR,
                              )
                            : Loader(color: AppColors.WHITE_COLOR),
                      ),
                      color: AppColors.PRIMERY_COLOR,
                      onTap: () async {
                        final prefs = await SharedPreferences.getInstance();
                        if (!mounted) return;
                        setState(() {
                          isLoading = true;
                        });
                        setState(() {
                          _temp = const Locale('en', 'US');
                          prefs.setString("language", 'en');
                          MyApp.setLocale(context, _temp!);
                          print("_temp :EN ${_temp}");

                          apiServices.changelanguage('en').then((value) async {
                            if (value['status']) {
                              Fluttertoast.showToast(
                                  msg: value['message'],
                                  backgroundColor: AppColors.PRIMERY_COLOR,
                                  toastLength: Toast.LENGTH_SHORT);
                              Navigator.pop(context);
                            } else {
                              Fluttertoast.showToast(
                                  msg: value['message'],
                                  backgroundColor: AppColors.RED_COLOR,
                                  toastLength: Toast.LENGTH_SHORT);
                            }
                          });

                       
                        });
                        Future.delayed(
                          const Duration(seconds: 3),
                          () {
                            if (!mounted) return;
                            setState(() {
                              isLoading = false;
                            });
                          },
                        );
                      },
                    )
                  : appButton(
                      child: Center(
                        child: Loader(),
                      ),
                      color: AppColors.PRIMERY_COLOR,
                    ),
              SizedBox(
                height: 3.h,
              ),
              isGujLoading == false
                  ? appButton(
                      onTap: () async {
                        final prefs = await SharedPreferences.getInstance();

                        if (!mounted) return;
                        setState(() {
                          isGujLoading = true;
                        });
                        setState(() {
                          _temp = const Locale('gu', 'US');
                          prefs.setString("language", 'gu');
                          MyApp.setLocale(context, _temp!);
                            apiServices.changelanguage('gu').then((value) async {
                            if (value['status']) {
                              Fluttertoast.showToast(
                                  msg: value['message'],
                                  backgroundColor: AppColors.PRIMERY_COLOR,
                                  toastLength: Toast.LENGTH_SHORT);
                              Navigator.pop(context);
                            } else {
                              Fluttertoast.showToast(
                                  msg: value['message'],
                                  backgroundColor: AppColors.RED_COLOR,
                                  toastLength: Toast.LENGTH_SHORT);
                            }
                          });
                         
                          print("_temp :GU ${_temp}");
                        });
                        Future.delayed(
                          const Duration(seconds: 3),
                          () {
                            if (!mounted) return;
                            setState(() {
                              isGujLoading = false;
                            });
                          },
                        );
                      },
                      child: Center(
                        child: isGujLoading == false
                            ? appText(
                                title: 'ગુજરાતી',
                                color: AppColors.WHITE_COLOR,
                              )
                            : Loader(color: AppColors.WHITE_COLOR),
                      ),
                      color: AppColors.PRIMERY_COLOR,
                    )
                  : appButton(
                      child:
                          Center(child: Loader(color: AppColors.WHITE_COLOR)),
                      color: AppColors.PRIMERY_COLOR,
                    )
            ],
          ),
        ),
      ),
    );
  }
}
