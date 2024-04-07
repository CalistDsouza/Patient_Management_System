// ignore_for_file: use_build_context_synchronously, library_private_types_in_public_api, file_names

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:provider/provider.dart'; // Ensure Provider is imported
import 'Test.dart';
import 'patient.dart';
import 'patients.dart'; // Ensure this import is correct

class EditPatientProfileScreen extends StatefulWidget {
  final String patientId;

  const EditPatientProfileScreen({Key? key, required this.patientId})
      : super(key: key);

  @override
  _EditPatientProfileScreenState createState() =>
      _EditPatientProfileScreenState();
}

class _EditPatientProfileScreenState extends State<EditPatientProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  late String _name;
  late String _age;
  late String _address;
  late String _gender;
  late String _phno;
  late String _bloodPressure;
  late String _heartRate;
  late String _respiratoryRate;
  late String _oxygenSaturation;
  late String _bodyTemperature;
  late Patient _fetchedPatient;
  
  late DateTime _selectedDate;

  Future<Patient> fetchPatientDetails() async {
    final response = await http
        .get(Uri.parse('http://127.0.0.1:5000/Patients/${widget.patientId}'));

    if (response.statusCode == 200) {
      _fetchedPatient = Patient.fromJson(jsonDecode(response.body));
      return _fetchedPatient;
    } else {
      throw Exception('Failed to load patient details');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Patient Profile'),
      ),
      body: FutureBuilder<Patient>(
        future: fetchPatientDetails(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            _fetchedPatient = snapshot.data!;
            _name = _fetchedPatient.name;
            _age = _fetchedPatient.age;
            _address = _fetchedPatient.address;
            _gender = _fetchedPatient.gender;
            _phno = _fetchedPatient.phno;
            _bloodPressure = _fetchedPatient.tests.isNotEmpty
                ? _fetchedPatient.tests[0].bloodPressure
                : '';
            _heartRate = _fetchedPatient.tests.isNotEmpty
                ? _fetchedPatient.tests[0].heartRate
                : '';
            _respiratoryRate = _fetchedPatient.tests.isNotEmpty
                ? _fetchedPatient.tests[0].respiratoryRate
                : '';
            _oxygenSaturation = _fetchedPatient.tests.isNotEmpty
                ? _fetchedPatient.tests[0].oxygenSaturation
                : '';
            _bodyTemperature = _fetchedPatient.tests.isNotEmpty
                ? _fetchedPatient.tests[0].bodyTemperature
                : '';

            return SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        initialValue: _name,
                        decoration: const InputDecoration(labelText: 'Name'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a name';
                          }
                          if (value.contains(RegExp(r'\d'))) {
                            return 'Name should not contain numbers';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _name = value!;
                        },
                      ),
                      TextFormField(
                        initialValue: _age,
                        decoration: const InputDecoration(labelText: 'Age'),
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
                        onSaved: (value) {
                          _age = value!;
                        },
                      ),
                      TextFormField(
                        initialValue: _address,
                        decoration: const InputDecoration(labelText: 'Address'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter an address';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _address = value!;
                        },
                      ),
                      TextFormField(
                        initialValue: _gender,
                        decoration: const InputDecoration(labelText: 'Gender'),
                        validator: (value) {
                          if (value == null ||
                              (value != "Male" && value != "Female")) {
                            return 'Gender should be either Male or Female';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _gender = value!;
                        },
                      ),
                      TextFormField(
                        initialValue: _phno,
                        decoration:
                            const InputDecoration(labelText: 'Phone Number'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a phone number';
                          }
                          if (!RegExp(r'^\d+$').hasMatch(value)) {
                            return 'Phone number should only contain numbers';
                          }
                          if (value.length > 10) {
                            return 'Phone number should not be more than 10 digits';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _phno = value!;
                        },
                      ),
                      TextFormField(
                        initialValue: _bloodPressure,
                        decoration:
                            const InputDecoration(labelText: 'Blood Pressure'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter blood pressure';
                          }
                          double? bp = double.tryParse(value);
                          if (bp == null || bp < 60 || bp > 200) {
                            return 'Please enter a valid blood pressure between 60 and 200 mmHg';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _bloodPressure = value!;
                        },
                      ),
                      TextFormField(
                        initialValue: _heartRate,
                        decoration:
                            const InputDecoration(labelText: 'Heart Rate'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter heart rate';
                          }
                          int? hr = int.tryParse(value);
                          if (hr == null || hr < 30 || hr > 200) {
                            return 'Please enter a valid heart rate between 30 and 200 beats per minute';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _heartRate = value!;
                        },
                      ),
                      TextFormField(
                        initialValue: _respiratoryRate,
                        decoration: const InputDecoration(
                            labelText: 'Respiratory Rate'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter respiratory rate';
                          }
                          int? rr = int.tryParse(value);
                          if (rr == null || rr < 10 || rr > 25) {
                            return 'Please enter a valid respiratory rate between 10 and 25 breaths per minute';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _respiratoryRate = value!;
                        },
                      ),
                      TextFormField(
                        initialValue: _oxygenSaturation,
                        decoration: const InputDecoration(
                            labelText: 'Oxygen Saturation'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter oxygen saturation';
                          }
                          int? o2 = int.tryParse(value);
                          if (o2 == null || o2 < 90 || o2 > 100) {
                            return 'Please enter a valid oxygen saturation between 90% and 100%';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _oxygenSaturation = value!;
                        },
                      ),
                      TextFormField(
                        initialValue: _bodyTemperature,
                        decoration: const InputDecoration(
                            labelText: 'Body Temperature'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter body temperature';
                          }
                          // Additional validation for body temperature can be added here
                          return null;
                        },
                        onSaved: (value) {
                          _bodyTemperature = value!;
                        },
                      ),
                      ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();
                            savePatientDetails();
                          }
                        },
                        child: const Text('Save'),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
        },
      ),
    );
  }

  Future<void> savePatientDetails() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      // Create a new Test object with the updated values
      Test updatedTest = Test(
       // date: DateTime.now().toString(),
        bloodPressure: _bloodPressure,
        heartRate: _heartRate,
        respiratoryRate: _respiratoryRate,
        oxygenSaturation: _oxygenSaturation,
        bodyTemperature: _bodyTemperature,
      );

      // Update the Patient object with the new values and the updated test
      Patient updatedPatient = Patient(
        id: _fetchedPatient.id, // Use the id from the fetched Patient object
        name: _name,
        age: _age,
        address: _address,
        gender: _gender,
        phno: _phno,
        tests: [updatedTest], // Use the updated test
        
      );

      // Send the updated Patient object to the server
      await updatePatientOnServer(updatedPatient);
    }
  }

  Future<void> updatePatientOnServer(Patient updatedPatient) async {
    try {
      final response = await http.put(
        Uri.parse('http://127.0.0.1:5000/Patients/${updatedPatient.id}'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(updatedPatient.toJson()),
      );

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Patient updated successfully')),
        );

        // Update the local list of patients with the updated patient details
        Provider.of<Patients>(context, listen: false)
            .updatePatient(updatedPatient);

        // Optionally, navigate back to the previous screen or refresh the current screen
        Navigator.pop(
            context); // This will navigate back to the previous screen
        Navigator.pop(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text(
                  'Failed to update patient. Server responded with status code: ${response.statusCode}')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to update patient. Error: $e')),
      );
    }
  }
}
