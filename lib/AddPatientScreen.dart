import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'PatientStateManager.dart';
import 'Test.dart';
import 'patient_service.dart';
import 'patient.dart';
import 'patients.dart';

class AddPatientScreen extends StatefulWidget {
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
        title: Text('Patient Data'),
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
                Text('Name'),
                TextFormField(
                  controller: nameController,
                  decoration: InputDecoration(hintText: 'Enter patient name'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a name';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                Text('Age'),
                TextFormField(
                  controller: ageController,
                  decoration: InputDecoration(hintText: 'Enter age'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter an age';
                    }
                    if (int.tryParse(value!) == null) {
                      return 'Please enter a valid number';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                Text('Address'),
                TextFormField(
                  controller: addressController,
                  decoration: InputDecoration(hintText: 'Enter address'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter an address';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                Text('Phone Number'),
                TextFormField(
                  controller: phnoController,
                  decoration: InputDecoration(hintText: 'Enter phone number'),
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a phone number';
                    }
                    // Additional validation for phone number format can be added here
                    return null;
                  },
                ),
                SizedBox(height: 24),
                Text('Clinical Data'),
                SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: bpController,
                        decoration: InputDecoration(hintText: 'Blood Pressure'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter blood pressure';
                          }
                          // Additional validation for blood pressure can be added here
                          return null;
                        },
                      ),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: TextFormField(
                        controller: rrController,
                        decoration:
                            InputDecoration(hintText: 'Respiratory Rate'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter respiratory rate';
                          }
                          // Additional validation for respiratory rate can be added here
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: o2Controller,
                        decoration:
                            InputDecoration(hintText: 'Oxygen Saturation'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter oxygen saturation';
                          }
                          // Additional validation for oxygen saturation can be added here
                          return null;
                        },
                      ),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: TextFormField(
                        controller: hrController,
                        decoration: InputDecoration(hintText: 'Heart Rate'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter heart rate';
                          }
                          // Additional validation for heart rate can be added here
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: bolController,
                        decoration:
                            InputDecoration(hintText: 'Body Temperature'),
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
                SizedBox(height: 32),
                Text('Gender'),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: RadioListTile<String>(
                        title: Text('Male'),
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
                        title: Text('Female'),
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
                SizedBox(height: 32),
                Center(
                  child: ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        // Collect data from the controllers
                        String name = nameController.text;
                        String age = ageController.text;
                        String address = addressController.text;
                        String phno = phnoController.text;
                        String bloodPressure = bpController.text;
                        String respiratoryRate = rrController.text;
                        String oxygenSaturation = o2Controller.text;
                        String heartRate = hrController.text;
                        String bodyTemperature = bolController.text;

                        // Create a Patient object with the collected data
                        Patient newPatient = Patient(
                          name: name,
                          age: age,
                          address: address,
                          gender: selectedGender!,
                          phno: phno,
                          tests: [
                            Test(
                              bloodPressure: bloodPressure,
                              heartRate: heartRate,
                              respiratoryRate: respiratoryRate,
                              oxygenSaturation: oxygenSaturation,
                              bodyTemperature: bodyTemperature,
                            ),
                          ],
                        );

                        // Use the Patients model to add the new patient
                        bool success =
                            await Provider.of<Patients>(context, listen: false)
                                .addPatient(newPatient);

                        if (success) {
                          // Show a success message
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                content: Text('Patient added successfully')),
                          );

                          // Navigate back to the previous screen
                          Navigator.pop(context);
                        } else {
                          // Show an error message if the patient was not added successfully
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Failed to add patient')),
                          );
                        }
                      }
                    },
                    child: Text('Save'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
