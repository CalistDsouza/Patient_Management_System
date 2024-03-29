import 'Test.dart';

class Patient {
 final String? id;
 final String name;
 final String age;
 final String address;
 final String gender;
 final String phno;
 final List<Test> tests;

 Patient({
    this.id,
    required this.name,
    required this.age,
    required this.address,
    required this.gender,
    required this.phno,
    required this.tests,
 });

 factory Patient.fromJson(Map<String, dynamic> json) {
    var testsFromJson = json['tests'] as List? ?? [];
    List<Test> testsList = testsFromJson.map((i) => Test.fromJson(i)).toList();

    return Patient(
      id: json['_id'] as String?,
      name: json['name'] as String? ?? 'N/A',
      age: json['age'] as String? ?? 'N/A',
      address: json['address'] as String? ?? 'N/A',
      gender: json['gender'] as String? ?? 'N/A',
      phno: json['phno'] as String? ?? 'N/A',
      tests: testsList,
    );
 }

 Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'age': age,
      'address': address,
      'gender': gender,
      'phno': phno,
      'tests': tests.map((test) => test.toJson()).toList(),
    };
 }

 // Method to check if the patient is critical
 bool isCritical() {
    final latestTest = tests.last; // Assuming tests are sorted in the order they were added

    // Convert String values to int for comparison
    int bloodPressure = int.parse(latestTest.bloodPressure);
    int heartRate = int.parse(latestTest.heartRate);
    int respiratoryRate = int.parse(latestTest.respiratoryRate);
    int oxygenSaturation = int.parse(latestTest.oxygenSaturation);
    double bodyTemperature = double.parse(latestTest.bodyTemperature);

    return bloodPressure < 70 ||
           bloodPressure > 120 ||
           heartRate < 60 ||
           heartRate > 100 ||
           respiratoryRate < 12 ||
           respiratoryRate > 20 ||
           oxygenSaturation < 95 ||
           oxygenSaturation > 100 ||
           bodyTemperature < 97 ||
           bodyTemperature > 99;
 }
}
