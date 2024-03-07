import 'package:flutter/material.dart';
import 'patient.dart';

class EditPatientProfileScreen extends StatefulWidget {
 final Patient patient;

 EditPatientProfileScreen({Key? key, required this.patient}) : super(key: key);

 @override
 _EditPatientProfileScreenState createState() => _EditPatientProfileScreenState();
}

class _EditPatientProfileScreenState extends State<EditPatientProfileScreen> {
 final _formKey = GlobalKey<FormState>();
 late String _bloodPressure;
 late String _respiratoryRate;
 late String _bloodOxygenLevel;
 late String _heartbeatRate;

 @override
 void initState() {
    super.initState();
    _bloodPressure = widget.patient.bloodPressure;
    _respiratoryRate = widget.patient.respiratoryRate;
    _bloodOxygenLevel = widget.patient.bloodOxygenLevel;
    _heartbeatRate = widget.patient.heartbeatRate;
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
                initialValue: _bloodPressure,
                decoration: InputDecoration(labelText: 'Blood Pressure (X/Y mmHg)'),
                validator: (value) {
                 if (value == null || value.isEmpty) {
                    return 'Please enter the blood pressure';
                 }
                 return null;
                },
                onSaved: (value) {
                 _bloodPressure = value!;
                },
              ),
              TextFormField(
                initialValue: _respiratoryRate,
                decoration: InputDecoration(labelText: 'Respiratory Rate (X/min)'),
                validator: (value) {
                 if (value == null || value.isEmpty) {
                    return 'Please enter the respiratory rate';
                 }
                 return null;
                },
                onSaved: (value) {
                 _respiratoryRate = value!;
                },
              ),
              TextFormField(
                initialValue: _bloodOxygenLevel,
                decoration: InputDecoration(labelText: 'Blood Oxygen Level (X%)'),
                validator: (value) {
                 if (value == null || value.isEmpty) {
                    return 'Please enter the blood oxygen level';
                 }
                 return null;
                },
                onSaved: (value) {
                 _bloodOxygenLevel = value!;
                },
              ),
              TextFormField(
                initialValue: _heartbeatRate,
                decoration: InputDecoration(labelText: 'Heartbeat Rate (X/min)'),
                validator: (value) {
                 if (value == null || value.isEmpty) {
                    return 'Please enter the heartbeat rate';
                 }
                 return null;
                },
                onSaved: (value) {
                 _heartbeatRate = value!;
                },
              ),
              ElevatedButton(
                onPressed: () {
                 if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    // Create a new Patient object with the updated values
                    Patient updatedPatient = Patient(
                      name: widget.patient.name, // Assuming name is not editable
                      dob: widget.patient.dob, // Assuming DOB is not editable
                      time: widget.patient.time, // Assuming time is not editable
                      bloodPressure: _bloodPressure,
                      respiratoryRate: _respiratoryRate,
                      bloodOxygen: widget.patient.bloodOxygen, // Assuming blood oxygen is not editable
                      heartRate: widget.patient.heartRate, // Assuming heart rate is not editable
                      heartbeatRate: _heartbeatRate,
                      bloodOxygenLevel: _bloodOxygenLevel,
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
