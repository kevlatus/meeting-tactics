import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meet/routes.dart';
import 'package:meet/widgets/widgets.dart';

import 'auth_bloc.dart';
import 'login_form.dart';

class LoginScreen extends StatelessWidget {
  static Page page() {
    return MaterialPage(
      key: ValueKey('LoginScreen'),
      child: LoginScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state.status == AuthStatus.Authenticated) {
          Navigator.of(context).pushReplacementNamed(AppRouter.root);
        }
      },
      child: AppLayout(builder: (context) {
        return LoginForm();
      }),
    );
  }
}
