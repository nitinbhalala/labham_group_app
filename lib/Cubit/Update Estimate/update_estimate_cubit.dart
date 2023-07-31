// ignore_for_file: avoid_print, non_constant_identifier_names, unused_local_variable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:minimall_store/Cubit/Update%20Estimate/update_estimate_state.dart';
import 'package:minimall_store/constants/app_colors.dart';
import 'package:minimall_store/services/api_services.dart';
import 'package:minimall_store/views/pages/Bottombar_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UpdateEstimateCubit extends Cubit<UpdateEstimateState> {
  ApiServices apiServices = ApiServices();
  UpdateEstimateCubit(this.apiServices)
      : super(LoadedUpdateEstimateState(isLoading: false));
  Future updateEstimate(
      {BuildContext? context,
      var longList,
      var shortList,
      required String id,
      required String name,
      required String mobile_number,
      required String address,
      required String totalListPrice,
      required String total_inch,
      required String total_sqft}) async {
    final prefs = await SharedPreferences.getInstance();

    emit(LoadedUpdateEstimateState(isLoading: true));
    var createEstimate = await apiServices
        .updateEstimate(
      longList,
      shortList,
      id,
      name,
      mobile_number,
      address,
      totalListPrice,
      total_inch,
      total_sqft,
    )
        .then((value) {
      if (value['status'] == true) {
        Fluttertoast.showToast(
            msg: value['message'].toString(),
            backgroundColor: AppColors.PRIMERY_COLOR,
            toastLength: Toast.LENGTH_SHORT);

        Navigator.push(
            context!,
            MaterialPageRoute(
                builder: (context) => BottomBarPage(
                      index: 1,
                    )));
      } else {
        Fluttertoast.showToast(
            msg: value['message'].toString(),
            backgroundColor: AppColors.RED_COLOR,
            toastLength: Toast.LENGTH_SHORT);
      }
    });
    emit(LoadedUpdateEstimateState(isLoading: false));
    return createEstimate;
  }
}
