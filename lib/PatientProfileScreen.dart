import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'EditPatientProfileScreen.dart';
import 'patient.dart';
import 'Test.dart';

class PatientProfileScreen extends StatefulWidget {
 final String? patientId;

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

 Future<void> deletePatient() async {
    if (widget.patientId == null) return;
    final response = await http.delete(
        Uri.parse('http://127.0.0.1:5000/Patients/${widget.patientId}'));

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Patient deleted successfully')),
      );
      // Optionally, navigate back to the previous screen or refresh the current screen
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to delete patient')),
      );
    }
 }

 Future<void> editPatient() async {
    if (widget.patientId == null) return;
    // Navigate to the edit screen, passing the patient's details
    // Ensure you have an EditPatientProfileScreen ready for this navigation
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditPatientProfileScreen(patientId: widget.patientId!),
      ),
    );
 }

 @override
 Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Patient Profile'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: editPatient,
          ),
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: deletePatient,
          ),
        ],
      ),
      body: FutureBuilder<Patient?>(
        future: futurePatient,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.data == null) {
            return Center(child: Text('No patient selected.'));
          } else {
            Patient patient = snapshot.data!;
            bool isCritical = patient.isCritical(); // Use the isCritical method from the Patient class
            return SingleChildScrollView(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                 Center(
                    child: CircleAvatar(
                      radius: 60.0,
                      backgroundImage: AssetImage('assets/place_holder.png'),
                    ),
                 ),
                 SizedBox(height: 20),
                 Text(
                    '${patient.name}',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                 ),
                 Text(
                    'Age: ${patient.age}, Gender: ${patient.gender}',
                    style: TextStyle(fontSize: 18),
                 ),
                 SizedBox(height: 20),
                 Text(
                    'Medical History:',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                 ),
                 for (var test in patient.tests)
                    Card(
                      margin: EdgeInsets.symmetric(vertical: 10),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Blood Pressure: ${test.bloodPressure}',
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 8), // Add space between text elements
                            Text(
                              'Heart Rate: ${test.heartRate}',
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 8), // Add space between text elements
                            Text(
                              'Respiratory Rate: ${test.respiratoryRate}',
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 8), // Add space between text elements
                            Text(
                              'Oxygen Saturation: ${test.oxygenSaturation}',
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 8), // Add space between text elements
                            Text(
                              'Body Temperature: ${test.bodyTemperature}',
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                 if (isCritical)
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Patient is in critical condition.',
                        style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                      ),
                    ),
                ],
              ),
            );
          }
        },
      ),
    );
 }
}
