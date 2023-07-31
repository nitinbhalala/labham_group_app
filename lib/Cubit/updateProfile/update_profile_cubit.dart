// ignore_for_file: avoid_print, unused_local_variable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:minimall_store/Cubit/updateProfile/update_profile_state.dart';
import 'package:minimall_store/constants/app_colors.dart';
import 'package:minimall_store/services/api_services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../views/pages/Bottombar_page.dart';

class UpdateProfileCubit extends Cubit<UpdateProfileState> {
  ApiServices apiServices = ApiServices();
  UpdateProfileCubit(this.apiServices)
      : super(LoadedUpdateProfileState(isLoading: false));
      
  Future updateProfile({
    required String userName,
    required String email,
    required String mobileno,
    required BuildContext context,
    XFile? avatar,
    XFile? appLogo,
    XFile? userLogo,
  }) async {
    emit(LoadedUpdateProfileState(isLoading: true));
    int status = 1;
    final prefs = await SharedPreferences.getInstance();
    String? lang = prefs.getString('language');
    
    final updateProfile =await apiServices
        .updateProfile(userName, email, mobileno, avatar, appLogo, userLogo)
        .then((value) {
      if (value['status']) {
        prefs.setString('name', value['data']['name']);
        prefs.setString('phone', value['data']['phone']);
        prefs.setString('email', value['data']['email']);
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
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => BottomBarPage(index: 2),
            ));
      } else {
        Fluttertoast.showToast(
            msg: value['message'],
            backgroundColor: AppColors.RED_COLOR,
            toastLength: Toast.LENGTH_SHORT);
      }
    });
    emit(LoadedUpdateProfileState(isLoading: false));
    return updateProfile;
  }
}
