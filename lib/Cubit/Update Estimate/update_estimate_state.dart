// ignore_for_file: camel_case_types, must_be_immutable

import 'package:equatable/equatable.dart';

abstract class UpdateEstimateState extends Equatable {}

class LoadingUdateEstimateState extends UpdateEstimateState {
  @override
  List get props => [];
}

class LoadedUpdateEstimateState extends UpdateEstimateState {
  bool isLoading;
 LoadedUpdateEstimateState({required this.isLoading});
  @override
  List get props => [isLoading];
}


