import 'package:bottom_sheet_helper/models/actionSheetOption.model.dart';
import 'package:bottom_sheet_helper/services/actionSheet.helper.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ImageSelectHelper {
  static Future<XFile?> sourceAsk({
    int imageQuality = 80,
    double maxHeight = 250,
    double? maxWidth,
  }) async {
    dynamic source = await ActionSheetHelper.show(
      title: 'Choose a File'.tr,
      subTitle: 'Choose a Source Body'.tr,
      options: [
        ActionSheetOption(
          title: 'Camera'.tr,
          value: 'camera',
          leading: const Icon(Icons.camera_alt_rounded),
        ),
        ActionSheetOption(
          title: 'Gallery'.tr,
          value: 'gallery',
          leading: const Icon(Icons.image),
        ),
      ],
    );

    //skip
    if (source == null) return null;

    // then trigger a function
    return await selectImage(
      imageQuality: imageQuality,
      maxHeight: maxHeight,
      maxWidth: maxWidth,
      imageSource:
          source == 'camera' ? ImageSource.camera : ImageSource.gallery,
    );
  }

  static Future<XFile?> selectImage({
    required ImageSource imageSource,
    int imageQuality = 80,
    double maxHeight = 200,
    double? maxWidth,
  }) async {
    // // check permission
    // PermissionStatus? status = imageSource == ImageSource.gallery
    //     ? await ImagePermissionsHelper.checkPhotoPermission()
    //     : await ImagePermissionsHelper.checkCameraPermission();

    // // if status is not Granted
    // if (status == null || !status.isGranted) return null;

    return await ImagePicker().pickImage(
      source: imageSource,
      imageQuality: imageQuality,
      maxHeight: maxHeight,
      maxWidth: maxWidth,
    );
  }
}
