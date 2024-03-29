import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'patients.dart'; // Import the Patients model
import 'AddPatientScreen.dart';
import 'PatientProfileScreen.dart';
import 'patient.dart';

class PatientListScreen extends StatefulWidget {
 @override
 _PatientListScreenState createState() => _PatientListScreenState();
}

class _PatientListScreenState extends State<PatientListScreen> {
 @override
 void initState() {
    super.initState();
    Provider.of<Patients>(context, listen: false).fetchPatients();
 }

 @override
 Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Patients'),
      ),
      body: Consumer<Patients>(
        builder: (context, patients, child) {
          if (patients.patients.isEmpty) {
            return Center(child: CircularProgressIndicator()); // Loading indicator
          }

          // Separate patients into critical and non-critical lists
          List<Patient> criticalPatients = [];
          List<Patient> nonCriticalPatients = [];
          patients.patients.forEach((patient) {
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

          return ListView.builder(
            itemCount: patientWidgets.length,
            itemBuilder: (context, index) {
              return patientWidgets[index];
            },
          );
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
