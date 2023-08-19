import 'package:bottom_sheet_helper/services/conformationSheet.helper.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:unicons/unicons.dart';

class ImagePermissionsHelper {
  static Future<PermissionStatus?> checkPhotoPermission() async {
    // storage permission ask
    PermissionStatus status = await Permission.photos.status;
    print(status);
    // if permission denied
    if (!status.isGranted) {
      final bool? confirm = await ConformationSheetHelper.show(
        title: 'Permission'.tr,
        subTitle:
            "App need the permission to use your device's photos gallery.".tr,
        yesTitle: 'Allow'.tr,
        noTitle: "Don't allow".tr,
        icon: UniconsLine.image,
      );

      if (confirm == null || !confirm) return null;
      print(confirm);
      // if user reach here I assign status again to use it in next lines
      status = await Permission.photos.request();
      print('[[[$status]]]');
    }

    return status;
  }

  static Future<PermissionStatus?> checkCameraPermission() async {
    // storage permission ask
    PermissionStatus status = await Permission.camera.status;

    // permission ask
    if (!status.isGranted) {
      // internal ask
      final bool? confirm = await ConformationSheetHelper.show(
        title: 'Permission'.tr,
        subTitle: "App need the permission to use your device's camera.".tr,
        yesTitle: 'Allow'.tr,
        noTitle: "Don't allow".tr,
        icon: UniconsLine.camera,
      );

      // not allowed
      if (confirm == null || !confirm) return null;

      // if user reach here I assign status again to use it in next lines
      status = await Permission.camera.request();
    }

    return status;
  }
}
