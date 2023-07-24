// ignore_for_file: unused_local_variable, prefer_typing_uninitialized_variables

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minimall_store/services/api_services.dart';
import 'gallery_list_state.dart';

class GallerytListCubit extends Cubit<GalleryListState> {
  // final LabhamRepository _labhamRepository;
  ApiServices apiServices = ApiServices();
 
  GallerytListCubit(this.apiServices) : super(GalleryLodingState()) {
    fatchGalleryList();
  }
  
  Future fatchGalleryList()async{
    emit(GalleryLodingState());
    try{
      final response =  await apiServices.galleryList();
      emit(GalleryLoadadState(response));
    }catch(e){
      emit(GalleryErrorState(error: e.toString()));

    }
  }
}
