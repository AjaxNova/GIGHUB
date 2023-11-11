import 'dart:developer';

import 'package:blurry_modal_progress_hud/blurry_modal_progress_hud.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lite_jobs/models/user_model.dart';
import 'package:lite_jobs/provider/edit_your_profile_provider.dart';
import 'package:provider/provider.dart';

import '../../common/widgets/special_appbar_widget.dart';
import '../../utils/colors/colors.dart';
import '../../utils/utils.dart';
import '../auth/functions/pick_image.dart';
import '../auth/widget/custom_textfield.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key, required this.userModel});

  final UserModel userModel;

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final TextEditingController _skillContoller = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();

  final TextEditingController _highestQualification = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _setValues();
    _nameController.text = widget.userModel.username;
    _bioController.text = widget.userModel.bio;
    _ageController.text = widget.userModel.age;
    _highestQualification.text = widget.userModel.highestQual;
  }

  @override
  void dispose() {
    super.dispose();
    _skillContoller.dispose();
    _nameController.dispose();
    _highestQualification.dispose();
    _bioController.dispose();
  }

  _setValues() {
    final prov = Provider.of<EditProfilePageProvider>(context, listen: false);
    prov.setVals(gend: widget.userModel.gender, skill: widget.userModel.skills);

    log("current status : ${prov.file}");
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Consumer<EditProfilePageProvider>(
      builder: (context, valueProfile, child) {
        return BlurryModalProgressHUD(
            inAsyncCall: valueProfile.isLoading,
            blurEffectIntensity: 4,
            progressIndicator: const SpinKitWave(
              color: singInButtonColor,
              size: 90.0,
            ),
            dismissible: false,
            opacity: 0.4,
            color: Colors.black,
            child: SafeArea(
              child: Scaffold(
                bottomNavigationBar: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () async {
                      if (valueProfile.skills.isEmpty) {
                        Utils().showSnackBarMessage(
                            context: context, content: "fill all the fields");
                      } else {
                        if (_formKey.currentState!.validate()) {
                          valueProfile.changeIsLoading();
                          final String res = await valueProfile.onEditButton(
                              currentPhotoUrl: widget.userModel.photoUrl,
                              name: _nameController.text,
                              highestQual: _highestQualification.text,
                              bio: _bioController.text,
                              age: _ageController.text,
                              uid: widget.userModel.uid);
                          if (res == "success") {
                            valueProfile.resetVal();

                            _ageController.clear();
                            _skillContoller.clear();
                            _highestQualification.clear();
                            _bioController.clear();
                            _nameController.clear();
                          }
                          valueProfile.changeIsLoading();
                          Utils().showSnackBarMessage(
                              context: context, content: "user updated");
                          Navigator.of(context).pop();
                        } else {
                          Utils().showSnackBarMessage(
                              context: context,
                              content: "fill the remaingn fields");
                        }
                      }
                    },
                    child: Container(
                      width: double.infinity,
                      height: 50,
                      decoration: BoxDecoration(
                          color: test1,
                          borderRadius: BorderRadius.circular(10)),
                      child: Center(
                          child: Wrap(
                        children: [
                          Text(
                            "Edit",
                            style: GoogleFonts.inter(
                                fontSize: 27, fontWeight: FontWeight.bold),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(top: 6.0, left: 6),
                            child: FaIcon(
                              FontAwesomeIcons.edit,
                              size: 20,
                            ),
                          )
                        ],
                      )),
                    ),
                  ),
                ),
                appBar: SpecialAppbar(
                    isProfile: false,
                    context: context,
                    onTap: () {
                      valueProfile.resetVal();
                      Navigator.of(context).pop();
                    },
                    appBarTitle: "edit"),
                body: SingleChildScrollView(
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 18.0, right: 18, top: 18),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            imagePart(widget.userModel.photoUrl),
                            const SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              controller: _nameController,
                              decoration: const InputDecoration(
                                labelText: 'Name',
                                hintStyle: TextStyle(color: Colors.black),
                                labelStyle: TextStyle(color: Colors.black),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.red),
                                ),
                              ),
                              style: const TextStyle(color: Colors.black),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please fill the field';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                              controller: _bioController,
                              decoration: const InputDecoration(
                                labelText: 'bio',
                                hintStyle: TextStyle(color: Colors.black),
                                labelStyle: TextStyle(color: Colors.black),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.red),
                                ),
                              ),
                              style: const TextStyle(color: Colors.black),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please fill the field';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            DropdownButtonFormField(
                              value: valueProfile.gender,
                              onChanged: (value) {
                                valueProfile.setGender(value!);
                              },
                              items: ["Male", "Female"]
                                  .map<DropdownMenuItem<String>>(
                                (String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                },
                              ).toList(),
                              decoration: const InputDecoration(
                                labelText: 'Gender',
                                hintStyle: TextStyle(color: Colors.black),
                                labelStyle: TextStyle(color: Colors.black),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(2)
                              ],
                              keyboardType: TextInputType.number,
                              controller: _ageController,
                              decoration: const InputDecoration(
                                labelText: 'Age',
                                hintStyle: TextStyle(color: Colors.black),
                                labelStyle: TextStyle(color: Colors.black),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.red),
                                ),
                              ),
                              style: const TextStyle(color: Colors.black),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please fill the field';
                                } else if (int.parse(value) < 18) {
                                  return 'age should be above 18';
                                }

                                return null;
                              },
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                              controller: _highestQualification,
                              decoration: const InputDecoration(
                                labelText: 'Highest Qualification',
                                hintStyle: TextStyle(color: Colors.black),
                                labelStyle: TextStyle(color: Colors.black),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.red),
                                ),
                              ),
                              style: const TextStyle(color: Colors.black),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please fill the field';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Card(
                              color: Colors.white,
                              elevation: 4,
                              shadowColor: Colors.black,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Skills:',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 15),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 8.0, right: 8, bottom: 15),
                                      child: Column(
                                        children: valueProfile.skills
                                            .asMap()
                                            .entries
                                            .map(
                                              (entry) => Padding(
                                                padding: const EdgeInsets.only(
                                                    bottom: 1),
                                                child: ListTile(
                                                  leading: SizedBox(
                                                    width: size.width * 0.6,
                                                    child: Text(
                                                      ". ${entry.value}",
                                                      style: GoogleFonts.inter(
                                                          fontSize: 16),
                                                    ),
                                                  ),
                                                  trailing: IconButton(
                                                    onPressed: () {
                                                      valueProfile
                                                          .removeFromSkills(
                                                              entry.key);
                                                    },
                                                    icon: const FaIcon(
                                                      FontAwesomeIcons
                                                          .circleXmark,
                                                      size: 21,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            )
                                            .toList(),
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                          flex: 4,
                                          child: TextFormField(
                                            maxLines: 3,
                                            controller: _skillContoller,
                                            decoration: const InputDecoration(
                                              labelText: 'skills',
                                              hintStyle: TextStyle(
                                                  color: Colors.black),
                                              labelStyle: TextStyle(
                                                  color: Colors.black),
                                              errorBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.red),
                                              ),
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.black),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.black),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: IconButton(
                                            onPressed: () {
                                              valueProfile.addToListSkill(
                                                  _skillContoller.text);
                                              _skillContoller.clear();
                                            },
                                            icon: const Icon(Icons.add_box,
                                                size: 52),
                                            style: ElevatedButton.styleFrom(
                                              foregroundColor: Colors.black,
                                              backgroundColor: test1,
                                              elevation: 4,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(15.0),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ));
      },
    );
  }
}

Column imagePart(String photoUrl) {
  return Column(
    children: [
      Consumer<EditProfilePageProvider>(
        builder: (context, value, child) {
          return Stack(
            children: [
              value.file != null
                  ? CircleAvatar(
                      backgroundColor: singUPButtonColor,
                      radius: 77,
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 72,
                        backgroundImage: MemoryImage(value.file!),
                      ),
                    )
                  : CircleAvatar(
                      backgroundColor: singUPButtonColor,
                      radius: 77,
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 72,
                        backgroundImage: NetworkImage(photoUrl),
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
                        Icons.mode_edit_outlined,
                        color: Colors.black,
                        size: 26,
                      ),
                    ),
                  ),
                ),
              )
            ],
          );
        },
      )
    ],
  );
}

Column fieldPart(
    {required bool isGoogle,
    required Size size,
    required TextEditingController nameController,
    passwordController,
    addressController,
    mobileController,
    emailController}) {
  return Column(
    children: [
      CustomTextfieldWidget(
        hintText: "name",
        size: size,
        controller: nameController,
      ),
    ],
  );
}
