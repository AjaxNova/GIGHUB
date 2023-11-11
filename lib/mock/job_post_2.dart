import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lite_jobs/common/widgets/special_appbar_widget.dart';
import 'package:lite_jobs/utils/colors/colors.dart';

class JobPostForm2 extends StatefulWidget {
  const JobPostForm2({super.key});

  @override
  _JobPostForm2State createState() => _JobPostForm2State();
}

class _JobPostForm2State extends State<JobPostForm2> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // Text editing controllers
  final TextEditingController _jobTitleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _placeController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _requirementsController = TextEditingController();

  String _amountType = 'Per Hour';
  final List<String> _addedRequirements = [];

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // Implement your logic here (e.g., saving data to a database).
      // You can access the form fields' values using controllers.
      // Add a comment here indicating where to implement specific functions.
    }
  }

  @override
  void dispose() {
    // Dispose of the controllers when the widget is disposed.
    _jobTitleController.dispose();
    _descriptionController.dispose();
    _amountController.dispose();
    _placeController.dispose();
    _timeController.dispose();
    _dateController.dispose();
    _requirementsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: singInButtonColor,
        body: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Padding(
                    padding:
                        const EdgeInsets.only(right: 8.0, top: 1, bottom: 14),
                    child: SpecialAppbar(
                        context: context,
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        appBarTitle: "Post Job"),
                  ),
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          controller: _jobTitleController,
                          decoration: InputDecoration(
                            labelText: 'Job Title',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: const BorderSide(color: Colors.grey),
                            ),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter a job title';
                            }
                            return null;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          controller: _descriptionController,
                          decoration: InputDecoration(
                            labelText: 'Description',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: const BorderSide(color: Colors.grey),
                            ),
                          ),
                          maxLines: 3,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter a job description';
                            }
                            return null;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              flex: 3,
                              child: TextFormField(
                                controller: _amountController,
                                decoration: InputDecoration(
                                  labelText: 'Amount',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide:
                                        const BorderSide(color: Colors.grey),
                                  ),
                                ),
                                keyboardType: TextInputType.number,
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
                              flex: 2,
                              child: DropdownButtonFormField<String>(
                                value: _amountType,
                                items: [
                                  'Per Hour',
                                  'Per Day',
                                  'Per Month',
                                  'Per Year',
                                  'Total'
                                ].map((type) {
                                  return DropdownMenuItem<String>(
                                    value: type,
                                    child: Text(type),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  setState(() {
                                    _amountType = value!;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: _placeController,
                      decoration: InputDecoration(
                        labelText: 'Place',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(color: Colors.grey),
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter a place';
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          flex: 3,
                          child: TextFormField(
                            controller: _timeController,
                            decoration: InputDecoration(
                              labelText: 'Time',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide:
                                    const BorderSide(color: Colors.grey),
                              ),
                            ),
                            keyboardType: TextInputType.text,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter a time';
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(width: 16.0),
                        IconButton(
                          icon: const Icon(Icons.access_time),
                          onPressed: () {
                            // Add code to pick time here.
                          },
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          flex: 3,
                          child: TextFormField(
                            controller: _dateController,
                            decoration: InputDecoration(
                              labelText: 'Date',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide:
                                    const BorderSide(color: Colors.grey),
                              ),
                            ),
                            keyboardType: TextInputType.text,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter a date';
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(width: 16.0),
                        IconButton(
                          icon: const Icon(Icons.calendar_today),
                          onPressed: () {
                            // Add code to pick date here.
                          },
                        ),
                      ],
                    ),
                  ),
                  _addedRequirements.isNotEmpty
                      ? Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            elevation: 2,
                            margin: const EdgeInsets.only(top: 16.0),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: _addedRequirements.map((requirement) {
                                  return ListTile(
                                    leading: const FaIcon(
                                        FontAwesomeIcons.circleDot),
                                    title: Text(requirement),
                                  );
                                }).toList(),
                              ),
                            ),
                          ),
                        )
                      : const SizedBox(),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          flex: 3,
                          child: TextFormField(
                            controller: _requirementsController,
                            decoration: InputDecoration(
                              labelText: 'Requirements',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide:
                                    const BorderSide(color: Colors.grey),
                              ),
                            ),
                            maxLines:
                                null, // Allow multiple lines for requirements
                          ),
                        ),
                        const SizedBox(width: 16.0),
                        IconButton(
                          icon: const Icon(Icons.add),
                          onPressed: () {
                            if (_requirementsController.text != "") {
                              setState(() {
                                _addedRequirements
                                    .add(_requirementsController.text);
                                _requirementsController.clear();
                              });
                            }
                          },
                          iconSize: 32.0, // Increase icon size
                        ),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    onPressed: _submitForm,
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.black,
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      side: const BorderSide(
                        color: Colors.grey,
                      ),
                    ),
                    child: const Text('Post Job'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
