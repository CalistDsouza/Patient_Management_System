import 'package:flutter/material.dart';
import 'patient_service.dart'; // Import the service
import 'AddPatientScreen.dart'; // Import the AddPatientScreen
import 'PatientProfileScreen.dart'; // Import the PatientProfileScreen

class PatientListScreen extends StatelessWidget {
 final PatientService _patientService = PatientService();

 @override
 Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Patients'),
      ),
      body: FutureBuilder<List<dynamic>>(
        future: _patientService.fetchPatients(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final patient = snapshot.data![index];
                return ListTile(
                 title: Text(patient['name']),
                 subtitle: Text('Age: ${patient['age']}, Gender: ${patient['gender']}'),
                 onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PatientProfileScreen(patientId: patient['_id']),
                      ),
                    );
                 },
                );
              },
            );
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }

          // By default, show a loading spinner.
          return CircularProgressIndicator();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddPatientScreen()),
          );
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.blue,
      ),
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Align(
                 alignment: Alignment.centerRight,
                //  child: ElevatedButton(
                //     onPressed: () {
                //       // Navigate to the PatientProfileScreen without passing any data
                //       Navigator.push(
                //         context,
                //         MaterialPageRoute(
                //           builder: (context) => PatientProfileScreen(),
                //         ),
                //       );
                //     },
                //     child: Text('Next'),
                //  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
 }
}
