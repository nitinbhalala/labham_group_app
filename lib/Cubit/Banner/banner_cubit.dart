// ignore_for_file: unused_local_variable

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minimall_store/Cubit/Banner/banner_state.dart';
import 'package:minimall_store/services/api_services.dart';


class GetBannerCubit extends Cubit<GetBannerState> {

  ApiServices apiServices =ApiServices();

  GetBannerCubit(this.apiServices) : super(GetBannerInitialState()) {
    fatchBanner();
  }

  Future fatchBanner()async{
 emit(GetBannerLodingState());
 try{
  final response = await apiServices.getBanner();
  emit(GetBannerLoadadState(response));
 }catch(e){
  emit(GetBannerErrorState(error: e.toString()));
 }
  
  }
}
