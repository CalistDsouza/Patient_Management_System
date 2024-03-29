// ignore_for_file: file_names

import 'package:flutter/foundation.dart';
import 'patient.dart'; // Import your Patient model

class PatientStateManager {
  static final ValueNotifier<List<Patient>> patientListNotifier =
      ValueNotifier<List<Patient>>([]);
}
