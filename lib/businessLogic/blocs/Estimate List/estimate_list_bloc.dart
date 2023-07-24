// ignore_for_file: unused_local_variable

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minimall_store/services/api_services.dart';
import 'estimate_list_sate.dart';

class EstimateListCubit extends Cubit<EstimateListState> {
  ApiServices apiServices = ApiServices();

  EstimateListCubit(this.apiServices) : super(EstimateListInitalState()) {
    fatchEstimateList();
  }

  Future fatchEstimateList() async {
    emit(EstimateListLodingState());
    try {
      final response = await apiServices.estimateList();
      emit(EstimateListLoadadState(response));
    } catch (e) {
      emit(EstimateListErrorState(error: e.toString()));
    }
  }

  Future deleteEstimate(int id) async {
    try {
      final response = await apiServices.deleteEstimate(id);
      final estimateList = await apiServices.estimateList();
      emit(EstimateListLoadadState(estimateList));
    } catch (e) {
      emit(EstimateListErrorState(error: e.toString()));
    }
  }
}
