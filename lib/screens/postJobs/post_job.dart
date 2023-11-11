import 'package:blurry_modal_progress_hud/blurry_modal_progress_hud.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:lite_jobs/common/widgets/special_appbar_widget.dart';
import 'package:lite_jobs/provider/post_job_provider.dart';
import 'package:lite_jobs/screens/mainJobScreen/main_screen.dart';
import 'package:lite_jobs/screens/postJobs/widgets/image_card.dart';
import 'package:lite_jobs/utils/utils.dart';
import 'package:provider/provider.dart';

import '../../utils/colors/colors.dart';

class PostJobPage extends StatefulWidget {
  const PostJobPage({super.key});

  @override
  State<PostJobPage> createState() => _PostJobPageState();
}

class _PostJobPageState extends State<PostJobPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _requirementsController = TextEditingController();

  @override
  void dispose() {
    super.dispose();

    _titleController.dispose();
    _descriptionController.dispose();
    _amountController.dispose();
    _locationController.dispose();
    _requirementsController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Consumer<PostJobScreenProvider>(
      builder: (context, postJobval, child) {
        return BlurryModalProgressHUD(
            inAsyncCall: postJobval.postJObIsLoading,
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
                appBar: PreferredSize(
                  preferredSize: size / 7,
                  child: SpecialAppbar(
                      appBarTitle: "post Jobs",
                      context: context,
                      onTap: () {
                        final provi = Provider.of<PostJobScreenProvider>(
                            context,
                            listen: false);
                        provi.resetValues();
                        Navigator.of(context).pop();
                      }),
                ),
                body: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16.0, right: 16),
                    child: Form(
                        key: _formKey,
                        child: Consumer<PostJobScreenProvider>(
                          builder: (context, values, child) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  height: 10,
                                ),
                                titleToTimeFields(values, context),
                                const SizedBox(height: 16.0),
                                requirementsCard(values, size),
                                const AddImageCard(),
                                postJobButton(size, values, context),
                              ],
                            );
                          },
                        )),
                  ),
                ),
              ),
            ));
      },
    );
  }

  Padding postJobButton(
      Size size, PostJobScreenProvider values, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, bottom: 8),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: 2,
          backgroundColor: Colors.black,
          minimumSize: Size(size.width, 50),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6),
          ),
        ),
        onPressed: () async {
          if (values.requirements.isEmpty) {
            Utils().showSnackBarMessage(
                context: context, content: "add requirements");
          } else if (values.file == null) {
            Utils().showSnackBarMessage(
                context: context, content: "add a picture");
          } else {
            if (_formKey.currentState!.validate()) {
              values.changeLoading();
              final String res = await values.onPOstJobButton(
                context: context,
                amount: _amountController.text,
                description: _descriptionController.text,
                place: _locationController.text,
                title: _titleController.text,
              );
              if (res == "success") {
                values.resetValues();
                _amountController.clear();
                _locationController.clear();
                _descriptionController.clear();
                _titleController.clear();
              }
              values.changeLoading();
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => const HomeScreen()),
                (route) => false,
              );
            } else {
              Utils().showSnackBarMessage(
                  context: context, content: "fill the remaingn fields");
            }
          }
        },
        child: Wrap(
          children: [
            Text(
              "Post ",
              style: GoogleFonts.inter(
                  fontSize: 19,
                  fontWeight: FontWeight.w500,
                  color: Colors.white),
            ),
            const SizedBox(
              width: 5,
            ),
          ],
        ),
      ),
    );
  }

  Card requirementsCard(PostJobScreenProvider values, Size size) {
    return Card(
      color: Colors.white,
      elevation: 4,
      shadowColor: Colors.black,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Requirements:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.only(top: 8.0, right: 8, bottom: 15),
              child: Column(
                children: values.requirements
                    .asMap()
                    .entries
                    .map(
                      (entry) => Padding(
                        padding: const EdgeInsets.only(bottom: 1),
                        child: ListTile(
                          leading: SizedBox(
                            width: size.width * 0.6,
                            child: Text(
                              ". ${entry.value}",
                              style: GoogleFonts.inter(fontSize: 16),
                            ),
                          ),
                          trailing: IconButton(
                            onPressed: () {
                              values.removeFromRequireMents(entry.key);
                            },
                            icon: const FaIcon(
                              FontAwesomeIcons.circleXmark,
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
                    controller: _requirementsController,
                    decoration: const InputDecoration(
                      labelText: 'requirements',
                      hintStyle: TextStyle(color: Colors.black),
                      labelStyle: TextStyle(color: Colors.black),
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: IconButton(
                    onPressed: () {
                      values.addRequirement(_requirementsController);
                    },
                    icon: const Icon(Icons.add_box, size: 52),
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.black,
                      backgroundColor: test1,
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Card titleToTimeFields(PostJobScreenProvider values, BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 14,
      shadowColor: Colors.black,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 15),
              child: TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: 'Title',
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
                    return 'Please enter a title';
                  }
                  return null;
                },
              ),
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              maxLines: 4,
              controller: _descriptionController,
              decoration: const InputDecoration(
                errorBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red),
                ),
                labelText: 'description',
                hintStyle: TextStyle(color: Colors.black),
                labelStyle: TextStyle(color: Colors.black),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                ),
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter a descrption';
                }
                return null;
              },
            ),
            const SizedBox(height: 16.0),
            Row(
              children: [
                Expanded(
                  flex: 3,
                  child: TextFormField(
                    inputFormatters: [LengthLimitingTextInputFormatter(6)],
                    controller: _amountController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Amount',
                      hintStyle: TextStyle(color: Colors.black),
                      labelStyle: TextStyle(color: Colors.black),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter an amount';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(width: 16.0),
                Expanded(
                  flex: 3,
                  child: DropdownButtonFormField(
                    value: values.amountType,
                    onChanged: (value) {
                      values.setAmountType(value!);
                    },
                    items: ['Hour', 'day', "month", "year", "total"]
                        .map<DropdownMenuItem<String>>(
                      (String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      },
                    ).toList(),
                    decoration: const InputDecoration(
                      labelText: 'Payment Type',
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
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              controller: _locationController,
              decoration: const InputDecoration(
                labelText: 'place',
                hintStyle: TextStyle(color: Colors.black),
                labelStyle: TextStyle(color: Colors.black),
                errorBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                ),
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter a location';
                }
                return null;
              },
            ),
            const SizedBox(height: 16.0),
            Row(
              children: [
                const Text(
                  'DATE:',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 8.0),
                Text(
                  DateFormat('dd/MM/yyyy').format(values.selectedDate),
                  style: const TextStyle(color: Colors.black),
                ),
                IconButton(
                  onPressed: () => values.selectDate(context),
                  icon: const Icon(
                    Icons.calendar_today,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                const Text(
                  'TIME:',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 8.0),
                Text(
                  values.selectedTime.format(context),
                  style: const TextStyle(color: Colors.black),
                ),
                IconButton(
                  onPressed: () => values.selectTime(context),
                  icon: const Icon(
                    Icons.access_time,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
