import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

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
                            final file = await pickImage(ImageSource.gallery);
                            if (file != null) {
                              value.setImage(file);
                              value.changeIsImageLoading();
                            } else {
                              value.changeIsImageLoading();
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
                            final file = await pickImage(ImageSource.gallery);
                            if (file != null) {
                              value.setImage(file);
                              value.changeIsImageLoading();
                            } else {
                              value.changeIsImageLoading();
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
