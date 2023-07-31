// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:minimall_store/Cubit/register/register_state.dart';
import 'package:minimall_store/services/api_services.dart';
import 'package:minimall_store/views/pages/authPage/login_page.dart';

import '../../constants/app_colors.dart';

class RegisterCubit extends Cubit<RegisterState> {
  ApiServices apiServices = ApiServices();
  RegisterCubit(this.apiServices) : super(LoadedRegisterState(isLoading: false));

  Future registerRepository({
    required String userName,
    required String email,
    required String mobileno,
    required String password,
    required BuildContext context,
  }) async {
    int status = 1;
    emit(LoadedRegisterState(isLoading: true));
    var register = await apiServices
        .registerUser(
      userName,
      email,
      mobileno,
      password,
      status,
    )
        .then((value) {
      if (value['status']) {
        Fluttertoast.showToast(
            msg: value['message'],
            backgroundColor: AppColors.PRIMERY_COLOR,
            toastLength: Toast.LENGTH_SHORT);

        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const LoginPage()));
      } else {
        Fluttertoast.showToast(
            msg: value['message'],
            backgroundColor: AppColors.RED_COLOR,
            toastLength: Toast.LENGTH_SHORT);
      }
    });
    emit(LoadedRegisterState(isLoading: false));
    return register;
  }
}
