part of 'authflow_cubit.dart';

enum LoginStatus { initialstate, loginstate, logoutstate }

class AuthflowState extends Equatable {
  const AuthflowState({required this.status});
  final LoginStatus status;

  @override
  List<Object?> get props => [status];
}
