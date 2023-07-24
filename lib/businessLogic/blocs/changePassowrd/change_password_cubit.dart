// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:minimall_store/businessLogic/blocs/changePassowrd/change_passowrd_state.dart';
import 'package:minimall_store/services/api_services.dart';
import '../../../constants/app_colors.dart';

class ChangePasswordCubit extends Cubit<ChangePassowrdState> {
  ApiServices apiServices = ApiServices();
  ChangePasswordCubit(this.apiServices) : super(LoadedpasswordState(isLoading: false));

 Future changePassowrd({required String currentPassowrd, required String newPassowrd,
        required BuildContext context}) async {
      emit(LoadedpasswordState(isLoading: true));
      final response = await apiServices
          .changePassowrd(currentPassowrd, newPassowrd)
          .then((value) {
        if (value['status']) {
          Fluttertoast.showToast(
              msg: value['message'],
              backgroundColor: AppColors.PRIMERY_COLOR,
              toastLength: Toast.LENGTH_SHORT);
          Navigator.pop(context);
        } else {
          Fluttertoast.showToast(
              msg: value['message'],
              backgroundColor: AppColors.RED_COLOR,
              toastLength: Toast.LENGTH_SHORT);
        }
      });
      emit(LoadedpasswordState(isLoading: false));
      return response;
    }
}
