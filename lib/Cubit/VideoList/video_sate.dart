// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';

abstract class VideoListState extends Equatable{

}
class VideoListInitalState extends VideoListState{
  @override
  List<Object?> get props => [];

}

class VideoListLodingState extends VideoListState{
  @override
  List<Object?> get props => [];

}
class VideoLoadadState extends VideoListState{
  List<dynamic> video;
  VideoLoadadState(this.video);
  @override
  List<Object?> get props => [video];

}

class VideoListErrorState extends VideoListState{
  String error;
  VideoListErrorState({required this.error});
  @override
  List<Object?> get props => [error];

}

