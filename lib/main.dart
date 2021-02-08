import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'app.dart';
import 'configure_non_web.dart' if (dart.library.html) 'configure_web.dart';

class SimpleBlocObserver extends BlocObserver {
  @override
  void onChange(Cubit cubit, Change change) {
    print('${cubit.runtimeType} $change');
    super.onChange(cubit, change);
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox('settings');

  if (kDebugMode) Bloc.observer = SimpleBlocObserver();
  EquatableConfig.stringify = kDebugMode;

  // final authRepo = AuthenticationRepository(
  //   googleSignIn: GoogleSignIn(
  //     scopes: [
  //       'https://www.googleapis.com/auth/calendar.readonly',
  //       'https://www.googleapis.com/auth/calendar.events.readonly',
  //     ],
  //   ),
  // );
  configureApp();
  runApp(MeetApp());
}
