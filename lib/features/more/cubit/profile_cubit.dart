import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icthub_2024_9/features/more/cubit/profile_states.dart';
import 'package:icthub_2024_9/features/more/data/data_source/profile_data_source.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileLoading());

  final ProfileDataSource profileDataSource = ProfileDataSource();

  void getUserData() async {
    try {
      emit(ProfileLoading());
      final userData = await profileDataSource.getUserData();

      emit(ProfileLoaded(userData));
    } catch (e) {
      if (e.toString().contains('user_not_found')) {
        emit(ProfileErrorUserNotFound('User not found'));
      } else {
        emit(ProfileErrorState('An error occurred'));
      }
    }
  }

  void upDateUserData({
    required String name,
    required String phone,
  }) async {
    try {
      await profileDataSource.setUserData(
        name: name,
        phone: phone,
      );
      getUserData();
    } catch (e) {
      emit(ProfileErrorState('An error occurred'));
    }
  }
}
