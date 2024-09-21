import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icthub_2024_9/features/login/cubit/login_states.dart';
import 'package:icthub_2024_9/features/login/data/data_source/login_data_source.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginInitial());
  final LoginDataSource dataSource = LoginDataSource();

  void login({
    required String email,
    required String password,
  }) async {
    emit(LoginLoading());
    try {
      await dataSource.login(email: email, password: password);

      emit(LoginSuccess('Login success!'));
    } catch (e) {
      emit(LoginError(e.toString()));
    }
  }
}
