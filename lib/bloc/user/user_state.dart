part of 'user_cubit.dart';

abstract class UserState extends Equatable {
  const UserState();

  @override
  List<Object> get props => [];
}

class UserInitial extends UserState {}

class UserLoggedIn extends UserState {}

class UserFailedLogin extends UserState {
  final error;
  UserFailedLogin({required this.error});
}

class UserLoading extends UserState {}

class UserNotLoggedIn extends UserState {}
