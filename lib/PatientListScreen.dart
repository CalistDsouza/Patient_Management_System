import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'patients.dart'; // Import the Patients model
import 'AddPatientScreen.dart';
import 'PatientProfileScreen.dart';
import 'patient.dart';
import 'patientSearchDelegate.dart'; // Ensure this import matches the file name

class PatientListScreen extends StatefulWidget {
 @override
 _PatientListScreenState createState() => _PatientListScreenState();
}
class _PatientListScreenState extends State<PatientListScreen> {
 final TextEditingController _searchController = TextEditingController();

 @override
 void initState() {
    super.initState();
    Provider.of<Patients>(context, listen: false).fetchPatients();
 }

 @override
 void dispose() {
    _searchController.dispose();
    super.dispose();
 }

 @override
 Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _searchController,
          decoration: InputDecoration(
            hintText: 'Search by name or condition',
            prefixIcon: Icon(Icons.search),
            suffixIcon: IconButton(
              icon: Icon(Icons.clear),
              onPressed: () {
                _searchController.clear();
              },
            ),
          ),
          onChanged: (value) {
            setState(() {});
          },
        ),
        
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await Provider.of<Patients>(context, listen: false).fetchPatients();
          setState(() {});
        },
        child: Consumer<Patients>(
          builder: (context, patients, child) {
            if (patients.patients.isEmpty) {
              return Center(child: CircularProgressIndicator());
            }

            final String searchQuery = _searchController.text.toLowerCase();
            final List<Patient> filteredPatients = patients.patients
                .where((patient) => patient.name.toLowerCase().contains(searchQuery) ||
                                    (searchQuery == "critical" && patient.isCritical()) ||
                                    (searchQuery == "non-critical" && !patient.isCritical()))
                .toList();

            List<Patient> criticalPatients = [];
            List<Patient> nonCriticalPatients = [];
            filteredPatients.forEach((patient) {
              if (patient.isCritical()) {
                criticalPatients.add(patient);
              } else {
                nonCriticalPatients.add(patient);
              }
            });

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

