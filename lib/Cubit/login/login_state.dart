// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';

abstract class LoginState extends Equatable {}


class LoadedLoginState extends LoginState {
 bool isLoading;
 LoadedLoginState({required this.isLoading});
  @override
  List get props => [isLoading];
}
