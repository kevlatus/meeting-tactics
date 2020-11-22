import 'package:meta/meta.dart';

import '../models.dart';

const String _routeParamPattern = ':[a-zA-Z]+';

class UriPathPattern {
  final RegExp _regExp;
  final Map<int, String> _paramPositions;

  final String path;
  final RoutePathMatch pathMatch;

  static RegExp _buildRegex(String path, RoutePathMatch pathMatch) {
    String pattern = '';
    if (!path.contains(':')) {
      pattern = path;
    } else {
      pattern = path.replaceAll(
        _routeParamPattern,
        '[a-zA-Z0-9]+',
      );
    }

    if (pathMatch == RoutePathMatch.Exact) {
      pattern += r'$';
    }

    return RegExp(pattern);
  }

  static Map<int, String> _extractParamPositions(String path) {
    final segments = path.split('/');
    return segments.asMap().entries.fold<Map<int, String>>(<int, String>{},
        (acc, entry) {
      if (entry.value.contains(':')) {
        acc[entry.key] = entry.value.replaceFirst(':', '');
      }
      return acc;
    });
  }

  // TODO: validate pattern
  UriPathPattern({
    @required this.path,
    this.pathMatch = RoutePathMatch.Prefix,
  })  : _regExp = _buildRegex(path, pathMatch),
        _paramPositions = _extractParamPositions(path);

  bool matches(String path) {
    return _regExp.hasMatch(path);
  }

  Map<String, String> getRouteParams(String path) {
    final segments = path.split('/');
    return _paramPositions.entries.fold<Map<String, String>>(
      <String, String>{},
      (acc, entry) {
        acc[entry.value] = segments[entry.key];
        return acc;
      },
    );
  }

  String buildPath([Map<String, String> params]) {
    params = const <String, String>{};
    String ret = path;
    for (var entry in params.entries) {
      ret = ret.replaceFirst(':' + entry.key, entry.value);
    }
    return ret;
  }
}

bool _validatePathTemplate(String pathTemplate) {
  final segments = pathTemplate.split('/');

  final areSegmentsValid = segments.map((it) {
    if (it.contains(":")) {
      return RegExp(_routeParamPattern).hasMatch(it);
    }
    return true;
  }).every((it) => it);

  final isWildcardValid =
      segments.sublist(0, segments.length - 1).every((it) => !it.contains('*'));

  return areSegmentsValid && isWildcardValid;
}
