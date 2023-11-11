import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

pickImage(ImageSource source, BuildContext context) async {
  // final ImagePicker imagePicker = ImagePicker();

  // XFile? file = await imagePicker.pickImage(source: source);
  // if (file != null) {
  //   return await file.readAsBytes();
  // }

  return _getStoragePermission(source, context);
}

Future _getStoragePermission(ImageSource source, BuildContext context) async {
  if (await Permission.storage.request().isGranted) {
    final ImagePicker imagePicker = ImagePicker();

    XFile? file = await imagePicker.pickImage(source: source);
    if (file != null) {
      return await file.readAsBytes();
    }
  } else if (await Permission.storage.request().isPermanentlyDenied) {
    return "no_permission";

    // await Utils().showSnackBarMessage(
    //     context: context, content: "grant storage permission to continue");

    // await openAppSettings();
  } else if (await Permission.storage.request().isDenied) {
    return "no_permission";

    // Utils().showSnackBarMessage(
    //     context: context,
    //     content: "storage permission is denied, please grant the permission");
  }
}
