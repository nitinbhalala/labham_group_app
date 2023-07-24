// ignore_for_file: annotate_overrides, avoid_print, use_build_context_synchronously

import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:minimall_store/businessLogic/blocs/updateProfile/update_profile_cubit.dart';
import 'package:minimall_store/businessLogic/blocs/updateProfile/update_profile_state.dart';
import 'package:minimall_store/services/api_services.dart';
import 'package:minimall_store/views/comman/app_textfiled.dart';
import 'package:minimall_store/views/comman/connectivity_check.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import '../../../../Localization/app_localization.dart';
import '../../../../constants/app_assets.dart';
import '../../../../constants/app_colors.dart';
import '../../../../constants/app_fonts.dart';
import '../../../comman/app_button.dart';
import '../../../comman/app_dialogs.dart';
import '../../../comman/app_text.dart';
import '../../../comman/loader.dart';

class EditDetailPage extends StatefulWidget {
  const EditDetailPage({super.key});

  @override
  State<EditDetailPage> createState() => _EditDetailPageState();
}

class _EditDetailPageState extends State<EditDetailPage> {
  String? name;
  String? avatar;
  String? email;
  String? mobileNo;
  String? appLogo;
  String? userLogo;

  _getData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      // name = prefs.getString('name').toString();
      // email = prefs.getString('email').toString();
      // mobileNo = prefs.getString('phone').toString();
      avatar = prefs.getString('avatar').toString();
      userNameController.text = prefs.getString('name').toString();
      emailController.text = prefs.getString('email').toString();
      phoneController.text = prefs.getString('phone').toString();
      appLogo = prefs.getString('app_logo_url').toString();
      userLogo = prefs.getString('user_logo_url').toString();
    });
  }

  @override
  void initState() {
    _getData();
    getinternet();
    
    super.initState();
  }

  bool? isConnected;
  getinternet() async {
    isConnected = await ConnectivityService.isConnected;
    if (isConnected == false) {
      AppDialog.showInternetDialog(
        context,
        onTap: () {
         UpdateProfileCubit(ApiServices());
          Navigator.pop(context);
          getinternet();
        },
      );
    }
  }

  bool isValidName = false;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController userNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  ImagePicker picker = ImagePicker();
  File? pikedManager;
  XFile? image;
  XFile? uAppLogo;
  XFile? uUserLogo;
  Widget build(BuildContext context) {
    var lang = AppLocalization.of(context);
    return BlocProvider(
      create: (context) => UpdateProfileCubit(ApiServices()),
      child: Scaffold(
          backgroundColor: AppColors.PRIMERY_COLOR,
          appBar: AppBar(
            backgroundColor: AppColors.PRIMERY_COLOR,
            centerTitle: true,
            automaticallyImplyLeading: true,
            iconTheme: const IconThemeData(color: AppColors.WHITE_COLOR),
            title: appText(
              title: lang?.getTranslatedValue('Edit Profile'),
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
            child: BlocBuilder<UpdateProfileCubit, UpdateProfileState>(
              builder: (context, state) {
                if (state is LoadingUpdateProfileState) {
                  return Center(
                    child: Loader(),
                  );
                }
                if (state is LoadedUpdateProfileState) {
                  return SingleChildScrollView(
                    child: SafeArea(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 5.w, vertical: 3.h),
                        child: SingleChildScrollView(
                          child: Form(
                            key: _formKey,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  height: 15.h,
                                  width: 15.h,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15.h),
                                      border: Border.all(color: AppColors.GREY),
                                      color: avatar == null
                                          ? AppColors.PRIMERY_COLOR
                                          : Colors.transparent),
                                  child: image != null
                                      ? ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(15.h),
                                          child: Image.file(
                                            File(image!.path),
                                            fit: BoxFit.cover,
                                          ))
                                      : avatar != null
                                          ? ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(15.h),
                                              child: CachedNetworkImage(
                                                  imageUrl: avatar.toString(),
                                                  fit: BoxFit.cover,
                                                  progressIndicatorBuilder:
                                                      (context, url, progress) {
                                                    return Center(
                                                        child: Image.asset(
                                                            AppAssets
                                                                .LABHAM_LOGO));
                                                  }),
                                            )
                                          : Icon(Icons.person_2,
                                              color: Colors.white, size: 4.h),
                                ),
                                SizedBox(
                                  height: 1.h,
                                ),
                                GestureDetector(
                                    onTap: () async {
                                      image = await picker.pickImage(
                                          source: ImageSource.gallery,
                                          imageQuality: 100);
                                      if (image != null) {
                                        setState(() {
                                          pikedManager = File(image!.path);
                                        });
                                      }
                                    },
                                    child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          appText(
                                              title: lang?.getTranslatedValue(
                                                  'Avatar')),
                                          const Icon(
                                            Icons.edit,
                                            color: AppColors.FONT_COLOR,
                                          ),
                                        ])),
                                SizedBox(
                                  height: 2.h,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Column(
                                      children: [
                                        Container(
                                          height: 15.h,
                                          width: 15.h,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(2.h),
                                            border: Border.all(
                                                color: AppColors.GREY),
                                          ),
                                          child: uAppLogo != null
                                              ? ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          2.h),
                                                  child: Image.file(
                                                    File(uAppLogo!.path),
                                                    fit: BoxFit.cover,
                                                  ))
                                              : appLogo != null
                                                  ? ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              2.h),
                                                      child: CachedNetworkImage(
                                                          imageUrl: appLogo
                                                              .toString(),
                                                          fit: BoxFit.cover,
                                                          progressIndicatorBuilder:
                                                              (context, url,
                                                                  progress) {
                                                            return Center(
                                                                child: Image.asset(
                                                                    AppAssets
                                                                        .LABHAM_LOGO));
                                                          }),
                                                    )
                                                  : Icon(Icons.person_2,
                                                      color: Colors.white,
                                                      size: 4.h),
                                        ),
                                        SizedBox(
                                          height: 1.h,
                                        ),
                                        GestureDetector(
                                          onTap: () async {
                                            uAppLogo = await picker.pickImage(
                                                source: ImageSource.gallery,
                                                imageQuality: 100);
                                            if (uAppLogo != null) {
                                              setState(() {
                                                pikedManager =
                                                    File(uAppLogo!.path);
                                              });
                                            }
                                          },
                                          child: Row(children: [
                                            appText(
                                                title: lang?.getTranslatedValue(
                                                    'App Logo')),
                                            const Icon(
                                              Icons.edit,
                                              color: AppColors.FONT_COLOR,
                                            ),
                                          ]),
                                          // child: const Icon(
                                          //   Icons.edit,
                                          //   color: AppColors.FONT_COLOR,
                                          // ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      width: 2.w,
                                    ),
                                    Column(
                                      children: [
                                        Container(
                                          height: 15.h,
                                          width: 15.h,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(2.h),
                                            border: Border.all(
                                                color: AppColors.GREY),
                                          ),
                                          child: uUserLogo != null
                                              ? ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          2.h),
                                                  child: Image.file(
                                                    File(uUserLogo!.path),
                                                    fit: BoxFit.cover,
                                                  ))
                                              : userLogo != null
                                                  ? ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              2.h),
                                                      child: CachedNetworkImage(
                                                          imageUrl: userLogo
                                                              .toString(),
                                                          fit: BoxFit.cover,
                                                          progressIndicatorBuilder:
                                                              (context, url,
                                                                  progress) {
                                                            return Center(
                                                                child: Image.asset(
                                                                    AppAssets
                                                                        .LABHAM_LOGO));
                                                          }),
                                                    )
                                                  : Icon(Icons.person_2,
                                                      color: Colors.white,
                                                      size: 4.h),
                                        ),
                                        SizedBox(
                                          height: 1.h,
                                        ),
                                        GestureDetector(
                                            onTap: () async {
                                              uUserLogo =
                                                  await picker.pickImage(
                                                      source:
                                                          ImageSource.gallery,
                                                      imageQuality: 100);
                                              if (uUserLogo != null) {
                                                setState(() {
                                                  pikedManager =
                                                      File(uUserLogo!.path);
                                                });
                                              }
                                            },
                                            child: Row(children: [
                                              appText(
                                                  title:
                                                      lang?.getTranslatedValue(
                                                          'User Logo')),
                                              const Icon(
                                                Icons.edit,
                                                color: AppColors.FONT_COLOR,
                                              ),
                                            ])),
                                      ],
                                    )
                                  ],
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    appText(
                                        title: lang
                                            ?.getTranslatedValue('Username'),
                                        fontSize: 1.6.h,
                                        color: AppColors.GREY,
                                        fontWeight: FontWeight.w600),
                                  ],
                                ),
                                SizedBox(
                                  height: 2.h,
                                ),
                                appTextfild(
                                  onChanged: (value) {
                                    setState(() {
                                      if (value.isNotEmpty) {
                                        isValidName = true;
                                      } else {
                                        isValidName = false;
                                      }
                                    });
                                  },
                                  validator: (val) {
                                    if (val!.isEmpty) {
                                      return lang?.getTranslatedValue(
                                          'Please Enter your name');
                                    } else {
                                      return null;
                                    }
                                  },
                                  keyboardType: TextInputType.name,
                                  textInputAction: TextInputAction.next,
                                  controller: userNameController,
                                ),
                                SizedBox(
                                  height: 1.h,
                                ),
                                appTextfild(
                                  onChanged: (value) {
                                    setState(() {
                                      if (value.isNotEmpty) {
                                        isValidName = true;
                                      } else {
                                        isValidName = false;
                                      }
                                    });
                                  },
                                  validator: (val) {
                                    if (val!.isEmpty) {
                                      return lang?.getTranslatedValue(
                                          'Please Enter your name');
                                    } else {
                                      return null;
                                    }
                                  },
                                  keyboardType: TextInputType.phone,
                                  textInputAction: TextInputAction.next,
                                  controller: phoneController,
                                ),
                                SizedBox(
                                  height: 1.h,
                                ),
                                appTextfild(
                                  onChanged: (value) {
                                    setState(() {
                                      if (value.isNotEmpty) {
                                        isValidName = true;
                                      } else {
                                        isValidName = false;
                                      }
                                    });
                                  },
                                  validator: (val) {
                                    if (val!.isEmpty) {
                                      return lang?.getTranslatedValue(
                                          'Please Enter your name');
                                    } else {
                                      return null;
                                    }
                                  },
                                  keyboardType: TextInputType.emailAddress,
                                  textInputAction: TextInputAction.done,
                                  controller: emailController,
                                ),
                                SizedBox(
                                  height: 4.h,
                                ),
                                Center(
                                  child: appButton(
                                      onTap: () async {
                                        FocusScope.of(context)
                                            .requestFocus(FocusNode());
                                        if (!state.isLoading) {
                                          if (_formKey.currentState!
                                              .validate()) {
                                            if (!state.isLoading) {
                                            context.read<UpdateProfileCubit>().
                                                  updateProfile(
                                                      email:
                                                          emailController.text,
                                                      mobileno:
                                                          phoneController.text,
                                                      userName:
                                                          userNameController
                                                              .text,
                                                      context: context,
                                                      avatar: image,
                                                      appLogo: uAppLogo,
                                                      userLogo: uUserLogo);
                                            } else {
                                              return;
                                            }
                                          }
                                        }
                                      },
                                      child: Center(
                                          child: (!state.isLoading)
                                              ? appText(
                                                  title:
                                                      lang?.getTranslatedValue(
                                                          'Update'),
                                                  color: AppColors.WHITE_COLOR,
                                                  fontWeight: FontWeight.w600)
                                              : Loader(
                                                  color:
                                                      AppColors.WHITE_COLOR))),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                }
                return Container();
              },
            ),
          )),
    );
  }
}
