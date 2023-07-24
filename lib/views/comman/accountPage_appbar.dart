// ignore_for_file: file_names

import 'package:flutter/material.dart';
import '../../Localization/app_localization.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_fonts.dart';
import 'app_text.dart';

Widget appBar({
  BuildContext? context,
  String? title,
}) {
  var lang = AppLocalization.of(context!);
  return AppBar(
    backgroundColor: AppColors.WHITE_COLOR,
    centerTitle: true,
    automaticallyImplyLeading: true,
    title: appText(
      title: lang?.getTranslatedValue(title ?? ''),
      fontFamily: AppFonts.latoBold,
      fontWeight: FontWeight.w700,
      color: AppColors.FONT_COLOR,
    ),
    elevation: 0,
  );
}
