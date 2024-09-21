import 'package:icthub_2024_9/features/more/data/data_model/user_model.dart';

abstract class ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileErrorState extends ProfileState {
  final String message;

  ProfileErrorState(this.message);
}

class ProfileErrorUserNotFound extends ProfileState {
  final String message;

  ProfileErrorUserNotFound(this.message);
}

class ProfileLoaded extends ProfileState {
  final UserModel user;

  ProfileLoaded(this.user);
}
