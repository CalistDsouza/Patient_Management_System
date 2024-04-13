import 'dart:convert';
import 'package:http/http.dart' as http;
import 'patient.dart'; // Make sure to import your Patient class

class PatientService {
  static const String _baseUrl =
      'https://web-techs-nodejs.onrender.com'; // Adjust the base URL as needed

  Future<List<Patient>> fetchPatients() async {
    final response = await http.get(Uri.parse('$_baseUrl/Patients'));

    if (response.statusCode == 200) {
      // print('JSON Response: ${response.body}'); // Print the JSON response
      List<dynamic> jsonResponse = jsonDecode(response.body);
      return jsonResponse.map((json) => Patient.fromJson(json)).toList();
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
        'age': newPatient
            .age, // Assuming you have an age property in your Patient class
        'address': newPatient
            .address, // Assuming you have an address property in your Patient class
        'gender': newPatient
            .gender, // Assuming you have a gender property in your Patient class
        'phno': newPatient
            .phno, // Assuming you have a phno property in your Patient class
        'tests': newPatient.tests
            .map((test) => {
                  'bloodPressure': test.bloodPressure,
                  'heartRate': test.heartRate,
                  'respiratoryRate': test.respiratoryRate,
                  'oxygenSaturation': test.oxygenSaturation,
                  'bodyTemperature': test.bodyTemperature,
                })
            .toList(),
      }),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      // If the server returns a 200 OK response, then return true
      return true;
    } else {
      // If the server returns an error response, then return false
      return false;
    }
  }
}
