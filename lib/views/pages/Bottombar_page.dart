// ignore_for_file: file_names, no_leading_underscores_for_local_identifiers, must_be_immutable, avoid_print

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:minimall_store/views/pages/Estimate/estimate_page.dart';
import 'package:minimall_store/views/pages/Home/home_page.dart';
import 'package:sizer/sizer.dart';
import '../../Localization/app_localization.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_fonts.dart';
import '../comman/app_dialogs.dart';
import 'Account/accountPage/account_page.dart';

class BottomBarPage extends StatefulWidget {
  int? index;

  BottomBarPage({super.key, this.index});

  @override
  State<BottomBarPage> createState() => _BottomBarPageState();
}

class _BottomBarPageState extends State<BottomBarPage> {
  int? currentIndex;
  @override
  void initState() {
    currentIndex = widget.index;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var lang = AppLocalization.of(context);
    return WillPopScope(
      onWillPop: () async {
        bool isConfrimed = await AppDialog.showDialog(context,
            title: '${lang?.getTranslatedValue('Exit App')}',
            message:
                '${lang?.getTranslatedValue('Do you want to exit on app??')}');
        if (isConfrimed) {
          SystemNavigator.pop();
        }
        return isConfrimed;
      },
      child: Scaffold(
        body: currentIndex == 0
            ? const HomePage()
            : currentIndex == 1
                ? const EstimatePage()
                : currentIndex == 2
                    ? const AccountPage()
                    : const HomePage(),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: currentIndex!,
          backgroundColor: Colors.white,
          onTap: (index) {
            setState(() {
              currentIndex = index;
            });
          },
          iconSize: 3.h,
          selectedItemColor: AppColors.PRIMERY_COLOR,
          unselectedItemColor: AppColors.FONT_COLOR,
          selectedLabelStyle: TextStyle(
              color: AppColors.PRIMERY_COLOR,
              fontFamily: AppFonts.latoReguler,
              fontSize: 1.7.h,
              fontWeight: FontWeight.w600),
          unselectedLabelStyle: TextStyle(
              color: AppColors.FONT_COLOR,
              fontFamily: AppFonts.latoReguler,
              fontSize: 1.7.h,
              fontWeight: FontWeight.w600),
          type: BottomNavigationBarType.fixed,
          selectedFontSize: 12,
          unselectedFontSize: 11,
          items: [
            BottomNavigationBarItem(
              label: lang?.getTranslatedValue('Home'),
              icon: Icon(
                Icons.home,
                size: 3.5.h,
              ),
            ),
            BottomNavigationBarItem(
              label: lang?.getTranslatedValue('Estimate'),
              icon: Icon(
                Icons.calculate_outlined,
                size: 3.5.h,
              ),
            ),
            // BottomNavigationBarItem(
            //   label: lang?.getTranslatedValue('Cart'),
            //   icon: Icon(
            //     Icons.shopping_cart_outlined,
            //     size: 3.5.h,
            //   ),
            // ),
            // BottomNavigationBarItem(
            //   label: lang?.getTranslatedValue('Wishlist'),
            //   icon: Icon(
            //     Icons.favorite_border_outlined,
            //     size: 3.5.h,
            //   ),
            // ),
            BottomNavigationBarItem(
              label: lang?.getTranslatedValue('Account'),
              icon: Icon(
                Icons.person_outline_outlined,
                size: 3.5.h,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
