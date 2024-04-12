import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AddTestScreen extends StatefulWidget {
 final String? patientId;

 AddTestScreen({Key? key, this.patientId}) : super(key: key);

 @override
 _AddTestScreenState createState() => _AddTestScreenState();
}

class _AddTestScreenState extends State<AddTestScreen> {
 final _formKey = GlobalKey<FormState>();
 DateTime? _selectedDate;
 String _bloodPressure = '';
 String _heartRate = '';
 String _respiratoryRate = '';
 String _oxygenSaturation = '';
 String _bodyTemperature = '';

 // Initialize the TextEditingController for the date field
 final _dateController = TextEditingController();

 @override
 void initState() {
   super.initState();
   // Initialize the controller's value with the current date if _selectedDate is null
   _dateController.text = _selectedDate?.toIso8601String() ?? DateTime.now().toIso8601String();
 }

 @override
 Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Test'),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              // Date Picker
              TextFormField(
                controller: _dateController, // Use the controller here
                decoration: InputDecoration(labelText: 'Date'),
                onTap: () async {
                 final DateTime? picked = await showDatePicker(
                    context: context,
                    initialDate: _selectedDate ?? DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime.now(),
                 );
                 if (picked != null && picked != _selectedDate) {
                    setState(() {
                      _selectedDate = picked;
                      // Update the controller's value with the selected date
                      _dateController.text = _selectedDate!.toIso8601String();
                    });
                 }
                },
                // validator: (value) {
                //  if (_selectedDate == null) {
                //     return 'Please select a date';
                //  }
                //  return null;
                // },
              ),
              // Blood Pressure
              TextFormField(
                initialValue: _bloodPressure,
                decoration: const InputDecoration(labelText: 'Blood Pressure'),
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
              // Heart Rate
              TextFormField(
                initialValue: _heartRate,
                decoration: const InputDecoration(labelText: 'Heart Rate'),
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
              // Respiratory Rate
              TextFormField(
                initialValue: _respiratoryRate,
                decoration: const InputDecoration(labelText: 'Respiratory Rate'),
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
              // Oxygen Saturation
              TextFormField(
                initialValue: _oxygenSaturation,
                decoration: const InputDecoration(labelText: 'Oxygen Saturation'),
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
              // Body Temperature
              TextFormField(
                initialValue: _bodyTemperature,
                decoration: const InputDecoration(labelText: 'Body Temperature'),
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
                onPressed: () async {
                 if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    // Example API call to add a test
                    final response = await http.post(
                      Uri.parse('http://127.0.0.1:5000/Patients/${widget.patientId}/tests'),
                      headers: <String, String>{
                        'Content-Type': 'application/json; charset=UTF-8',
                      },
                      body: jsonEncode(<String, dynamic>{
                        'date': _selectedDate!.toIso8601String(),
                        'bloodPressure': _bloodPressure,
                        'heartRate': _heartRate,
                        'respiratoryRate': _respiratoryRate,
                        'oxygenSaturation': _oxygenSaturation,
                        'bodyTemperature': _bodyTemperature,
                      }),
                    );
                    if (response.statusCode == 200) {
                      // If the server returns a 200 OK response, then navigate back to the PatientProfileScreen
                      Navigator.pop(context);
                    } else {
                      // If the server returns an error response, then show an error message
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Failed to add test')),
                      );
                    }
                 }
                },
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
 }

 @override
 void dispose() {
   // Clean up the controller when the widget is disposed
   _dateController.dispose();
   super.dispose();
 }
}
