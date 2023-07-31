// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minimall_store/Cubit/changePassowrd/change_passowrd_state.dart';
import 'package:minimall_store/Cubit/changePassowrd/change_password_cubit.dart';
import 'package:minimall_store/services/api_services.dart';
import 'package:minimall_store/views/comman/app_dialogs.dart';
import 'package:minimall_store/views/comman/loader.dart';
import 'package:sizer/sizer.dart';

import '../../../Localization/app_localization.dart';
import '../../../constants/app_colors.dart';
import '../../../constants/app_fonts.dart';
import '../../comman/app_button.dart';
import '../../comman/app_text.dart';
import '../../comman/app_textfiled.dart';
import '../../comman/connectivity_check.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({super.key});

  @override
  State<ChangePasswordPage> createState() => _PaymentMethodsPageState();
}

class _PaymentMethodsPageState extends State<ChangePasswordPage> {
  bool _currnetpass = true;
  bool _newpass = true;
  bool isPassValid = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController currentPassowrdController = TextEditingController();
  TextEditingController newPassowrdController = TextEditingController();

  void _obscureCurrentPassChnage() {
    setState(() {
      _currnetpass = !_currnetpass;
    });
  }

  void _obscureNewPassChnage() {
    setState(() {
      _newpass = !_newpass;
    });
  }

  bool? isConnected;
  getinternet() async {
    isConnected = await ConnectivityService.isConnected;
    if (isConnected == false) {
      AppDialog.showInternetDialog(
        context,
        onTap: () {
          ChangePasswordCubit(ApiServices());
          Navigator.pop(context);
          getinternet();
        },
      );
    }
  }

  @override
  void initState() {
    getinternet();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var lang = AppLocalization.of(context);
    return BlocProvider(
      create: (context) => ChangePasswordCubit(ApiServices()),
      child: Scaffold(
        backgroundColor: AppColors.PRIMERY_COLOR,
        appBar: AppBar(
          backgroundColor: AppColors.PRIMERY_COLOR,
          centerTitle: true,
          automaticallyImplyLeading: true,
          iconTheme: const IconThemeData(color: AppColors.WHITE_COLOR),
          title: appText(
            title: lang?.getTranslatedValue('Change Password'),
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
          child: BlocBuilder<ChangePasswordCubit, ChangePassowrdState>(
            builder: (context, state) {
              if (state is LoadingpasswordState) {
                return Center(
                  child: Loader(
                    color: AppColors.PRIMERY_COLOR,
                  ),
                );
              }
              if (state is LoadedpasswordState) {
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 3.h),
                  child: Form(
                    key: _formKey,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          appTextfild(
                            onChanged: (value) {
                              setState(() {
                                if (value.isNotEmpty) {
                                  isPassValid = true;
                                } else {
                                  isPassValid = false;
                                }
                              });
                            },
                            validator: (val) {
                              if (val!.isEmpty) {
                                return lang?.getTranslatedValue(
                                    'Please Enter current  Password');
                              } else {
                                return null;
                              }
                            },
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(4),
                              borderSide: const BorderSide(
                                  width: 0.3, color: Colors.red),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(4),
                              borderSide: const BorderSide(
                                  width: 0.3, color: AppColors.GREY),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(4),
                              borderSide: const BorderSide(
                                  width: 0.3, color: AppColors.GREY),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(4),
                              borderSide: const BorderSide(
                                  width: 0.3, color: Colors.red),
                            ),
                            controller: currentPassowrdController,
                            hint: lang
                                ?.getTranslatedValue('Enter current Password'),
                            keyboardType: TextInputType.visiblePassword,
                            obscureText: _currnetpass,
                            suffixIcon: GestureDetector(
                              onTap: _obscureCurrentPassChnage,
                              child: _currnetpass
                                  ? const Icon(
                                      Icons.visibility,
                                      color: AppColors.FONT_COLOR,
                                    )
                                  : const Icon(
                                      Icons.visibility_off,
                                      color: AppColors.FONT_COLOR,
                                    ),
                            ),
                          ),
                          SizedBox(
                            height: 3.h,
                          ),
                          appTextfild(
                            onChanged: (value) {
                              setState(() {
                                if (value.isNotEmpty) {
                                  isPassValid = true;
                                } else {
                                  isPassValid = false;
                                }
                              });
                            },
                            validator: (val) {
                              if (val!.isEmpty) {
                                return lang?.getTranslatedValue(
                                    'Please Enter new Password');
                              } else if (val!.length < 6) {
                                return lang?.getTranslatedValue(
                                    'Please Enter minimum 6 character');
                              } else {
                                return null;
                              }
                            },
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(4),
                              borderSide: const BorderSide(
                                  width: 0.3, color: Colors.red),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(4),
                              borderSide: const BorderSide(
                                  width: 0.3, color: AppColors.GREY),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(4),
                              borderSide: const BorderSide(
                                  width: 0.3, color: AppColors.GREY),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(4),
                              borderSide: const BorderSide(
                                  width: 0.3, color: Colors.red),
                            ),
                            controller: newPassowrdController,
                            hint:
                                lang?.getTranslatedValue('Enter new Password'),
                            keyboardType: TextInputType.visiblePassword,
                            obscureText: _newpass,
                            suffixIcon: GestureDetector(
                              onTap: _obscureNewPassChnage,
                              child: _newpass
                                  ? const Icon(
                                      Icons.visibility,
                                      color: AppColors.FONT_COLOR,
                                    )
                                  : const Icon(
                                      Icons.visibility_off,
                                      color: AppColors.FONT_COLOR,
                                    ),
                            ),
                          ),
                          SizedBox(
                            height: 5.h,
                          ),
                          appButton(
                              onTap: () {
                                FocusScope.of(context)
                                    .requestFocus(FocusNode());
                                if (!state.isLoading) {
                                  if (_formKey.currentState!.validate()) {
                                    context
                                        .read<ChangePasswordCubit>()
                                        .changePassowrd(
                                            currentPassowrd:currentPassowrdController.text,
                                            newPassowrd:newPassowrdController.text,
                                            context:context);
                                  } else {
                                    return;
                                  }
                                }
                              },
                              color: AppColors.PRIMERY_COLOR,
                              child: (!state.isLoading)
                                  ? Center(
                                      child: appText(
                                        title: lang?.getTranslatedValue(
                                            'Change Password'),
                                        color: AppColors.WHITE_COLOR,
                                      ),
                                    )
                                  : Center(
                                      child:
                                          Loader(color: AppColors.WHITE_COLOR)))
                        ],
                      ),
                    ),
                  ),
                );
              }
              return Container();
            },
          ),
        ),
      ),
    );
  }
}
