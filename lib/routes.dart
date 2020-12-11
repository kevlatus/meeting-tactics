import 'package:fluro/fluro.dart';
import 'package:flutter/widgets.dart';
import 'package:meet/screens/screens.dart';

final _rootHandler = Handler(
  handlerFunc: (BuildContext context, Map<String, List<String>> params) {
    return HomeScreen();
  },
);

final _meetingSetupHandler = Handler(
  handlerFunc: (BuildContext context, Map<String, List<String>> params) {
    return MeetingSetupScreen();
  },
);

final _meetingSessionHandler = Handler(
  handlerFunc: (BuildContext context, Map<String, List<String>> params) {
    return MeetingSessionScreen();
  },
);

final _notFoundHandler = Handler(
  handlerFunc: (BuildContext context, Map<String, List<String>> params) {
    return UnknownScreen();
  },
);

class AppRouter {
  static FluroRouter _instance;

  static const String root = "/";
  static const String meetingSetup = "/meeting/setup";
  static const String meetingSession = "/meeting/session";
  static const String settings = "/settings";

  static void _configureRoutes() {
    _instance.notFoundHandler = _notFoundHandler;
    _instance.define(root, handler: _rootHandler);
    _instance.define(meetingSetup, handler: _meetingSetupHandler);
    _instance.define(meetingSession, handler: _meetingSessionHandler);
  }

  static RouteFactory get generator {
    if (_instance == null) {
      _instance = FluroRouter();
      _configureRoutes();
    }
    return _instance.generator;
  }
}
