import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'app.dart';

class SimpleBlocObserver extends BlocObserver {
  @override
  void onChange(Cubit cubit, Change change) {
    print('${cubit.runtimeType} $change');
    super.onChange(cubit, change);
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Bloc.observer = SimpleBlocObserver();
  EquatableConfig.stringify = kDebugMode;

  // final authRepo = AuthenticationRepository(
  //   googleSignIn: GoogleSignIn(
  //     scopes: [
  //       'https://www.googleapis.com/auth/calendar.readonly',
  //       'https://www.googleapis.com/auth/calendar.events.readonly',
  //     ],
  //   ),
  // );
  runApp(
    MeetApp(),
  );
}
