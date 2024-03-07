import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'Test.dart';
import 'patient.dart';

class PatientProfileScreen extends StatefulWidget {
 final String? patientId; // Make patientId optional

 PatientProfileScreen({Key? key, this.patientId}) : super(key: key);

 @override
 _PatientProfileScreenState createState() => _PatientProfileScreenState();
}

class _PatientProfileScreenState extends State<PatientProfileScreen> {
 late Future<Patient?> futurePatient;

 @override
 void initState() {
    super.initState();
    futurePatient = widget.patientId != null ? fetchPatientDetails() : Future.value(null);
 }

 Future<Patient?> fetchPatientDetails() async {
    if (widget.patientId == null) return null;
    final response = await http.get(Uri.parse('http://127.0.0.1:5000/Patients/${widget.patientId}'));

    if (response.statusCode == 200) {
      return Patient.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load patient details');
    }
 }

 @override
 Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Patient Profile'),
      ),
      body: Center(
        child: FutureBuilder<Patient?>(
          future: futurePatient,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else if (snapshot.data == null) {
              return Text('No patient selected.');
            } else {
              // Assuming you want to display the first test's results
              Test? firstTest = snapshot.data!.tests.isNotEmpty ? snapshot.data!.tests.first : null;

              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                 Text(
                    'Name: ${snapshot.data!.name}',
                    style: TextStyle(fontSize: 24),
                 ),
                 Text(
                    'Age: ${snapshot.data!.age}, Gender: ${snapshot.data!.gender}',
                    style: TextStyle(fontSize: 18),
                 ),
                 SizedBox(height: 20),
                 Text(
                    'Medical History:',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                 ),
                 if (firstTest != null)
                    Text(
                      'Blood Pressure: ${firstTest.bloodPressure}',
                      style: TextStyle(fontSize: 16),
                    ),
                 if (firstTest != null)
                    Text(
                      'Respiratory Rate: ${firstTest.respiratoryRate}',
                      style: TextStyle(fontSize: 16),
                    ),
                 if (firstTest != null)
                    Text(
                      'Oxygen Saturation: ${firstTest.oxygenSaturation}',
                      style: TextStyle(fontSize: 16),
                    ),
                 if (firstTest != null)
                    Text(
                      'Heartbeat Rate: ${firstTest.heartRate}',
                      style: TextStyle(fontSize: 16),
                    ),
                ],
              );
            }
          },
        ),
      ),
    );
 }
}
