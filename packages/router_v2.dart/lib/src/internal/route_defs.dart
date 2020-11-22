import 'package:meta/meta.dart';
import 'package:quiver/core.dart';

import '../models.dart';
import 'path_matching.dart';

// TODO: equality
class SimplePageRoute implements RouteDef {
  final PageBuilder builder;
  final String path;
  final RoutePathMatch pathMatch;
  final UriPathPattern pathTemplate;

  SimplePageRoute({
    @required this.builder,
    @required this.path,
    @required this.pathMatch,
  })  : assert(builder != null),
        assert(path != null),
        assert(pathMatch != null),
        pathTemplate = UriPathPattern(path: path, pathMatch: pathMatch);

  @override
  int get hashCode => hash4(
        path.hashCode,
        pathMatch.hashCode,
        builder.hashCode,
        pathTemplate.hashCode,
      );

  @override
  bool operator ==(Object other) {
    return other is SimplePageRoute &&
        builder == other.builder &&
        path == other.path &&
        pathMatch == other.pathMatch &&
        pathTemplate == other.pathTemplate;
  }
}

// TODO: equality
class Redirect implements RouteDef {
  final String path;
  final RoutePathMatch pathMatch;
  final UriPathPattern pathTemplate;
  final String redirectTo;

  Redirect({
    @required this.path,
    @required this.pathMatch,
    @required this.redirectTo,
  })  : assert(path != null),
        assert(pathMatch != null),
        assert(redirectTo != null),
        pathTemplate = UriPathPattern(path: path, pathMatch: pathMatch);

  @override
  int get hashCode => hash4(
        path.hashCode,
        pathMatch.hashCode,
        pathTemplate.hashCode,
        redirectTo.hashCode,
      );

  @override
  bool operator ==(Object other) {
    return other is Redirect &&
        path == other.path &&
        pathMatch == other.pathMatch &&
        pathTemplate == other.pathTemplate &&
        redirectTo == other.redirectTo;
  }
}
