import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
import 'patient_service.dart';
import 'patient.dart';

class AddPatientScreen extends StatefulWidget {
 @override
 _AddPatientScreenState createState() => _AddPatientScreenState();
}

class _AddPatientScreenState extends State<AddPatientScreen> {
 final TextEditingController nameController = TextEditingController();
 final TextEditingController dobController = TextEditingController();
 final TextEditingController timeController = TextEditingController();
 final TextEditingController bpController = TextEditingController();
 final TextEditingController rrController = TextEditingController();
 final TextEditingController o2Controller = TextEditingController();
 final TextEditingController hrController = TextEditingController();
 final TextEditingController hbrController = TextEditingController(); // New controller for heartbeat rate
 final TextEditingController bolController = TextEditingController(); // New controller for blood oxygen level

 @override
 Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Patient Data'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Name'),
            TextFormField(
              controller: nameController,
              decoration: InputDecoration(hintText: 'Enter patient name'),
            ),
            SizedBox(height: 16),
            Text('DOB'),
            TextFormField(
              controller: dobController,
              decoration: InputDecoration(hintText: 'Enter date of birth'),
            ),
            SizedBox(height: 16),
            Text('Time'),
            TextFormField(
              controller: timeController,
              decoration: InputDecoration(hintText: 'Enter time'),
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
                 ),
                ),
                SizedBox(width: 16),
                Expanded(
                 child: TextFormField(
                    controller: rrController,
                    decoration: InputDecoration(hintText: 'Respiratory Rate'),
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
                    decoration: InputDecoration(hintText: 'Blood Oxygen'),
                 ),
                ),
                SizedBox(width: 16),
                Expanded(
                 child: TextFormField(
                    controller: hrController,
                    decoration: InputDecoration(hintText: 'Heart Rate'),
                 ),
                ),
              ],
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                 child: TextFormField(
                    controller: hbrController,
                    decoration: InputDecoration(hintText: 'Heartbeat Rate'),
                 ),
                ),
                SizedBox(width: 16),
                Expanded(
                 child: TextFormField(
                    controller: bolController,
                    decoration: InputDecoration(hintText: 'Blood Oxygen Level'),
                 ),
                ),
              ],
            ),
            SizedBox(height: 32),
            Center(
              child: ElevatedButton(
                onPressed: () async {
                 // Collect data from the controllers
                 String name = nameController.text;
                 String dob = dobController.text;
                 String time = timeController.text;
                 String bloodPressure = bpController.text;
                 String respiratoryRate = rrController.text;
                 String bloodOxygen = o2Controller.text;
                 String heartRate = hrController.text;
                 String heartbeatRate = hbrController.text; 
                 String bloodOxygenLevel = bolController.text; 

                 // Create a Patient object with the collected data
                 Patient newPatient = Patient(
                    name: name,
                    dob: dob,
                    time: time,
                    bloodPressure: bloodPressure,
                    respiratoryRate: respiratoryRate,
                    bloodOxygen: bloodOxygen,
                    heartRate: heartRate,
                    heartbeatRate: heartbeatRate, 
                    bloodOxygenLevel: bloodOxygenLevel, 
                 );

                 // Use the PatientService to add the new patient
                 bool success = await PatientService.addPatient(newPatient);
                 if (success) {
                    // Show a success message or navigate back
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Patient added successfully')),
                    );
                 } else {
                    // Show an error message
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Failed to add patient')),
                    );
                 }
                },
                child: Text('Save'),
              ),
            ),
          ],
        ),
      ),
    );
 }
}
