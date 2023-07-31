// ignore_for_file: camel_case_types, must_be_immutable

import 'package:equatable/equatable.dart';

abstract class CreateEstimateState extends Equatable {}

class LoadingCreateEstimateState extends CreateEstimateState {
  @override
  List get props => [];
}

class LoadedCreateEstimateState extends CreateEstimateState {
  bool isLoading;
 LoadedCreateEstimateState({required this.isLoading});
  @override
  List get props => [isLoading];
}

// class UpdateAddressState extends AddAddressState {
//   @override
//   List get props => [];
// }

// class checkZipcodeState extends AddAddressState {
//   @override
//   List get props => [];
// }
