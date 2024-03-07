import 'dart:convert';
import 'package:http/http.dart' as http;
import 'patient.dart'; // Make sure to import your Patient class

class PatientService {
 static const String _baseUrl = 'http://127.0.0.1:5000'; // Adjust the base URL as needed

 Future<List<dynamic>> fetchPatients() async {
    final response = await http.get(Uri.parse('$_baseUrl/Patients'));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load patients');
    }
 }

 static Future<Patient> fetchPatientById(String patientId) async {
    final response = await http.get(Uri.parse('$_baseUrl/Patients/$patientId'));

    if (response.statusCode == 200) {
      // Use the Patient class to parse the JSON response
      return Patient.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load patient details');
    }
 }

 // Method to add a new patient
 static Future<bool> addPatient(Patient newPatient) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/Patients'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'name': newPatient.name,
        'age': newPatient.age,
        'address': newPatient.address,
        'gender': newPatient.gender,
        'phno': newPatient.phno,
        'tests': newPatient.tests.map((test) => {
          'bloodPressure': test.bloodPressure,
          'heartRate': test.heartRate,
          'respiratoryRate': test.respiratoryRate,
          'oxygenSaturation': test.oxygenSaturation,
          'bodyTemperature': test.bodyTemperature,
        }).toList(),
      }),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      // If the server returns a 200 OK or 201 Created response, then return true
      return true;
    } else {
      // If the server returns an error response, log the error and return false
      print('Failed to add patient. Server responded with status code: ${response.statusCode}');
      print('Response body: ${response.body}');
      return false;
    }
 }
}
