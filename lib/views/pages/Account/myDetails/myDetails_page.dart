// ignore_for_file: file_names, must_be_immutable

import 'package:flutter/material.dart';
import 'package:minimall_store/views/pages/Account/myDetails/detail_view.dart';
import 'package:minimall_store/views/pages/Account/myDetails/edit_detail_page.dart';
import 'package:sizer/sizer.dart';
import '../../../../Localization/app_localization.dart';
import '../../../../constants/app_colors.dart';
import '../../../../constants/app_fonts.dart';
import '../../../comman/app_button.dart';
import '../../../comman/app_text.dart';

class MyDetailsPage extends StatefulWidget {
  String name;
  String mobileNo;
  String email;

  MyDetailsPage(
      {super.key,
      required this.name,
      required this.email,
      required this.mobileNo});

  @override
  State<MyDetailsPage> createState() => _MyDetailsPageState();
}

class _MyDetailsPageState extends State<MyDetailsPage> {
  @override
  Widget build(BuildContext context) {
    var lang = AppLocalization.of(context);
    return Scaffold(
      backgroundColor: AppColors.PRIMERY_COLOR,
      appBar: AppBar(
        backgroundColor: AppColors.PRIMERY_COLOR,
        centerTitle: true,
        automaticallyImplyLeading: true,
        iconTheme: const IconThemeData(color:AppColors.WHITE_COLOR),
        title: appText(
          title: lang?.getTranslatedValue('My Profile'),
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
                  topLeft: Radius.circular(7.w),
                  topRight: Radius.circular(7.w))),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
            child: Column(
              children: [
                DetailView(
                    keyTitle: '${lang?.getTranslatedValue('Name')}',
                    keyValue: widget.name,
                    icon: const Icon(Icons.person)),
                SizedBox(
                  height: 3.h,
                ),
                DetailView(
                    keyTitle: '${lang?.getTranslatedValue('Email')}',
                    keyValue: widget.email,
                    icon: const Icon(Icons.email)),
                SizedBox(
                  height: 3.h,
                ),
                DetailView(
                    keyTitle: '${lang?.getTranslatedValue('Phone')}',
                    keyValue: widget.mobileNo,
                    icon: const Icon(Icons.phone)),
                SizedBox(
                  height: 5.h,
                ),
                appButton(
                  child: Center(
                    child: appText(
                      title: lang?.getTranslatedValue('Edit Detail'),
                      color: AppColors.WHITE_COLOR,
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const EditDetailPage()));
                  },
                  color: AppColors.PRIMERY_COLOR,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
