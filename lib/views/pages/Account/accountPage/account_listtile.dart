// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:minimall_store/constants/app_colors.dart';
import 'package:sizer/sizer.dart';
import '../../../comman/app_text.dart';

class AccountListTile extends StatelessWidget {
  String title;
  Widget leading;
  VoidCallback onTap;
  AccountListTile(
      {super.key,
      required this.title,
      required this.leading,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: 1.h),
         decoration: BoxDecoration(
          color:AppColors.PRODUCT_BACK,
          borderRadius: BorderRadius.circular( 7.h),
        ),
        child: ListTile(
          title:
              appText(title: title,color:AppColors.PRIMERY_COLOR , fontWeight: FontWeight.w600, fontSize: 2.h),
          trailing: const Icon(
            Icons.arrow_forward_ios_rounded,
            color: AppColors.PRIMERY_COLOR,
          ),
          leading: leading,
        ),
      ),
    );
  }
}
