// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';

abstract class UpdateProfileState extends Equatable {}

class LoadingUpdateProfileState extends UpdateProfileState {
  @override
  List get props => [];
}

class LoadedUpdateProfileState extends UpdateProfileState {
  bool isLoading;
  LoadedUpdateProfileState({required this.isLoading});
  @override
  List get props => [isLoading];
}

