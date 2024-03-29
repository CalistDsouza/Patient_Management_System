import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'patient.dart';
import 'patient_service.dart'; // Make sure this import is correct

class Patients with ChangeNotifier {
 List<Patient> _patients = [];
 final PatientService _patientService; // Add this line

 Patients() : _patientService = PatientService(); // Initialize it here

 List<Patient> get patients => _patients;

 Future<bool> addPatient(Patient patient) async {
 bool success = await PatientService.addPatient(patient);
 if (success) {
    _patients.add(patient);
    notifyListeners();
 }
 return success; // Return the success status
}

 void removePatient(String id) {
    _patients.removeWhere((patient) => patient.id == id);
    notifyListeners();
 }

 void updatePatient(Patient updatedPatient) {
    int index = _patients.indexWhere((patient) => patient.id == updatedPatient.id);
    if (index != -1) {
      _patients[index] = updatedPatient;
      notifyListeners();
    }
 }

 Future<void> fetchPatients() async {
    try {
      _patients = await _patientService.fetchPatients(); // Use _patientService here
      notifyListeners();
    } catch (error) {
      print('Error fetching patients: $error');
      // Handle the error appropriately
    }
 }
}
