import 'package:flutter/widgets.dart';

import 'delegate.dart';
import 'models.dart';

extension AppRouterExt on Router {
  AppRouterDelegate get appRouterDelegate {
    final delegate = routerDelegate as AppRouterDelegate;
    assert(
      delegate != null && delegate is AppRouterDelegate,
      'Router delegate not found or wrong type',
    );
    return delegate;
  }

  void push(String path) {
    appRouterDelegate.push(path);
  }

  void pushRoute(RouteDef routeDef, [Map<String, String> params]) {
    appRouterDelegate.pushRoute(routeDef, params);
  }

  void pop() {
    appRouterDelegate.pop();
  }

  void replace(String path) {
    appRouterDelegate.replace(path);
  }

  void replaceRoute(RouteDef routeDef, [Map<String, String> params]) {
    appRouterDelegate.replaceRoute(routeDef, params);
  }

  bool isActive(String path) {
    return appRouterDelegate.currentConfiguration?.path == path;
  }
}
