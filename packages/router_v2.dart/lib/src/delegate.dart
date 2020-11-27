import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'models.dart';
import 'router.dart';

class _RouteStack {
  final ListQueue<AppRoute> _stack = ListQueue<AppRoute>();

  AppRoute get active => _stack.isNotEmpty ? _stack.last : null;
  AppRoute get previous =>
      _stack.length > 1 ? _stack.elementAt(_stack.length - 2) : null;

  /// Returns the pages corresponding to the current stack.
  /// Makes sure, that the list only contains the last occurence of duplicate routes.
  List<Page> get pages => _stack.toList().reversed.fold(
        <Page>[],
        (acc, route) {
          final samePage = acc.firstWhere(
            (page) => page.key == route.page.key,
            orElse: () => null,
          );
          if (samePage == null) {
            acc.insert(0, route.page);
          }
          return acc;
        },
      );

  void push(AppRoute route, [Map<String, dynamic> params]) {
    if (_stack.isNotEmpty && _stack.last.page.key == route.page.key) {
      return;
    }
    _stack.add(route);
  }

  void pop() {
    _stack.removeLast();
  }
}

class AppRouterDelegate extends RouterDelegate<AppRoute>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<AppRoute> {
  final _RouteStack _routeStack = _RouteStack();
  final RouterConfig _routerConfig;

  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  void _push(AppRoute route) {
    _routeStack.push(route);
    notifyListeners();
  }

  AppRouterDelegate(this._routerConfig) : assert(_routerConfig != null);

  bool get canPop => _routeStack.previous != null;

  void push(String path) {
    final route = _routerConfig.findByPath(path);
    _push(route);
  }

  void pushRoute(RouteDef routeDef, [Map<String, String> params]) {
    final route = _routerConfig.findByDef(routeDef, params);
    _push(route);
  }

  void pop() {
    _routeStack.pop();
    notifyListeners();
  }

  void replace(String path) {
    final route = _routerConfig.findByPath(path);
    _routeStack.pop();
    _routeStack.push(route);
    notifyListeners();
  }

  void replaceRoute(RouteDef routeDef, [Map<String, String> params]) {
    final route = _routerConfig.findByDef(routeDef, params);
    _routeStack.pop();
    _routeStack.push(route);
    notifyListeners();
  }

  @override
  AppRoute get currentConfiguration => _routeStack.active;

  @override
  Future<void> setInitialRoutePath(AppRoute route) {
    return setNewRoutePath(route);
  }

  @override
  Future<void> setNewRoutePath(AppRoute route) {
    if (kIsWeb && _routeStack.previous == route) {
      _routeStack.pop();
    } else {
      _routeStack.push(route);
    }
    return SynchronousFuture(null);
  }

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      pages: _routeStack.pages,
      onPopPage: (route, result) {
        if (!route.didPop(result)) {
          return false;
        }

        _routeStack.pop();
        notifyListeners();
        return true;
      },
    );
  }
}
