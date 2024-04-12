class Test {
  final String id;
  final DateTime date;
  final String bloodPressure;
  final String heartRate;
  final String respiratoryRate;
  final String oxygenSaturation;
  final String bodyTemperature;

  Test({
    this.id= '',
    required this.date,
    required this.bloodPressure,
    required this.heartRate,
    required this.respiratoryRate,
    required this.oxygenSaturation,
    required this.bodyTemperature,
  });

  factory Test.fromJson(Map<String, dynamic> json) {
    DateTime? date;
    if (json['date'] != null) {
      date = DateTime.parse(json['date']);
    }
    return Test(
      id: json['_id'] as String,
      date: date ??
          DateTime.now(), // Use the current date as a fallback if date is null
      bloodPressure: json['bloodPressure'] as String? ?? 'N/A',
      heartRate: json['heartRate'] as String? ?? 'N/A',
      respiratoryRate: json['respiratoryRate'] as String? ?? 'N/A',
      oxygenSaturation: json['oxygenSaturation'] as String? ?? 'N/A',
      bodyTemperature: json['bodyTemperature'] as String? ?? 'N/A',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'date': date.toIso8601String(),
      'bloodPressure': bloodPressure,
      'heartRate': heartRate,
      'respiratoryRate': respiratoryRate,
      'oxygenSaturation': oxygenSaturation,
      'bodyTemperature': bodyTemperature,
    };
  }
}
