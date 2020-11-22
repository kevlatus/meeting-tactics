import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meet/auth/auth.dart';

enum LoginStatus {
  Success,
  Failure,
  Pending,
  Pure,
}

class LoginState extends Equatable {
  final LoginStatus status;

  LoginState({this.status});

  LoginState copyWith({LoginStatus status}) {
    return LoginState(
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props => [status];
}

class LoginCubit extends Cubit<LoginState> {
  final AuthRepository _authRepository;

  LoginCubit(this._authRepository)
      : assert(_authRepository != null),
        super(LoginState());

  Future<void> signInWithGoogle() async {
    emit(state.copyWith(status: LoginStatus.Pending));
    try {
      await _authRepository.signInWithGoogle();
      emit(state.copyWith(status: LoginStatus.Success));
    } on Exception {
      emit(state.copyWith(status: LoginStatus.Failure));
    }
  }
}
