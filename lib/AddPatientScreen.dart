// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously, file_names

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Test.dart';
import 'patient.dart';
import 'patients.dart';

class AddPatientScreen extends StatefulWidget {
  const AddPatientScreen({super.key});

  @override
  _AddPatientScreenState createState() => _AddPatientScreenState();
}

class _AddPatientScreenState extends State<AddPatientScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController phnoController = TextEditingController();
  final TextEditingController bpController = TextEditingController();
  final TextEditingController rrController = TextEditingController();
  final TextEditingController o2Controller = TextEditingController();
  final TextEditingController hrController = TextEditingController();
  final TextEditingController bolController = TextEditingController();

  // Define _formKey at the top of your class
  final _formKey = GlobalKey<FormState>();

  // Variable to hold the selected gender
  String? selectedGender;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Patient Data'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Name'),
                TextFormField(
                  controller: nameController,
                  decoration:
                      const InputDecoration(hintText: 'Enter patient name'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a name';
                    }
                    if (value.contains(RegExp(r'\d'))) {
                      return 'Name should not contain numbers';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                const Text('Age'),
                TextFormField(
                  controller: ageController,
                  decoration: const InputDecoration(hintText: 'Enter age'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter an age';
                    }
                    int? age = int.tryParse(value);
                    if (age == null || age < 0 || age > 130) {
                      return 'Please enter a valid age between 0 and 130';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                const Text('Address'),
                TextFormField(
                  controller: addressController,
                  decoration: const InputDecoration(hintText: 'Enter address'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter an address';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                const Text('Phone Number'),
                TextFormField(
                  controller: phnoController,
                  decoration:
                      const InputDecoration(hintText: 'Enter phone number'),
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a phone number';
                    }
                    if (!RegExp(r'^\d+$').hasMatch(value)) {
                      return 'Phone number should only contain numbers';
                    }
                    if (value.length > 10) {
                      return 'Phone number should not\nbe more than 10 digits';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 24),
                const Text('Clinical Data'),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: bpController,
                        decoration:
                            const InputDecoration(hintText: 'Blood Pressure (mmHg)'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter blood pressure';
                          }
                          double? bp = double.tryParse(value);
                          if (bp == null || bp < 60 || bp > 200) {
                            return 'Please enter a valid\nblood pressure between\n60 and 200 mmHg';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: TextFormField(
                        controller: rrController,
                        decoration:
                            const InputDecoration(hintText: 'Respiratory Rate (breaths/minute)'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter respiratory rate';
                          }
                          int? rr = int.tryParse(value);
                          if (rr == null || rr < 10 || rr > 25) {
                            return 'Please enter a valid\nrespiratory rate between \n10 and 25 breaths per minute';
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: o2Controller,
                        decoration: const InputDecoration(
                            hintText: 'Oxygen Saturation (%)'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter oxygen saturation';
                          }
                          int? o2 = int.tryParse(value);
                          if (o2 == null || o2 < 90 || o2 > 100) {
                            return 'Please enter a valid\n oxygen saturation between\n90% and 100%';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: TextFormField(
                        controller: hrController,
                        decoration:
                            const InputDecoration(hintText: 'Heart Rate (bpm)'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter heart rate';
                          }
                          int? hr = int.tryParse(value);
                          if (hr == null || hr < 30 || hr > 200) {
                            return 'Please enter a valid\nheart rate between 30 and 200\nbeats per minute';
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: bolController,
                        decoration:
                            const InputDecoration(hintText: 'Body Temperature (°F)'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter body temperature';
                          }
                          // Additional validation for body temperature can be added here
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 32),
                const Text('Gender'),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: RadioListTile<String>(
                        title: const Text('Male'),
                        value: 'Male',
                        groupValue: selectedGender,
                        onChanged: (String? value) {
                          setState(() {
                            selectedGender = value;
                          });
                        },
                      ),
                    ),
                    Expanded(
                      child: RadioListTile<String>(
                        title: const Text('Female'),
                        value: 'Female',
                        groupValue: selectedGender,
                        onChanged: (String? value) {
                          setState(() {
                            selectedGender = value;
                          });
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 32),
                Center(
                  child: ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        // Collect data from the controllers
                        String name = nameController.text;
                        int age =
                            int.parse(ageController.text); // Convert age to int
                        String address = addressController.text;
                        String phno = phnoController.text;
                        String bloodPressure = bpController.text;
                        String respiratoryRate = rrController.text;
                        String oxygenSaturation = o2Controller.text;
                        String heartRate = hrController.text;
                        String bodyTemperature = bolController.text;

                        // Create a Test object with the collected data and the current date
                        Test newTest = Test(
                          date: DateTime.now(), // Include the current date
                          bloodPressure: bloodPressure,
                          heartRate: heartRate,
                          respiratoryRate: respiratoryRate,
                          oxygenSaturation: oxygenSaturation,
                          bodyTemperature: bodyTemperature,
                        );

                        // Create a Patient object with the collected data and the new Test object
                        Patient newPatient = Patient(
                          name: name,
                          age: age
                              .toString(), // Convert age back to String if needed
                          address: address,
                          gender: selectedGender!,
                          phno: phno,
                          tests: [
                            newTest
                          ], // Add the new Test object to the tests list
                        );
                        // Use the Patients model to add the new patient
                        bool success =
                            await Provider.of<Patients>(context, listen: false)
                                .addPatient(newPatient);

                        if (success) {
                          // Show a success message
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Patient added successfully')),
                          );

                          // Navigate back to the previous screen
                          Navigator.pop(context);
                        } else {
                          // Show an error message if the patient was not added successfully
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Failed to add patient')),
                          );
                        }
                      }
                    },
                    child: const Text('Save'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    ageController.dispose();
    addressController.dispose();
    phnoController.dispose();
    bpController.dispose();
    rrController.dispose();
    o2Controller.dispose();
    hrController.dispose();
    bolController.dispose();
    super.dispose();
  }
}
