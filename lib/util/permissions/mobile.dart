import 'shared.dart';

class MobilePermissionManager implements PermissionManager {
  @override
  Future<bool> get isClipboardGranted async => true;
}

PermissionManager get permissionManager => MobilePermissionManager();
