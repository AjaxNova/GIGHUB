import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lite_jobs/controller/provider/post_job_provider.dart';
import 'package:lite_jobs/screens/auth/functions/pick_image.dart';
import 'package:provider/provider.dart';

import '../../../utils/colors/colors.dart';

class AddImageCard extends StatelessWidget {
  const AddImageCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<PostJobScreenProvider>(
      builder: (context, value, child) {
        return Card(
          color: Colors.white,
          elevation: 5.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SizedBox(
              width: double.infinity,
              height: 180,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  value.file == null
                      ? GestureDetector(
                          onTap: () async {
                            final image =
                                await pickImage(ImageSource.gallery, context);
                            value.setImage(image);
                          },
                          child: const Column(
                            children: [
                              Icon(
                                Icons.add_a_photo,
                                size: 50.0,
                                color: Colors.black,
                              ),
                              SizedBox(height: 10.0),
                              Text(
                                'Add Image',
                                style: TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        )
                      : Stack(
                          children: [
                            Container(
                              height: 170,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: MemoryImage(value.file!))),
                            ),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: GestureDetector(
                                onTap: () async {
                                  final file = await pickImage(
                                      ImageSource.gallery, context);
                                  if (file != null) {
                                    value.setImage(file);
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
                        )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
