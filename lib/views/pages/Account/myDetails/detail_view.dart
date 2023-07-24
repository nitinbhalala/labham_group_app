// ignore_for_file: must_be_immutable

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../constants/app_colors.dart';
import '../../../comman/app_text.dart';

class DetailView extends StatelessWidget {
  String keyTitle;
  String keyValue;
  Icon icon;
  DetailView(
      {super.key,
      required this.keyTitle,
      required this.keyValue,
      required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 8.h,
      decoration: BoxDecoration(
          color: AppColors.PRODUCT_BACK,
          borderRadius: BorderRadius.circular(4.w)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 3.w,
          ),
          icon,
          SizedBox(
            width: 5.w,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [appText(title: keyTitle), appText(title: keyValue)],
          ),
        ],
      ),
    );
  }
}
