import 'package:flutter/material.dart';
import 'package:lite_jobs/common/widgets/special_appbar_widget.dart';

class JobPostForm extends StatefulWidget {
  const JobPostForm({super.key});

  @override
  _JobPostFormState createState() => _JobPostFormState();
}

class _JobPostFormState extends State<JobPostForm> {
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
        backgroundColor: Colors.white,
        body: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                // crossAxisAlignment: CrossAxisAlignment.stretch,
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
                      maxLines: 3, // Allow multiple lines for description
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
                        ElevatedButton(
                          onPressed: () {
                            // Add code to pick time here.
                          },
                          child: const Text('Pick Time'),
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
                        ElevatedButton(
                          onPressed: () {
                            // Add code to pick date here.
                          },
                          child: const Text('Pick Date'),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      elevation: 2, // Add elevation for the card
                      margin: const EdgeInsets.only(top: 16.0),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: _addedRequirements.map((requirement) {
                            return ListTile(
                              leading: const Icon(Icons
                                  .check), // Add an icon (you can change it)
                              title: Text(requirement),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  ),

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
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              _addedRequirements
                                  .add(_requirementsController.text);
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            elevation: 4, // Add elevation
                            shadowColor: Colors.grey, // Add shadow color
                          ),
                          child: const Text('Add Requirement'),
                        ),
                      ],
                    ),
                  ),

// Display added requirements with icons in a card

                  // Display added requirements

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


// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:line_icons/line_icon.dart';

// import '../../common/widgets/special_appbar_widget.dart';

// class PostJobPage extends StatefulWidget {
//   const PostJobPage({super.key});

//   @override
//   State<PostJobPage> createState() => _PostJobPageState();
// }

// class _PostJobPageState extends State<PostJobPage> {
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//   final TextEditingController _titleController = TextEditingController();
//   final TextEditingController _descriptionController = TextEditingController();
//   final TextEditingController _amountController = TextEditingController();
//   final TextEditingController _locationController = TextEditingController();
//   final List<String> _requirements = [];
//   DateTime _selectedDate = DateTime.now();
//   TimeOfDay _selectedTime = TimeOfDay.now();
//   void _addRequirement() {
//     if (_descriptionController.text.isNotEmpty) {
//       setState(() {
//         _requirements.add(". ${_descriptionController.text}");
//         _descriptionController.clear();
//       });
//     }
//   }

//   Future<void> _selectDate(BuildContext context) async {
//     final DateTime? pickedDate = await showDatePicker(
//       context: context,
//       initialDate: _selectedDate,
//       firstDate: DateTime.now(),
//       lastDate: DateTime(2101),
//     );
//     if (pickedDate != null && pickedDate != _selectedDate) {
//       setState(() {
//         _selectedDate = pickedDate;
//       });
//     }
//   }

