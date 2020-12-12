import 'dart:html' as html; // ignore: avoid_web_libraries_in_flutter

import 'shared.dart';

class WebPermissionManager implements PermissionManager {
  @override
  Future<bool> get isClipboardGranted async {
    final perm = await html.window.navigator.permissions.query(
      {'name': 'clipboard'},
    );
    return perm.state == 'granted';
  }
}

PermissionManager get permissionManager => WebPermissionManager();
