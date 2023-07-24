// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:minimall_store/constants/app_colors.dart';
import 'package:sizer/sizer.dart';

Widget Loader({
  color,
}){
  return  CircularProgressIndicator(color: color ?? AppColors.PRIMERY_COLOR,strokeWidth: 0.5.w,);
}