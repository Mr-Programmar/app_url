import 'package:permission_handler/permission_handler.dart';

void storagePermission() async {
  await Permission.storage.request();
  PermissionStatus status = await Permission.storage.status;
  while (!status.isGranted) {
    await Permission.storage.request();

    return;
  }
}

void notificationPermisssion() async {
  PermissionStatus status = await Permission.notification.status;
  if (status.isDenied) {
    await Permission.notification.request();
  }
  if (status.isPermanentlyDenied) {
    await Permission.notification.request();
  }
  if (status.isRestricted) {
    await Permission.notification.request();
  }
}
