import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lite_jobs/common/widgets/alert_dialogue.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../../../../provider/sign_up_screen_provider.dart';
import '../../../../utils/colors/colors.dart';
import '../../functions/pick_image.dart';

Column imageSelectionSection() {
  return Column(
    children: [
      Consumer<SignUpScreenProvider>(
        builder: (context, value, child) {
          return value.fetchImage != null
              ? CircleAvatar(
                  backgroundColor: singUPButtonColor,
                  radius: 77,
                  child: Stack(
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 72,
                        backgroundImage: MemoryImage(value.fetchImage!),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: GestureDetector(
                          onTap: () async {
                            value.changeIsImageLoading();
                            final file =
                                await pickImage(ImageSource.gallery, context);
                            if (file == "no_permission") {
                              log(file);
                              if (context.mounted) {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return const StoragePermissionDeniedDialog();
                                  },
                                );
                              }
                            } else {
                              if (file != null) {
                                value.setImage(file);
                                value.changeIsImageLoading();
                              } else {
                                value.changeIsImageLoading();
                              }
                            }
                          },
                          child: const CircleAvatar(
                            radius: 21,
                            backgroundColor: Colors.grey,
                            child: CircleAvatar(
                              backgroundColor: singUPButtonColor,
                              child: Icon(
                                Icons.mode_edit_outlined,
                                color: Colors.black,
                                size: 26,
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                )
              : CircleAvatar(
                  backgroundColor: singUPButtonColor,
                  radius: 77,
                  child: Stack(
                    children: [
                      const CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 72,
                        backgroundImage: AssetImage(
                          "assets/images/default_person_3.png",
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: GestureDetector(
                          onTap: () async {
                            value.changeIsImageLoading();
                            final file =
                                await pickImage(ImageSource.gallery, context);
                            if (file == "no_permission") {
                              log(file);
                              await _onAlertButtonPressed(context);
                            } else {
                              if (file != null) {
                                value.setImage(file);
                                value.changeIsImageLoading();
                              } else {
                                value.changeIsImageLoading();
                              }
                            }
                          },
                          child: const CircleAvatar(
                            radius: 21,
                            backgroundColor: Colors.grey,
                            child: CircleAvatar(
                              backgroundColor: singUPButtonColor,
                              child: Icon(
                                Icons.add,
                                color: Colors.black,
                                size: 26,
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                );
        },
      )
    ],
  );
}

_onAlertButtonPressed(context) async {
  Alert(
    context: context,
    type: AlertType.warning,
    title: "Storage Permission Denied",
    desc:
        "Storage permission is required to access and save files.\nPlease go to settings and grant storage permission.",
    style: const AlertStyle(
      isCloseButton: false,
      animationType: AnimationType.fromTop,
      titleStyle: TextStyle(
        color: Colors.red,
        fontSize: 18.0,
        fontWeight: FontWeight.bold,
      ),
      descStyle: TextStyle(
        color: Colors.black,
        fontSize: 14.0,
      ),
    ),
    buttons: [
      DialogButton(
        color: Colors.blue,
        onPressed: () {
          Navigator.of(context).pop();
        },
        width: 80,
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FaIcon(FontAwesomeIcons.check, color: Colors.white, size: 14),
            SizedBox(width: 8),
            Text(
              "OK",
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ],
        ),
      ),
      DialogButton(
        color: Colors.red,
        onPressed: () async {
          await openAppSettings();
          Navigator.pop(context);

          // TODO: Implement code to open app settings
          // For Android, you can use AppSettings.openAppSettings();
          // For iOS, you can use AppSettings.openAppSettings();
        },
        width: 80,
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.settings, color: Colors.white, size: 14),
            SizedBox(width: 8),
            Text(
              "Settings",
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ],
        ),
      )
    ],
  ).show();
}
