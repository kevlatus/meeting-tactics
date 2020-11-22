import 'package:bloc/bloc.dart';
import 'package:calendar_service/calendar_service.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'app.dart';
import 'auth/auth.dart';

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
  await Firebase.initializeApp();
  EquatableConfig.stringify = kDebugMode;

  final authRepo = AuthRepository(
    googleSignIn: GoogleSignIn(
      scopes: [
        'https://www.googleapis.com/auth/calendar.readonly',
        'https://www.googleapis.com/auth/calendar.events.readonly',
      ],
    ),
  );
  runApp(
    MeetApp(
      authRepository: authRepo,
      calendarRepository: GoogleCalendarRepository(authRepo),
    ),
  );
}
