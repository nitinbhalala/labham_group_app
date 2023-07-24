// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';

abstract class ChangePassowrdState extends Equatable {}

class InitialPasswordState extends ChangePassowrdState {
  @override
  List get props => [];
}

class LoadingpasswordState extends ChangePassowrdState {
  @override
  List get props => [];
}

class LoadedpasswordState extends ChangePassowrdState {
  bool isLoading;
  LoadedpasswordState({required this.isLoading});
  @override
  List get props => [isLoading];
}

