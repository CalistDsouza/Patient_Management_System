import 'package:flutter/material.dart';
import 'Test.dart';
import 'patient.dart';

class EditPatientProfileScreen extends StatefulWidget {
 final Patient patient;

 EditPatientProfileScreen({Key? key, required this.patient}) : super(key: key);

 @override
 _EditPatientProfileScreenState createState() => _EditPatientProfileScreenState();
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

 @override
 void initState() {
 super.initState();
 _name = widget.patient.name;
 _age = widget.patient.age; // Assuming age is editable
 _address = widget.patient.address; // Assuming address is editable
 _gender = widget.patient.gender; // Assuming gender is editable
 _phno = widget.patient.phno; // Assuming phno is editable
 // Assuming the first test in the list is being edited
 if (widget.patient.tests.isNotEmpty) {
    Test firstTest = widget.patient.tests[0];
    _bloodPressure = firstTest.bloodPressure;
    _heartRate = firstTest.heartRate;
    _respiratoryRate = firstTest.respiratoryRate;
    _oxygenSaturation = firstTest.oxygenSaturation;
    _bodyTemperature = firstTest.bodyTemperature;
 }
}


 @override
 Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Patient Profile'),
      ),
      body: Form(
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
                decoration: InputDecoration(labelText: 'Blood Pressure (X/Y mmHg)'),
                onSaved: (value) {
                 _bloodPressure = value!;
                },
              ),
              TextFormField(
                initialValue: _heartRate,
                decoration: InputDecoration(labelText: 'Heart Rate (X/min)'),
                onSaved: (value) {
                 _heartRate = value!;
                },
              ),
              TextFormField(
                initialValue: _respiratoryRate,
                decoration: InputDecoration(labelText: 'Respiratory Rate (X/min)'),
                onSaved: (value) {
                 _respiratoryRate = value!;
                },
              ),
              TextFormField(
                initialValue: _oxygenSaturation,
                decoration: InputDecoration(labelText: 'Oxygen Saturation (X%)'),
                onSaved: (value) {
                 _oxygenSaturation = value!;
                },
              ),
              TextFormField(
                initialValue: _bodyTemperature,
                decoration: InputDecoration(labelText: 'Body Temperature (X°C)'),
                onSaved: (value) {
                 _bodyTemperature = value!;
                },
              ),
              ElevatedButton(
                onPressed: () {
                 if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    // Create a new Patient object with the updated values
                   Patient updatedPatient = Patient(
                    name: _name,
                    age: _age,
                    address: _address,
                    gender: _gender,
                    phno: _phno,
                    tests: [
                        Test(
                          bloodPressure: _bloodPressure,
                          heartRate: _heartRate,
                          respiratoryRate: _respiratoryRate,
                          oxygenSaturation: _oxygenSaturation,
                          bodyTemperature: _bodyTemperature,
                        ),
                    ],
                    );

                    // Pass the updated patient object back to the previous screen
                    Navigator.pop(context, updatedPatient);
                 }
                },
                child: Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
 }
}
