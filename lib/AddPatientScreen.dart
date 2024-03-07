import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'Test.dart';
import 'patient_service.dart';
import 'patient.dart';

class AddPatientScreen extends StatefulWidget {
 @override
 _AddPatientScreenState createState() => _AddPatientScreenState();
}

class _AddPatientScreenState extends State<AddPatientScreen> {
 final TextEditingController nameController = TextEditingController();
 final TextEditingController ageController = TextEditingController();
 final TextEditingController addressController = TextEditingController();
 final TextEditingController genderController = TextEditingController();
 final TextEditingController phnoController = TextEditingController();
 final TextEditingController bpController = TextEditingController();
 final TextEditingController rrController = TextEditingController();
 final TextEditingController o2Controller = TextEditingController();
 final TextEditingController hrController = TextEditingController();
 final TextEditingController bolController = TextEditingController();

 @override
 Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Patient Data'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView( // Wrap the Column in a SingleChildScrollView
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Name'),
              TextFormField(
                controller: nameController,
                decoration: InputDecoration(hintText: 'Enter patient name'),
              ),
              SizedBox(height: 16),
              Text('Age'),
              TextFormField(
                controller: ageController,
                decoration: InputDecoration(hintText: 'Enter age'),
              ),
              SizedBox(height: 16),
              Text('Address'),
              TextFormField(
                controller: addressController,
                decoration: InputDecoration(hintText: 'Enter address'),
              ),
              SizedBox(height: 16),
              Text('Gender'),
              TextFormField(
                controller: genderController,
                decoration: InputDecoration(hintText: 'Enter gender'),
              ),
              SizedBox(height: 16),
              Text('Phone Number'),
              TextFormField(
                controller: phnoController,
                decoration: InputDecoration(hintText: 'Enter phone number'),
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
                      decoration: InputDecoration(hintText: 'Oxygen Saturation'),
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
                      controller: bolController,
                      decoration: InputDecoration(hintText: 'Body Temperature'),
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
                    String age = ageController.text;
                    String address = addressController.text;
                    String gender = genderController.text;
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
                      gender: gender,
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
      ),
    );
 }
}
