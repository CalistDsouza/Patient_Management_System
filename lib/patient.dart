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

  // Convert a Patient object into a Map. The keys must correspond to the
  // names of the fields in the JSON.
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
}
