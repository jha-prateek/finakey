import 'package:permission_handler/permission_handler.dart';

Future<bool> checkSmsPermission() async {
  PermissionStatus permissionStatus = await Permission.sms.request();
  switch(permissionStatus) {
    case PermissionStatus.denied:
      return false;
    case PermissionStatus.granted:
      return true;
    case PermissionStatus.restricted:
      return false;
    case PermissionStatus.limited:
      return true;
    case PermissionStatus.permanentlyDenied:
      return false;
  }
}