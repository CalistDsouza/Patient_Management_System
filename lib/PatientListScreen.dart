import 'package:flutter/material.dart';
import 'patient_service.dart'; // Import the service
import 'AddPatientScreen.dart'; // Import the AddPatientScreen
import 'PatientProfileScreen.dart'; // Import the PatientProfileScreen
import 'patient.dart'; // Import the Patient class

class PatientListScreen extends StatelessWidget {
 final PatientService _patientService = PatientService();

 @override
 Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Patients'),
      ),
      body: FutureBuilder<List<dynamic>>(
        future: _patientService.fetchPatients(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            // Convert dynamic data to Patient objects
            List<Patient> patients = snapshot.data!.map((patientData) => Patient.fromJson(patientData)).toList();

            // Separate patients into critical and non-critical lists
            List<Patient> criticalPatients = [];
            List<Patient> nonCriticalPatients = [];
            patients.forEach((patient) {
              if (patient.isCritical()) {
                criticalPatients.add(patient);
              } else {
                nonCriticalPatients.add(patient);
              }
            });

            // Combine the lists with headings
            List<Widget> patientWidgets = [];
            if (criticalPatients.isNotEmpty) {
              patientWidgets.add(Text('Critical Patients', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)));
              patientWidgets.addAll(criticalPatients.map((patient) => _buildPatientTile(context, patient)).toList());
            }
            if (nonCriticalPatients.isNotEmpty) {
              patientWidgets.add(Text('Non-Critical Patients', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)));
              patientWidgets.addAll(nonCriticalPatients.map((patient) => _buildPatientTile(context, patient)).toList());
            }

            return ListView(
              children: patientWidgets,
            );
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }

          // By default, show a loading spinner.
          return const CircularProgressIndicator();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddPatientScreen()),
          );
        },
        child: const Icon(Icons.add),
        backgroundColor: Colors.blue,
      ),
    );
 }

 // Helper function to build a ListTile for a patient
 Widget _buildPatientTile(BuildContext context, Patient patient) {
    return ListTile(
      title: Text(patient.name),
      subtitle: Text('Age: ${patient.age}, Gender: ${patient.gender}'),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PatientProfileScreen(patientId: patient.id),
          ),
        );
      },
    );
 }
}