//   Future<void> _selectTime(BuildContext context) async {
//     final TimeOfDay? pickedTime = await showTimePicker(
//       context: context,
//       initialTime: _selectedTime,
//     );
//     if (pickedTime != null && pickedTime != _selectedTime) {
//       setState(() {
//         _selectedTime = pickedTime;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         body: SingleChildScrollView(
//           child: Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Form(
//               key: _formKey,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: <Widget>[
//                   SpecialAppbar(
//                       appBarTitle: "post Jobs",
//                       context: context,
//                       onTap: () {
//                         Navigator.of(context).pop();
//                       }),
//                   Card(
//                     elevation: 4,
//                     shadowColor: Colors.black,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(15.0),
//                     ),
//                     child: Padding(
//                       padding: const EdgeInsets.all(16.0),
//                       child: Column(
//                         children: [
//                           TextFormField(
//                             controller: _titleController,
//                             decoration: const InputDecoration(
//                               labelText: 'Title',
//                               border: OutlineInputBorder(),
//                             ),
//                             validator: (value) {
//                               if (value!.isEmpty) {
//                                 return 'Please enter a title';
//                               }
//                               return null;
//                             },
//                           ),
//                           const SizedBox(height: 16.0),
//                           TextFormField(
//                             maxLines: 4,
//                             controller: _descriptionController,
//                             decoration: const InputDecoration(
//                               labelText: 'description',
//                               border: OutlineInputBorder(),
//                             ),
//                             validator: (value) {
//                               if (value!.isEmpty) {
//                                 return 'Please enter a descrption';
//                               }
//                               return null;
//                             },
//                           ),
//                           const SizedBox(height: 16.0),
//                           Row(
//                             children: <Widget>[
//                               Expanded(
//                                 flex: 3,
//                                 child: TextFormField(
//                                   controller: _amountController,
//                                   decoration: const InputDecoration(
//                                     labelText: 'Amount',
//                                     border: OutlineInputBorder(),
//                                   ),
//                                   validator: (value) {
//                                     if (value!.isEmpty) {
//                                       return 'Please enter an amount';
//                                     }
//                                     return null;
//                                   },
//                                 ),
//                               ),
//                               const SizedBox(width: 16.0),
//                               Expanded(
//                                 flex: 3,
//                                 child: DropdownButtonFormField<String>(
//                                   value: 'Per Hour',
//                                   onChanged: (value) {},
//                                   items: <String>['Per Hour', 'Whole Gig']
//                                       .map<DropdownMenuItem<String>>(
//                                     (String value) {
//                                       return DropdownMenuItem<String>(
//                                         value: value,
//                                         child: Text(value),
//                                       );
//                                     },
//                                   ).toList(),
//                                   decoration: const InputDecoration(
//                                     labelText: 'Payment Type',
//                                     border: OutlineInputBorder(),
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                           const SizedBox(height: 16.0),
//                           Row(
//                             children: <Widget>[
//                               Expanded(
//                                 child: TextFormField(
//                                   controller: _locationController,
//                                   decoration: const InputDecoration(
//                                     labelText: 'Location',
//                                     border: OutlineInputBorder(),
//                                   ),
//                                   validator: (value) {
//                                     if (value!.isEmpty) {
//                                       return 'Please enter a location';
//                                     }
//                                     return null;
//                                   },
//                                 ),
//                               ),
//                               IconButton(
//                                   onPressed: () {},
//                                   icon: const LineIcon.mapMarker())
//                               // ElevatedButton.icon(
//                               //   onPressed: () {}, // Implement geolocation
//                               //   icon: const Icon(Icons.place),
//                               //   label: const Text('Get Location'),
//                               //   style: ElevatedButton.styleFrom(
//                               //     foregroundColor: Colors.black,
//                               //     backgroundColor: Colors.white,
//                               //     elevation: 4,
//                               //     shape: RoundedRectangleBorder(
//                               //       borderRadius: BorderRadius.circular(15.0),
//                               //     ),
//                               //   ),
//                               // ),
//                             ],
//                           ),
//                           const SizedBox(height: 16.0),
//                           Row(
//                             children: <Widget>[
//                               const Text(
//                                 'DATE:',
//                                 style: TextStyle(
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                               const SizedBox(width: 8.0),
//                               Text(
//                                 DateFormat('dd/MM/yyyy').format(_selectedDate),
//                               ),
//                               IconButton(
//                                 onPressed: () => _selectDate(context),
//                                 icon: const Icon(Icons.calendar_today),
//                               ),
//                             ],
//                           ),
//                           Row(
//                             children: <Widget>[
//                               const Text(
//                                 'TIME:',
//                                 style: TextStyle(
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                               const SizedBox(width: 8.0),
//                               Text(
//                                 _selectedTime.format(context),
//                               ),
//                               IconButton(
//                                 onPressed: () => _selectTime(context),
//                                 icon: const Icon(Icons.access_time),
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 16.0),
//                   Card(
//                     elevation: 4,
//                     shadowColor: Colors.black,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(15.0),
//                     ),
//                     child: Padding(
//                       padding: const EdgeInsets.all(16.0),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: <Widget>[
//                           const Text(
//                             'Requirements:',
//                             style: TextStyle(
//                               fontSize: 16,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                           const SizedBox(height: 16.0),
//                           Column(
//                             children: _requirements
//                                 .map(
//                                   (requirement) => ListTile(
//                                     title: Text(requirement),
//                                   ),
//                                 )
//                                 .toList(),
//                           ),
//                           Row(
//                             children: <Widget>[
//                               Expanded(
//                                 flex: 4,
//                                 child: TextFormField(
//                                   maxLines: 3,
//                                   controller: _descriptionController,
//                                   decoration: const InputDecoration(
//                                     labelText: 'Add Requirement',
//                                     border: OutlineInputBorder(),
//                                   ),
//                                 ),
//                               ),
//                               Expanded(
//                                 flex: 1,
//                                 child: ElevatedButton.icon(
//                                   onPressed: _addRequirement,
//                                   icon: const Icon(Icons.add),
//                                   label: const Text('Add'),
//                                   style: ElevatedButton.styleFrom(
//                                     foregroundColor: Colors.black,
//                                     backgroundColor: Colors.white,
//                                     elevation: 4,
//                                     shape: RoundedRectangleBorder(
//                                       borderRadius: BorderRadius.circular(15.0),
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 16.0),
//                   // Add multiple images section here
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
