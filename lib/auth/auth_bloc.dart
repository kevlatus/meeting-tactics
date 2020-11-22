import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:meet/auth/auth.dart';

import 'auth_models.dart';

enum AuthStatus { Authenticated, Unauthenticated, Unknown }

class AuthState extends Equatable {
  final AuthStatus status;
  final User user;

  const AuthState._({
    this.status = AuthStatus.Unknown,
    this.user = User.empty,
  });

  const AuthState.unknown() : this._();

  const AuthState.authenticated(User user)
      : this._(
          status: AuthStatus.Authenticated,
          user: user,
        );

  const AuthState.unauthenticated()
      : this._(status: AuthStatus.Unauthenticated);

  @override
  List<Object> get props => [status, user];
}

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class AuthUserChanged extends AuthEvent {
  final User user;

  const AuthUserChanged(this.user);

  @override
  List<Object> get props => [user];
}

class AuthSignOutRequested extends AuthEvent {}

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _authRepository;
  StreamSubscription<User> _userSubscription;

  AuthState _mapAuthenticationUserChangedToState(AuthUserChanged event) {
    return event.user != User.empty
        ? AuthState.authenticated(event.user)
        : const AuthState.unauthenticated();
  }

  AuthBloc({
    @required AuthRepository authRepository,
  })  : assert(authRepository != null),
        _authRepository = authRepository,
        super(const AuthState.unknown()) {
    _userSubscription = _authRepository.user.listen(
      (user) => add(AuthUserChanged(user)),
    );
  }

  @override
  Stream<AuthState> mapEventToState(AuthEvent event) async* {
    if (event is AuthUserChanged) {
      yield _mapAuthenticationUserChangedToState(event);
    } else if (event is AuthSignOutRequested) {
      _authRepository.signOut();
    }
  }

  @override
  Future<void> close() {
    _userSubscription?.cancel();
    return super.close();
  }
}
