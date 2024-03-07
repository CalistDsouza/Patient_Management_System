import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PatientProfileScreen extends StatefulWidget {
 final String? patientId; // Make patientId optional

 PatientProfileScreen({Key? key, this.patientId}) : super(key: key);

 @override
 _PatientProfileScreenState createState() => _PatientProfileScreenState();
}

class _PatientProfileScreenState extends State<PatientProfileScreen> {
 late Future<PatientInfo?> futurePatient;

 @override
 void initState() {
    super.initState();
    futurePatient = widget.patientId != null ? fetchPatientDetails() : Future.value(null);
 }

 Future<PatientInfo?> fetchPatientDetails() async {
    if (widget.patientId == null) return null;
    final response = await http.get(Uri.parse('http://127.0.0.1:5000/Patients/${widget.patientId}'));

    if (response.statusCode == 200) {
      return PatientInfo.fromJson(jsonDecode(response.body));
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
        child: FutureBuilder<PatientInfo?>(
          future: futurePatient,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else if (snapshot.data == null) {
              return Text('No patient selected.');
            } else {
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
                 Text(
                    'Blood Pressure: ${snapshot.data!.bloodPressure}',
                    style: TextStyle(fontSize: 16),
                 ),
                 Text(
                    'Respiratory Rate: ${snapshot.data!.respiratoryRate}',
                    style: TextStyle(fontSize: 16),
                 ),
                 Text(
                    'Blood Oxygen Level: ${snapshot.data!.bloodOxygenLevel}',
                    style: TextStyle(fontSize: 16),
                 ),
                 Text(
                    'Heartbeat Rate: ${snapshot.data!.heartbeatRate}',
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

class PatientInfo {
 final String name;
 final String age;
 final String gender;
 final String bloodPressure;
 final String respiratoryRate;
 final String bloodOxygenLevel;
 final String heartbeatRate;

 PatientInfo({
    required this.name,
    required this.age,
    required this.gender,
    required this.bloodPressure,
    required this.respiratoryRate,
    required this.bloodOxygenLevel,
    required this.heartbeatRate,
 });

 factory PatientInfo.fromJson(Map<String, dynamic> json) {
    return PatientInfo(
      name: json['name'],
      age: json['age'],
      gender: json['gender'],
      bloodPressure: json['bloodPressure'],
      respiratoryRate: json['respiratoryRate'],
      bloodOxygenLevel: json['bloodOxygenLevel'],
      heartbeatRate: json['heartbeatRate'],
    );
 }
}
