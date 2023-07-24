// ignore_for_file: sized_box_for_whitespace, unused_local_variable, avoid_unnecessary_containers, prefer_const_constructors, avoid_print, prefer_typing_uninitialized_variables, non_constant_identifier_names, prefer_is_empty, unnecessary_null_comparison, unused_field, use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:minimall_store/constants/app_assets.dart';
import 'package:minimall_store/constants/app_colors.dart';
import 'package:minimall_store/views/comman/app_dialogs.dart';
import 'package:minimall_store/views/comman/category_view.dart';
import 'package:minimall_store/views/pages/Bottombar_page.dart';
import 'package:minimall_store/views/pages/Gallery/gallery_page.dart';
import 'package:minimall_store/views/pages/Offer/offer_page.dart';
import 'package:minimall_store/views/pages/Video/video_page.dart';
import 'package:sizer/sizer.dart';
import '../../../Localization/app_localization.dart';
import '../../comman/connectivity_check.dart';
import 'home_banner.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _searchController = TextEditingController();

  var Popupdata;
  var addressdata;
  var addressId;
  bool? isConnected;
  bool? isShowpopup;

  getinternet(BuildContext context) async {
    isConnected = await ConnectivityService.isConnected;
    if (isConnected == false) {
      AppDialog.showInternetDialog(
        context,
        onTap: () {
          Navigator.pop(context);
          getinternet(context);
        },
      );
    }
  }

  @override
  void initState() {
    getinternet(context);
    super.initState();
  }

 

  @override
  Widget build(BuildContext context) {
    var lang = AppLocalization.of(context);
    return Scaffold(
      backgroundColor: AppColors.WHITE_COLOR,
      // appBar: AppBar(
      //   backgroundColor: AppColors.PRIMERY_COLOR,
      //   // centerTitle: true,
      //   automaticallyImplyLeading: false,
      //   title: appText(
      //     title: lang?.getTranslatedValue('Welcome'),
      //     fontFamily: AppFonts.latoBold,
      //     fontWeight: FontWeight.w700,
      //     color: AppColors.WHITE_COLOR,
      //   ),
      //   actions: [
      //     // SizedBox(width: 5.w,),
      //     Icon(
      //       Icons.notifications_outlined,
      //       color: AppColors.WHITE_COLOR,
      //     ),
      //     SizedBox(
      //       width: 3.w,
      //     ),
      //   ],
      //   elevation: 0,
      // ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 40.h,
              // padding: EdgeInsets.only(bottom: 5.h, top: 2.h),
              decoration: BoxDecoration(
                  // color: AppColors.PRIMERY_COLOR,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(5.w),
                      bottomRight: Radius.circular(5.w))),
              child: HomeBanner(),
            ),
            SizedBox(
              height: 5.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.w),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      categoryView(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => BottomBarPage(
                                  index: 1,
                                ),
                              ));
                        },
                        image: AppAssets.ESTIMATE,
                        title: lang?.getTranslatedValue('Estimate'),
                      ),
                      categoryView(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => GalleyPage()));
                        },
                          image: AppAssets.GALLERY,
                          title: lang?.getTranslatedValue('Gallery'))
                    ],
                  ),
                  SizedBox(
                    height: 3.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      categoryView(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => VideoPage()));
                        },
                          image: AppAssets.VIDEO,
                          title: lang?.getTranslatedValue('Video')),
                      categoryView(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => OfferPage()));
                        },
                          image: AppAssets.OFFER,
                          title: lang?.getTranslatedValue('Offer'))
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
