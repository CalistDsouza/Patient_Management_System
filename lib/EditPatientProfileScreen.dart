import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'PatientStateManager.dart';
import 'Test.dart';
import 'patient.dart';

class EditPatientProfileScreen extends StatefulWidget {
  final String patientId;

  EditPatientProfileScreen({Key? key, required this.patientId})
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
  late Patient
      _fetchedPatient; // State variable to store the fetched Patient object

  Future<Patient> fetchPatientDetails() async {
    
    final response = await http
        .get(Uri.parse('http://127.0.0.1:5000/Patients/${widget.patientId}'));

    if (response.statusCode == 200) {
      // Assuming the response body is a JSON string that can be parsed into a Patient object
      _fetchedPatient = Patient.fromJson(jsonDecode(response.body));
      return _fetchedPatient;
    } else {
      // Handle the error
      throw Exception('Failed to load patient details');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Patient Profile'),
      ),
      body: FutureBuilder<Patient>(
        future: fetchPatientDetails(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
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

            return Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      initialValue: _name,
                      decoration: InputDecoration(labelText: 'Name'),
                      onSaved: (value) {
                        _name = value!;
                      },
                    ),
                    TextFormField(
                      initialValue: _age,
                      decoration: InputDecoration(labelText: 'Age'),
                      onSaved: (value) {
                        _age = value!;
                      },
                    ),
                    TextFormField(
                      initialValue: _address,
                      decoration: InputDecoration(labelText: 'Address'),
                      onSaved: (value) {
                        _address = value!;
                      },
                    ),
                    TextFormField(
                      initialValue: _gender,
                      decoration: InputDecoration(labelText: 'Gender'),
                      onSaved: (value) {
                        _gender = value!;
                      },
                    ),
                    TextFormField(
                      initialValue: _phno,
                      decoration: InputDecoration(labelText: 'Phone Number'),
                      onSaved: (value) {
                        _phno = value!;
                      },
                    ),
                    TextFormField(
                      initialValue: _bloodPressure,
                      decoration: InputDecoration(
                          labelText: 'Blood Pressure (X/Y mmHg)'),
                      onSaved: (value) {
                        _bloodPressure = value!;
                      },
                    ),
                    TextFormField(
                      initialValue: _heartRate,
                      decoration:
                          InputDecoration(labelText: 'Heart Rate (X/min)'),
                      onSaved: (value) {
                        _heartRate = value!;
                      },
                    ),
                    TextFormField(
                      initialValue: _respiratoryRate,
                      decoration: InputDecoration(
                          labelText: 'Respiratory Rate (X/min)'),
                      onSaved: (value) {
                        _respiratoryRate = value!;
                      },
                    ),
                    TextFormField(
                      initialValue: _oxygenSaturation,
                      decoration:
                          InputDecoration(labelText: 'Oxygen Saturation (X%)'),
                      onSaved: (value) {
                        _oxygenSaturation = value!;
                      },
                    ),
                    TextFormField(
                      initialValue: _bodyTemperature,
                      decoration:
                          InputDecoration(labelText: 'Body Temperature (X°C)'),
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
                      child: Text('Save'),
                    ),
                  ],
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
        tests: [
          _fetchedPatient.tests.isNotEmpty
              ? _fetchedPatient.tests[0]
              : updatedTest
        ], // Include the updated test in the tests list
      );

      // Send the updated Patient object to the server
      await updatePatientOnServer(updatedPatient);
    }
  }

  Future<void> updatePatientOnServer(Patient updatedPatient) async {
 try {
    // Replace 'http://127.0.0.1:5000/Patients/${updatedPatient.id}' with your actual server URL
    final response = await http.put(
      Uri.parse('http://127.0.0.1:5000/Patients/${updatedPatient.id}'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(updatedPatient.toJson()),
    );

    if (response.statusCode == 200) {
      // If the server returns a 200 OK response, then the patient was updated successfully.
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Patient updated successfully')),
      );

      // Update the patientListNotifier with the updated patient
      List<Patient> updatedList = List.from(PatientStateManager.patientListNotifier.value);
      int index = updatedList.indexWhere((patient) => patient.id == updatedPatient.id);
      if (index != -1) {
        updatedList[index] = updatedPatient; // Replace the old patient with the updated patient
        PatientStateManager.patientListNotifier.value = updatedList;
      }

      // Optionally, navigate back to the previous screen or refresh the current screen
    } else {
      // If the server returns an error response, then something went wrong.
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(
                'Failed to update patient. Server responded with status code: ${response.statusCode}')),
      );
    }
 } catch (e) {
    // Catch any exceptions and display an error message
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Failed to update patient. Error: $e')),
    );
 }
}

}
