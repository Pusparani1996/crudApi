import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'authflow_state.dart';

class AuthflowCubit extends Cubit<AuthflowState> {
  AuthflowCubit() : super(AuthflowState(status: LoginStatus.initialstate));
  void getloginstatus() async {
    final prefs = await SharedPreferences.getInstance();

    if (prefs.containsKey('token')) {
      emit(AuthflowState(status: LoginStatus.loginstate));
    } else {
      emit(AuthflowState(status: LoginStatus.logoutstate));
    }
  }
}
