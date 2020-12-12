import 'permission_stub.dart'
    if (dart.library.io) 'mobile.dart'
    if (dart.library.html) 'web.dart';

abstract class PermissionManager {
  Future<bool> get isClipboardGranted;
 
  factory PermissionManager() => permissionManager;
}
