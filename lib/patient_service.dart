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
        'dob': newPatient.dob,
        'time': newPatient.time,
        'bloodPressure': newPatient.bloodPressure,
        'respiratoryRate': newPatient.respiratoryRate,
        'bloodOxygen': newPatient.bloodOxygen,
        'heartRate': newPatient.heartRate,
        'heartbeatRate': newPatient.heartbeatRate,
        'bloodOxygenLevel': newPatient.bloodOxygenLevel,
      }),
    );

    if (response.statusCode == 200) {
      // If the server returns a 200 OK response, then return true
      return true;
    } else {
      // If the server returns an error response, then return false
      return false;
    }
 }
}
