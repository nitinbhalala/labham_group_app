// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';

abstract class RegisterState extends Equatable {}

class LoadedRegisterState extends RegisterState {
  bool isLoading;
  LoadedRegisterState({required this.isLoading});
  @override
  List get props => [isLoading];
}

