// ignore_for_file: unused_local_variable, invalid_use_of_visible_for_testing_member

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minimall_store/services/api_services.dart';
import 'video_sate.dart';

class VideoListCubit extends Cubit<VideoListState> {
  // final LabhamRepository _labhamRepository;
  ApiServices apiServices = ApiServices();

  VideoListCubit(this.apiServices) : super(VideoListInitalState()) {
    fatchVideoList();
  }

  Future fatchVideoList()async{
    emit(VideoListLodingState());
    try{
      final response = await apiServices.getVideoList();
      emit(VideoLoadadState(response));
    }catch(e){
      emit(VideoListErrorState(error: e.toString()));
    }
  }
}
