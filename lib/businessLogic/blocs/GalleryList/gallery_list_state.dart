// ignore_for_file: must_be_immutable, prefer_typing_uninitialized_variables

import 'package:equatable/equatable.dart';

abstract class GalleryListState extends Equatable{}

class GalleryInitialState extends GalleryListState{
  @override
  List<Object?> get props => [];
}


class GalleryLodingState extends GalleryListState{
  @override
  List<Object?> get props => [];

}

class GalleryLoadadState extends GalleryListState{
   List<dynamic> gallery;
  GalleryLoadadState(this.gallery);
  @override
  List<Object?> get props => [gallery];

}

class GalleryErrorState extends GalleryListState{
  String error;
  GalleryErrorState({required this.error});
  @override
  List<Object?> get props => [error];
}

