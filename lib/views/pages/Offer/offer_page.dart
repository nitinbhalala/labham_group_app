import 'package:flutter/material.dart';
import 'package:minimall_store/views/comman/no_found.dart';
import 'package:sizer/sizer.dart';
import '../../../Localization/app_localization.dart';
import '../../../constants/app_colors.dart';
import '../../../constants/app_fonts.dart';
import '../../comman/app_text.dart';

class OfferPage extends StatefulWidget {
  const OfferPage({super.key});

  @override
  State<OfferPage> createState() => _OfferPageState();
}

class _OfferPageState extends State<OfferPage> {
  @override
  Widget build(BuildContext context) {
    var lang = AppLocalization.of(context);
    return Scaffold(
      backgroundColor: AppColors.PRIMERY_COLOR,
      appBar: AppBar(
        backgroundColor: AppColors.PRIMERY_COLOR,
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back_ios,
            color: AppColors.WHITE_COLOR,
          ),
        ),
        title: appText(
          title: lang?.getTranslatedValue('Offer'),
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
            topRight: Radius.circular(7.w),
          ),
        ),
        child: Center(
            child: noFound(title: lang?.getTranslatedValue('Not at offer'))),
      ),
    );
  }
}
