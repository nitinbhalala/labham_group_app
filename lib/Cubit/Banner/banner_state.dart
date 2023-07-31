// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';

abstract class GetBannerState extends Equatable{

}
class GetBannerInitialState extends GetBannerState{
  @override
  List<Object?> get props => [];

}
class GetBannerLodingState extends GetBannerState{
  @override
  List<Object?> get props => [];

}
class GetBannerLoadadState extends GetBannerState{
  List<dynamic> banner;
  GetBannerLoadadState(this.banner);
  @override
  List<Object?> get props => [banner];

}

class GetBannerErrorState extends GetBannerState{
  String error;
  GetBannerErrorState({required this.error});
  @override
  List<Object?> get props => [error];

}

