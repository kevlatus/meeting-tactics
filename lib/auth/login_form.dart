import 'package:flutter/material.dart';
import 'package:meet/auth/auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        RaisedButton(
          onPressed: () =>
              context.repository<AuthRepository>().signInWithGoogle(),
          child: Text('Sign in with Google'),
        ),
        FlatButton(
          onPressed: () async {
            context.repository<AuthRepository>().signOut();
          },
          child: Text('Sign Out'),
        ),
      ],
    );
  }
}
