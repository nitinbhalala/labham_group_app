// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';

abstract class EstimateListState extends Equatable{

}

class EstimateListInitalState extends EstimateListState{
  @override
  List<Object?> get props => [];

}

class EstimateListLodingState extends EstimateListState{
  @override
  List<Object?> get props => [];

}
class EstimateListLoadadState extends EstimateListState{
  List<dynamic> estimate;

  EstimateListLoadadState(this.estimate,);
  @override
  List<Object?> get props => [estimate];

}

class EstimateListErrorState extends EstimateListState{
  String error;
  EstimateListErrorState({required this.error});
  @override
  List<Object?> get props => [error];

}

