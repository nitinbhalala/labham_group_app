// ignore_for_file: unused_element, avoid_print, use_build_context_synchronously, unused_local_variable, deprecated_member_use
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minimall_store/Cubit/login/login_cubit.dart';
import 'package:minimall_store/Cubit/login/login_state.dart';
import 'package:minimall_store/constants/app_assets.dart';
import 'package:minimall_store/constants/app_colors.dart';
import 'package:minimall_store/constants/constants.dart';
import 'package:minimall_store/services/api_services.dart';
import 'package:minimall_store/views/comman/app_button.dart';
import 'package:minimall_store/views/comman/app_text.dart';
import 'package:minimall_store/views/comman/app_textfiled.dart';
import 'package:minimall_store/views/comman/loader.dart';
import 'package:minimall_store/views/pages/authPage/singup_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../Localization/app_localization.dart';
import '../../comman/app_dialogs.dart';
import '../../comman/connectivity_check.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<LoginPage> {
  
  bool _obscureText = true;
  bool isValidNumber = false;
  bool isPassValid = false;
  bool isValid = false;
  String? message;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _obscureTextChnage() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  getData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      message = prefs.getString('name').toString();
      
    });
  }


  TextEditingController mobileEditingController = TextEditingController();
  TextEditingController passowrdEditingController = TextEditingController();


  bool? isConnected;
  getinternet() async {
    isConnected = await ConnectivityService.isConnected;
    if (isConnected == false) {
      AppDialog.showInternetDialog(
        context,
        onTap: () {
        LoginCubit(ApiServices());
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
        create: (context) => LoginCubit(ApiServices()),
        child: Scaffold(
            backgroundColor: AppColors.WHITE_COLOR,
            body: BlocBuilder<LoginCubit, LoginState>(
              builder: (context, state) {
                
                if (state is LoadedLoginState) {
                  return SingleChildScrollView(
                    child: SafeArea(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 5.w, vertical: 3.h),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // SizedBox(
                              //   height: 3.h,
                              // ),
                              Center(
                                child: Image.asset(
                                  AppAssets.LABHAM_LOGO,
                                  height: 25.h,
                                ),
                              ),
                              SizedBox(
                                height: 5.h,
                              ),
                              appText(
                                  title: lang?.getTranslatedValue('Login'),
                                  fontSize: 3.5.h,
                                  color: AppColors.FONT_COLOR,
                                  fontWeight: FontWeight.w600),
                              SizedBox(
                                height: 1.h,
                              ),
                              appText(
                                  title: lang?.getTranslatedValue(
                                      'Enter your mobile number and password'),
                                  fontSize: 1.6.h,
                                  color: AppColors.GREY,
                                  fontWeight: FontWeight.w600),
                              SizedBox(
                                height: 4.h,
                              ),
                              appText(
                                  title:
                                      lang?.getTranslatedValue('Mobile Number'),
                                  fontSize: 1.6.h,
                                  color: AppColors.GREY,
                                  fontWeight: FontWeight.w600),
                              SizedBox(
                                height: 2.h,
                              ),
                              appTextfild(
                                  onChanged: (value) {
                                    setState(() {
                                      if (value.isNotEmpty) {
                                        isValidNumber = true;
                                      } else {
                                        isValidNumber = false;
                                      }
                                    });
                                  },
                                  validator: (val) {
                                    if (val!.isEmpty) {
                                      return lang?.getTranslatedValue(
                                          'Enter your register mobile number');
                                    } else {
                                      return null;
                                    }
                                  },
                          
                                  controller: mobileEditingController,
                                  hint: lang?.getTranslatedValue(
                                      'Enter Mobile Number'),
                                  keyboardType: TextInputType.number,
                                  textInputAction: TextInputAction.next,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly,
                                    LengthLimitingTextInputFormatter(10),
                                  ]),
                              SizedBox(
                                height: 3.h,
                              ),
                              appText(
                                  title: lang?.getTranslatedValue('password'),
                                  fontSize: 1.6.h,
                                  color: AppColors.GREY,
                                  fontWeight: FontWeight.w600),
                              SizedBox(
                                height: 2.h,
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
                                        'Please Enter password');
                                  } else {
                                    return null;
                                  }
                                },
                              
                                controller: passowrdEditingController,
                                hint:
                                    lang?.getTranslatedValue('Enter Password'),
                                keyboardType: TextInputType.visiblePassword,
                                obscureText: _obscureText,
                                suffixIcon: GestureDetector(
                                  onTap: _obscureTextChnage,
                                  child: _obscureText
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
                                height: 1.h,
                              ),
                              Align(
                                alignment: Alignment.centerRight,
                                child: GestureDetector(
                                  onTap: () {
                                   
                                  },
                                  child: appText(
                                      title: lang?.getTranslatedValue(
                                          'Forgot Password?'),
                                      fontSize: 1.6.h,
                                      color: AppColors.GREY,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                              SizedBox(
                                height: 4.h,
                              ),
                              Center(
                                child: appButton(
                                    onTap: () async {
                                      FocusScope.of(context)
                                          .requestFocus(FocusNode());
                                      bool isConnected =
                                          await ConnectivityService.isConnected;
                                      if (!state.isLoading) {
                                        if (_formKey.currentState!.validate()) {
                                          if (isConnected) {
                                            context
                                        .read<LoginCubit>().submitLoginButton(
                                          mobileNo:   mobileEditingController
                                                        .text, password: passowrdEditingController
                                                        .text, context: context
                                          );
                                         
                                          } else {
                                            Fluttertoast.showToast(
                                                msg:
                                                    '${lang?.getTranslatedValue('Please check your internet connection.')}',
                                                backgroundColor:
                                                    AppColors.RED_COLOR,
                                                toastLength:
                                                    Toast.LENGTH_SHORT);
                                          }
                                        } else {
                                          return;
                                        }
                                      }
                                      // Navigator.push(context, MaterialPageRoute(builder: (context) => BottomBarPage(index: 0,),));
                                    },
                                    color: AppColors.PRIMERY_COLOR,
                                    child: Center(
                                        child: (!state.isLoading)
                                            ? appText(
                                                title: lang?.getTranslatedValue(
                                                    'Login'),
                                                color: AppColors.WHITE_COLOR,
                                              )
                                            : Loader(color: AppColors.WHITE_COLOR))),
                              ),
                              SizedBox(
                                height: 1.h,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  appText(
                                      title: lang?.getTranslatedValue(
                                          'Don’t have an account?'),
                                      fontSize: 1.8.h,
                                      color: AppColors.FONT_COLOR,
                                      fontWeight: FontWeight.w600),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const SingUpPage(),
                                          ));
                                    },
                                    child: appText(
                                      title: lang?.getTranslatedValue('Singup'),
                                      fontSize: 1.8.h,
                                      color: AppColors.PRIMERY_COLOR,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                }
                return Container();
              },
            )));
  }
}
