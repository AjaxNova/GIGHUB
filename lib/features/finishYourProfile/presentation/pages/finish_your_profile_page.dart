import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lite_jobs/common/widgets/special_appbar_widget.dart';
import 'package:lite_jobs/controller/provider/finish_your_profile_provider.dart';
import 'package:lite_jobs/core/res/user_model.dart';
import 'package:lite_jobs/core/utils/snack_bar.dart';
import 'package:lite_jobs/features/finishYourProfile/presentation/bloc/finish_profile_bloc.dart';
import 'package:lite_jobs/features/home/presentation/pages/home_screen.dart';
import 'package:lite_jobs/utils/colors/colors.dart';
import 'package:lite_jobs/utils/utils.dart';
import 'package:lite_jobs/view/screens/auth/widget/custom_textfield.dart';
import 'package:provider/provider.dart';

class FinishYourProfilePage extends StatefulWidget {
  const FinishYourProfilePage({super.key, required this.userModel});

  final UserModelGlobal userModel;

  @override
  State<FinishYourProfilePage> createState() => _FinishYourProfilePageState();
}

class _FinishYourProfilePageState extends State<FinishYourProfilePage> {
  final TextEditingController _skillContoller = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();

  final TextEditingController _highestQualification = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  String _currentGender = 'Male';

  List<String> skillsMap = [];

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.userModel.username;
  }

  @override
  void dispose() {
    super.dispose();
    _skillContoller.dispose();
    _nameController.dispose();
    _highestQualification.dispose();
    _bioController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    ScaffoldMessengerState scaffoldMessenger = ScaffoldMessenger.of(context);

    return BlocConsumer<FinishProfileBloc, FinishProfileState>(
      listener: (context, state) {
        if (state is FinishProfileSuccess) {
          customSnackBar(
              scaffoldMessenger,
              'profile updated successfully',
              Colors.green.shade800,
              Colors.white,
              const TextStyle(color: Colors.black));
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (context) => HomeScreen(
                userModelGlobal: state.userModel,
              ),
            ),
            (route) => false,
          );
        }
        if (state is FinishProfileError) {
          customSnackBar(scaffoldMessenger, state.msg, Colors.red.shade800,
              Colors.white, const TextStyle(color: Colors.black));
        }
      },
      builder: (context, state) {
        return SafeArea(
          child: Scaffold(
            bottomNavigationBar: Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () async {
                  if (_formKey.currentState!.validate()) {
                    context.read<FinishProfileBloc>().add(UpdateUserDataEvent(
                          uid: widget.userModel.uid,
                          age: _ageController.text,
                          gender: _currentGender,
                          qualification: _highestQualification.text,
                          skill: skillsMap,
                          bio: _bioController.text,
                        ));
                  }
                  // if (valueProfile.skill.isEmpty) {
                  //   Utils().showSnackBarMessage(
                  //       context: context, content: "fill all the fields");
                  // } else {
                  //   if (_formKey.currentState!.validate()) {
                  //     valueProfile.changeIsLoading();
                  //     final String res = await valueProfile.onFinishButton(
                  //         bio: _bioController.text,
                  //         age: _ageController.text,
                  //         qualification: _highestQualification.text,
                  //         uid: widget.userModel.uid);
                  //     if (res == "success") {
                  //       valueProfile.resetValues();
                  //       _ageController.clear();
                  //       _skillContoller.clear();
                  //       _highestQualification.clear();
                  //       _bioController.clear();
                  //     }
                  //     valueProfile.changeIsLoading();
                  //     Navigator.of(context).pushAndRemoveUntil(
                  //       MaterialPageRoute(
                  //           builder: (context) => const HomeScreen()),
                  //       (route) => false,
                  //     );
                  //   } else {
                  //     Utils().showSnackBarMessage(
                  //         context: context,
                  //         content: "fill the remaingn fields");
                  //   }
                  // }
                },
                child: Container(
                  width: double.infinity,
                  height: 50,
                  decoration: BoxDecoration(
                      color: test1, borderRadius: BorderRadius.circular(10)),
                  child: Center(
                      child: Text(
                    "Finish",
                    style: GoogleFonts.inter(
                        fontSize: 27, fontWeight: FontWeight.bold),
                  )),
                ),
              ),
            ),
            appBar: SpecialAppbar(
                isProfile: true,
                context: context,
                onTap: () {},
                appBarTitle: "Finish Your Profile"),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(left: 18.0, right: 18, top: 18),
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
                          readOnly: true,
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
                          ),
                          style: const TextStyle(color: Colors.black),
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
                          value: _currentGender,
                          onChanged: (value) {
                            //
                            setState(() {
                              _currentGender = value!;
                            });
                          },
                          items:
                              ["Male", "Female"].map<DropdownMenuItem<String>>(
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
                                    children: skillsMap.indexed
                                        .map(
                                          (entry) => Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 1),
                                            child: SizedBox(
                                              child: ListTile(
                                                leading: SizedBox(
                                                  width: size.width * 0.3,
                                                  child: Text(
                                                    ". $entry",
                                                    style: GoogleFonts.inter(
                                                        fontSize: 16),
                                                  ),
                                                ),
                                                trailing: IconButton(
                                                  onPressed: () {
                                                    setState(() {
                                                      skillsMap.remove(entry);
                                                    });
                                                  },
                                                  icon: const FaIcon(
                                                    FontAwesomeIcons
                                                        .circleXmark,
                                                    size: 21,
                                                  ),
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
                                          hintStyle:
                                              TextStyle(color: Colors.black),
                                          labelStyle:
                                              TextStyle(color: Colors.black),
                                          errorBorder: OutlineInputBorder(
                                            borderSide:
                                                BorderSide(color: Colors.red),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide:
                                                BorderSide(color: Colors.black),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide:
                                                BorderSide(color: Colors.black),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: IconButton(
                                        onPressed: () {
                                          setState(() {
                                            if (skillsMap.contains(
                                                _skillContoller.text)) {
                                              Utils().showSnackBarMessage(
                                                  context: context,
                                                  content:
                                                      'skill already exist');
                                            } else {
                                              skillsMap
                                                  .add(_skillContoller.text);
                                            }
                                          });

                                          _skillContoller.clear();
                                        },
                                        icon:
                                            const Icon(Icons.add_box, size: 42),
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
        );
      },
    );
  }
}

Column imagePart(String photoUrl) {
  return Column(
    children: [
      Consumer<FinishYourProfileProvider>(
        builder: (context, value, child) {
          return CircleAvatar(
            backgroundColor: singUPButtonColor,
            radius: 77,
            child: CircleAvatar(
              backgroundColor: Colors.white,
              radius: 72,
              backgroundImage: NetworkImage(photoUrl),
            ),
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
