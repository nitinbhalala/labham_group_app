// ignore_for_file: unused_element, avoid_print, deprecated_member_use, use_build_context_synchronously
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:minimall_store/constants/app_assets.dart';
import 'package:minimall_store/constants/app_colors.dart';
import 'package:minimall_store/views/comman/app_button.dart';
import 'package:minimall_store/views/comman/app_text.dart';
import 'package:minimall_store/views/comman/function.dart';
import 'package:minimall_store/views/pages/Account/myDetails/myDetails_page.dart';
import 'package:minimall_store/views/pages/authPage/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import '../../../../Localization/app_localization.dart';
import '../../../comman/app_dialogs.dart';
import '../about_page.dart';
import '../change_passowrd.dart';
import '../change_language.dart';
import '../help_page.dart';
import 'account_listtile.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  String? name;
  String? email;
  String? mobileNo;
  String? avatar;
  bool? isLogin;
  String? privacy;

  Functions function = Functions();
  _getData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      name = prefs.getString('name').toString();
      email = prefs.getString('email').toString();
      mobileNo = prefs.getString('phone').toString();
      avatar = prefs.getString('avatar').toString();
      isLogin = prefs.getBool('status');
      privacy = prefs.getString('privacy_policy_url');
    });
  }

  @override
  void initState() {
    _getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var lang = AppLocalization.of(context);
    return Scaffold(
      backgroundColor: AppColors.PRIMERY_COLOR,
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 12.h,
              child: Center(
                child: Padding(
                  padding:  EdgeInsets.only(left: 3.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                          height: 8.h,
                          width: 8.h,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.h),
                              color: avatar == null
                                  ? AppColors.PRIMERY_COLOR
                                  : Colors.transparent),
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(8.h),
                              child: avatar != null
                                  ? CachedNetworkImage(
                                      imageUrl: avatar.toString(),
                                      fit: BoxFit.cover,
                                      progressIndicatorBuilder:
                                          (context, url, progress) {
                                        return Center(
                                            child:
                                                Image.asset(AppAssets.LABHAM_LOGO));
                                      })
                                  : Image.asset(AppAssets.LABHAM_LOGO))),
                      SizedBox(
                        width: 4.w,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          appText(
                              title: name,
                              fontSize: 2.5.h,
                              color: AppColors.WHITE_COLOR,
                              fontWeight: FontWeight.w700),
                          appText(
                            title: email,
                            color: AppColors.WHITE_COLOR.withOpacity(0.9)
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                    color: AppColors.WHITE_COLOR,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(7.w),
                        topRight: Radius.circular(7.w))),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 5.h,
                        ),
                        // AccountListTile(
                        //     onTap: () {
                        //       Navigator.push(
                        //           context,
                        //           MaterialPageRoute(
                        //             builder: (context) => const OrdersPage(),
                        //           ));
                        //     },
                        //     title: '${lang?.getTranslatedValue('Orders')}',
                        //     leading: const Icon(
                        //       Icons.shopping_bag_outlined,
                        //       color: AppColors.FONT_COLOR,
                        //     )),
                        AccountListTile(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => MyDetailsPage(
                                        name: name!,
                                        email: email!,
                                        mobileNo: mobileNo!),
                                  ));
                            },
                            title: '${lang?.getTranslatedValue('My Profile')}',
                            leading: const Icon(
                              Icons.portrait_rounded,
                              color: AppColors.PRIMERY_COLOR,
                            )),
                        // AccountListTile(
                        //     onTap: () {
                        //       Navigator.push(
                        //           context,
                        //           MaterialPageRoute(
                        //             builder: (context) => const DeliveryAddressPage(),
                        //           ));
                        //     },
                        //     title: '${lang?.getTranslatedValue('Delivery Address')}',
                        //     leading: const Icon(
                        //       Icons.location_on,
                        //       color: AppColors.FONT_COLOR,
                        //     )),
                        AccountListTile(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const ChangePasswordPage(),
                                  ));
                            },
                            title:
                                '${lang?.getTranslatedValue('Change Password')}',
                            leading: const Icon(
                              Icons.lock,
                              color: AppColors.PRIMERY_COLOR,
                            )),
                        AccountListTile(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const ChangeLanguagePage(),
                                  ));
                            },
                            title:
                                '${lang?.getTranslatedValue('Change Language')}',
                            leading: const Icon(
                              Icons.language,
                              color: AppColors.PRIMERY_COLOR,
                            )),
                        AccountListTile(
                            onTap: () {
                              function.launchPrivacy(privacy.toString());
                            },
                            title: '${lang?.getTranslatedValue('Privacy Policy')}',
                            leading: const Icon(
                              Icons.privacy_tip,
                              color: AppColors.PRIMERY_COLOR,
                            )),
                        AccountListTile(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const HelpPage(),
                                  ));
                            },
                            title: '${lang?.getTranslatedValue('Help')}',
                            leading: const Icon( 
                              Icons.help_outline_sharp,
                              color: AppColors.PRIMERY_COLOR,
                            )),
                        AccountListTile(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const AboutPage(),
                                  ));
                            },
                            title: '${lang?.getTranslatedValue('About')}',
                            leading: const Icon(
                              Icons.info_outline,
                              color: AppColors.PRIMERY_COLOR,
                            )),
                        AccountListTile(
                            onTap: () {
                              function.launchPlayStore();
                            },
                            title: '${lang?.getTranslatedValue('Rating')}',
                            leading: const Icon(
                              Icons.star_border,
                              color: AppColors.PRIMERY_COLOR,
                            )),
                        SizedBox(
                          height: 5.h,
                        ),
                        appButton(
                          onTap: () async {
                            bool isConfrimed = await AppDialog.showDialog(context,
                                title: '${lang?.getTranslatedValue('Logout')}',
                                message:
                                    '${lang?.getTranslatedValue('Are you sure to logout MiniMall?')}');
                            if (isConfrimed) {
                              final SharedPreferences prefs =
                                  await SharedPreferences.getInstance();
                              prefs.remove('name');
                              prefs.remove('email');
                              prefs.remove('phone');
                              prefs.remove('api_token');
                              prefs.remove('status');
                              prefs.remove('addtobasket');
                              prefs.remove('primaryId');
                              prefs.remove('building_no');
                              prefs.remove('address1');
                              prefs.remove('address2');
                              prefs.remove('landmark');
                              prefs.remove('zipcode');
                              prefs.remove('type');
            
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const LoginPage(),
                                  ));
                            }
                          },
                          color: AppColors.PRODUCT_BACK,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.logout_outlined,
                                  color: AppColors.PRIMERY_COLOR, size: 3.5.h),
                              SizedBox(
                                width: 5.w,
                              ),
                              appText(
                                  title: lang?.getTranslatedValue('Logout'),
                                  color: AppColors.PRIMERY_COLOR,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 2.h)
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
