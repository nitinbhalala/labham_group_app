// ignore_for_file: avoid_print, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:minimall_store/Cubit/login/login_state.dart';
import 'package:minimall_store/services/api_services.dart';
import 'package:minimall_store/views/pages/Bottombar_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constants/app_colors.dart';

class LoginCubit extends Cubit<LoginState> {
  ApiServices apiServices = ApiServices();
  LoginCubit(this.apiServices) : super(LoadedLoginState(isLoading: false));

  Future submitLoginButton(
      {required String mobileNo,
      required String password,
      required BuildContext context}) async {
        emit(LoadedLoginState(isLoading: true));
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final response =
        await apiServices.loginUser(mobileNo, password).then((value) {
          print("PRINT LOGIN VALUE : $value");
      if (value['status']) {
        prefs.setString('id', value['data']['id'].toString());
        prefs.setString('name', value['data']['name']);
        prefs.setString('language', value['data']['language']);
        prefs.setString('email', value['data']['email']);
        prefs.setString('phone', value['data']['phone']);
        prefs.setString('token', value['data']['api_token']);
        prefs.setBool('status', value['status']);
        prefs.setString('userType', value['data']['user_type']);
        if (value['data']['avatar_url'] != null) {
          prefs.setString('avatar', value['data']['avatar_url']);
        }
        if (value['data']['app_logo_url'] != null) {
          prefs.setString('app_logo_url', value['data']['app_logo_url']);
        }
        if (value['data']['user_logo_url'] != null) {
          prefs.setString('user_logo_url', value['data']['user_logo_url']);
        }

        Fluttertoast.showToast(
            msg: value['message'],
            backgroundColor: AppColors.PRIMERY_COLOR,
            toastLength: Toast.LENGTH_SHORT);

        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => BottomBarPage(index: 0),
            ));
      } else {
        Fluttertoast.showToast(
            msg: value['message'].toString(),
            backgroundColor: AppColors.RED_COLOR,
            toastLength: Toast.LENGTH_SHORT);
      }
    });
   emit(LoadedLoginState(isLoading: false));
    return response;
  }


}
