// ignore_for_file: use_build_context_synchronously, file_names

import 'package:flutter/material.dart';
import 'package:flutter_application_1/patient_service.dart';
import 'package:provider/provider.dart';
import 'patients.dart'; // Import the Patients model
import 'package:http/http.dart' as http;
import 'EditPatientProfileScreen.dart';
import 'patient.dart';
import 'AddTestScreen.dart';
import 'package:intl/intl.dart';

class PatientProfileScreen extends StatefulWidget {
  final String? patientId;

  PatientProfileScreen({Key? key, this.patientId}) : super(key: key);

  @override
  _PatientProfileScreenState createState() => _PatientProfileScreenState();
}

class _PatientProfileScreenState extends State<PatientProfileScreen> {
  late Patient? patient;

  @override
 void initState() {
    super.initState();
    _fetchPatientData();
 }

 void _fetchPatientData() async {
 // Fetch patient data here and update the patient variable
 // This is a placeholder for your actual data fetching logic
 Patient? fetchedPatient = await PatientService.fetchPatientById(widget.patientId!);
 setState(() {
    patient = fetchedPatient;
 });
}

 void _onTestAdded() {
    // This function is called after a test is added
    // Refresh the patient data to include the newly added test
    _fetchPatientData();
 }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Patient Profile'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: <Widget>[
          // Inside the AppBar actions list in PatientProfileScreen
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      AddTestScreen(patientId: widget.patientId),
                ),
              );
            },
          ),

          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: editPatient,
          ),
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: deletePatient,
          ),
        ],
      ),
      body: FutureBuilder<Patient?>(
        future: _loadPatient(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Error loading patient data.'));
          } else if (snapshot.hasData) {
            patient = snapshot.data;
            // Your existing UI code here, using `patient`
            return SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Center(
                    child: CircleAvatar(
                      radius: 60.0,
                      backgroundImage: AssetImage('assets/place_holder.png'),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    '${patient!.name}',
                    style: const TextStyle(
                        fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Age: ${patient!.age}, Gender: ${patient!.gender}',
                    style: const TextStyle(fontSize: 18),
                  ),
                  const SizedBox(height: 20),
                  if (patient!.isCritical())
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Patient is in critical condition.',
                        style: TextStyle(
                            color: Colors.red, fontWeight: FontWeight.bold),
                      ),
                    ),
                  const SizedBox(height: 20),
                  const Text(
                    'Medical History:',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  if (patient!.tests.isNotEmpty)
                    ...patient!.tests
                        .map((test) => Card(
                              margin: const EdgeInsets.symmetric(vertical: 10),
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Date and Time: ${DateFormat('yyyy-MM-dd, HH:mm').format(test.date)}', // Display the date and time of the test
                                      style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(
                                        height:
                                            8), // Add space between text elements
                                    Text(
                                      'Blood Pressure: ${test.bloodPressure} mmHg',
                                      style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(
                                        height:
                                            8), // Add space between text elements
                                    Text(
                                      'Heart Rate: ${test.heartRate} bpm',
                                      style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(
                                        height:
                                            8), // Add space between text elements
                                    Text(
                                      'Respiratory Rate: ${test.respiratoryRate} breaths/minute',
                                      style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(
                                        height:
                                            8), // Add space between text elements
                                    Text(
                                      'Oxygen Saturation: ${test.oxygenSaturation} %',
                                      style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(
                                        height:
                                            8), // Add space between text elements
                                    Text(
                                      'Body Temperature: ${test.bodyTemperature} °F',
                                      style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    ElevatedButton(
                                      onPressed: () => deleteTest(test
                                          .id), // Assuming each test has a unique ID
                                      child: const Icon(Icons
                                          .delete,
                                          color: Colors.red,), // Use an icon instead of text
                                    ),
                                  ],
                                ),
                              ),
                            ))
                        .toList(),
                  // if (patient!.isCritical())
                  //   const Padding(
                  //     padding: EdgeInsets.all(8.0),
                  //     child: Text(
                  //       'Patient is in critical condition.',
                  //       style: TextStyle(
                  //           color: Colors.red, fontWeight: FontWeight.bold),
                  //     ),
                  //   ),
                ],
              ),
            );
          } else {
            return const Center(child: Text('No patient selected.'));
          }
        },
      ),
    );
  }

  Future<Patient?> _loadPatient() async {
    if (widget.patientId != null) {
      try {
        return Provider.of<Patients>(context, listen: false)
            .patients
            .firstWhere((p) => p.id == widget.patientId);
      } catch (e) {
        print("Error loading patient: $e");
        // print("Error: No patient found with the given ID.");
        return null;
      }
    }
    return null;
  }

  Future<void> deletePatient() async {
    if (widget.patientId == null) return;

    // First, attempt to delete the patient from the backend
    final response = await http.delete(
        Uri.parse('https://web-techs-nodejs.onrender.com/Patients/${widget.patientId}'));

    if (response.statusCode == 200) {
      // If the backend deletion is successful, remove the patient from the local model
      Provider.of<Patients>(context, listen: false)
          .removePatient(widget.patientId!);

      // Show a success message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Patient deleted successfully')),
      );

      // Optionally, navigate back to the previous screen or refresh the current screen
      Navigator.pop(context);
    } else {
      // If the backend deletion fails, show an error message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to delete patient')),
      );
    }
  }

  Future<void> deleteTest(String testId) async {
    final response = await http.delete(
      Uri.parse(
          'https://web-techs-nodejs.onrender.com/Patients/${widget.patientId}/tests/$testId'),
    );

    if (response.statusCode == 200) {
      // If the server returns a 200 OK response, then the test was deleted successfully.
      // You might want to update the UI to reflect this change.
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Test deleted successfully')),
      );
      // Optionally, refresh the patient's tests list here
      setState(() {
        // This will trigger a rebuild of the widget, which should update the UI to reflect the deletion.
      });
    } else {
      // If the server returns an error response, then handle the error.
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to delete test')),
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
        builder: (context) =>
            EditPatientProfileScreen(patientId: widget.patientId!),
      ),
    );
  }
}
