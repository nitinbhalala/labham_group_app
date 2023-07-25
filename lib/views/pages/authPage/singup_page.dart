// ignore_for_file: avoid_print, unused_local_variable, unused_element, unrelated_type_equality_checks, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:minimall_store/businessLogic/blocs/register/register_state.dart';
import 'package:minimall_store/services/api_services.dart';
import 'package:minimall_store/views/comman/function.dart';
import 'package:minimall_store/views/pages/authPage/login_page.dart';
import 'package:minimall_store/views/pages/terms_and_condition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import '../../../Localization/app_localization.dart';
import '../../../businessLogic/blocs/register/register_cubit.dart';
import '../../../constants/app_assets.dart';
import '../../../constants/app_colors.dart';
import '../../comman/app_button.dart';
import '../../comman/app_dialogs.dart';
import '../../comman/app_text.dart';
import '../../comman/app_textfiled.dart';
import '../../comman/connectivity_check.dart';
import '../../comman/loader.dart';

class SingUpPage extends StatefulWidget {
  const SingUpPage({super.key});

  @override
  State<SingUpPage> createState() => _SingUpPageState();
}

class _SingUpPageState extends State<SingUpPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _obscureText = true;

  void _obscureTextChnage() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  String? privacy;

  Functions function = Functions();
  _getData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      privacy = prefs.getString('privacy_policy_url');
    });
  }

  TextEditingController userNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController mobileNoController = TextEditingController();
  TextEditingController passowrdController = TextEditingController();

  int status = 1;
  bool isValidNumber = false;
  bool isPassValid = false;
  bool isemailValid = false;
  bool isnamevallid = false;
  ApiServices apiServices = ApiServices();

  void _singButtonSubmit() async {
    if (_formKey.currentState!.validate()) {
      apiServices
          .registerUser(
        userNameController.text,
        emailController.text,
        mobileNoController.text,
        passowrdController.text,
        status,
      )
          .then((value) {
        if (value['status']) {
          final snackBar = SnackBar(
            content: appText(title: value['message']),
            backgroundColor: AppColors.PRIMERY_COLOR,
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const LoginPage()));
        } else {
          final snackBar = SnackBar(
            content: appText(title: value['message']),
            backgroundColor: AppColors.RED_COLOR,
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      });
    } else {
      print("Something Error:-");
    }
  }

  bool? isConnected;
  getinternet() async {
    isConnected = await ConnectivityService.isConnected;
    if (isConnected == false) {
      AppDialog.showInternetDialog(
        context,
        onTap: () {
          RegisterCubit(ApiServices());
          Navigator.pop(context);
          getinternet();
        },
      );
    }
  }

  @override
  void initState() {
    _getData();
    getinternet();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var lang = AppLocalization.of(context);
    return BlocProvider(
      create: (context) => RegisterCubit(ApiServices()),
      child: Scaffold(
        backgroundColor: AppColors.WHITE_COLOR,
        body: BlocBuilder<RegisterCubit, RegisterState>(
          builder: (context, state) {
            if (state is LoadedRegisterState) {
              return SafeArea(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 3.h),
                  child: SingleChildScrollView(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // SizedBox(
                          //   height: 2.h,
                          // ),
                          Center(
                            child: Image.asset(
                              AppAssets.LABHAM_LOGO,
                              height: 25.h,
                            ),
                          ),
                          SizedBox(
                            height: 2.h,
                          ),
                          appText(
                              title: lang?.getTranslatedValue('Singup'),
                              fontSize: 3.5.h,
                              color: AppColors.FONT_COLOR,
                              fontWeight: FontWeight.w600),
                          SizedBox(
                            height: 1.h,
                          ),
                          appText(
                              title: lang?.getTranslatedValue(
                                  'Enter your credentials to continue'),
                              fontSize: 1.6.h,
                              color: AppColors.GREY,
                              fontWeight: FontWeight.w600),
                          SizedBox(
                            height: 4.h,
                          ),
                          appText(
                              title: lang?.getTranslatedValue('Name'),
                              fontSize: 1.6.h,
                              color: AppColors.GREY,
                              fontWeight: FontWeight.w600),
                          SizedBox(
                            height: 2.h,
                          ),
                          appTextfild(
                            controller: userNameController,
                            hint: lang?.getTranslatedValue('Name'),
                            keyboardType: TextInputType.name,
                            textInputAction: TextInputAction.next,
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
                                    'Please Enter your name');
                              } else {
                                return null;
                              }
                            },
                          ),
                          SizedBox(
                            height: 2.h,
                          ),
                          appText(
                              title: lang?.getTranslatedValue('Email'),
                              fontSize: 1.6.h,
                              color: AppColors.GREY,
                              fontWeight: FontWeight.w600),
                          SizedBox(
                            height: 2.h,
                          ),
                          appTextfild(
                            controller: emailController,
                            hint: lang?.getTranslatedValue('Enter Email'),
                            keyboardType: TextInputType.emailAddress,
                            textInputAction: TextInputAction.next,
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(4),
                              borderSide: const BorderSide(
                                  width: 0.3, color: AppColors.GREY),
                            ),
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
                                return lang
                                    ?.getTranslatedValue('Please Enter Email');
                              } else {
                                return null;
                              }
                            },
                          ),
                          SizedBox(
                            height: 2.h,
                          ),
                          appText(
                              title: lang?.getTranslatedValue('Mobile Number'),
                              fontSize: 1.6.h,
                              color: AppColors.GREY,
                              fontWeight: FontWeight.w600),
                          SizedBox(
                            height: 2.h,
                          ),
                          appTextfild(
                            controller: mobileNoController,
                            hint:
                                lang?.getTranslatedValue('Enter Mobile Number'),
                            keyboardType: TextInputType.number,
                            textInputAction: TextInputAction.next,
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
                                    'Please Enter Mobile number');
                              } else if (val!.length < 10) {
                                return lang?.getTranslatedValue(
                                    'Enter valid mobilnumber');
                              } else {
                                return null;
                              }
                            },
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(10),
                            ],
                          ),
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
                              controller: passowrdController,
                              hint: lang?.getTranslatedValue('Enter Password'),
                              keyboardType: TextInputType.visiblePassword,
                              obscureText: _obscureText,
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(4),
                                borderSide: const BorderSide(
                                    width: 0.3, color: AppColors.GREY),
                              ),
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
                                      'Please Enter password');
                                } else {
                                  return null;
                                }
                              },
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
                              )),
                          SizedBox(
                            height: 1.h,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  appText(
                                    title: lang?.getTranslatedValue(
                                        'By continuing you agree to our'),
                                    fontSize: 1.6.h,
                                    color: AppColors.GREY,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      function.launchPrivacy(privacy.toString());
                                    },
                                    child: appText(
                                      title: lang?.getTranslatedValue(
                                          'Privacy Policy'),
                                      fontSize: 1.6.h,
                                      color: AppColors.PRIMERY_COLOR,
                                    ),
                                  ),
                                ],
                              ),

                            ],
                          ),
                          SizedBox(
                            height: 4.h,
                          ),
                          Center(
                            child: appButton(
                                onTap: () async {
                                  bool isConnected =
                                      await ConnectivityService.isConnected;
                                  FocusScope.of(context)
                                      .requestFocus(FocusNode());
                                  if (!state.isLoading) {
                                    if (_formKey.currentState!.validate()) {
                                      if (isConnected) {
                                        context
                                            .read<RegisterCubit>()
                                            .registerRepository(
                                              userName: userNameController.text,
                                              email: emailController.text,
                                              mobileno: mobileNoController.text,
                                              password: passowrdController.text,
                                              context: context,
                                            );
                                      } else {
                                        Fluttertoast.showToast(
                                            msg:
                                                '${lang?.getTranslatedValue('Please check your internet connection.')}',
                                            backgroundColor:
                                                AppColors.RED_COLOR,
                                            toastLength: Toast.LENGTH_SHORT);
                                      }
                                    } else {
                                      return;
                                    }
                                  }
                                  // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginPage(),));
                                },
                                child: Center(
                                    child: (!state.isLoading)
                                        ? appText(
                                            title: lang
                                                ?.getTranslatedValue('Singup'),
                                            color: AppColors.WHITE_COLOR,
                                            fontWeight: FontWeight.w600)
                                        : Loader(
                                            color: AppColors.WHITE_COLOR))),
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
                                  Navigator.pop(context);
                                },
                                child: appText(
                                    title: lang?.getTranslatedValue('Login'),
                                    fontSize: 1.8.h,
                                    color: AppColors.PRIMERY_COLOR,
                                    fontWeight: FontWeight.w600),
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
        ),
      ),
    );
  }
}
