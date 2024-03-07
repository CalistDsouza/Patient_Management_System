class Patient {
 final String name;
 final String dob;
 final String time;
 final String bloodPressure;
 final String respiratoryRate;
 final String bloodOxygen;
 final String heartRate;
 final String heartbeatRate;
 final String bloodOxygenLevel;

 Patient({
    required this.name,
    required this.dob,
    required this.time,
    required this.bloodPressure,
    required this.respiratoryRate,
    required this.bloodOxygen,
    required this.heartRate,
    required this.heartbeatRate,
    required this.bloodOxygenLevel,
 });

 factory Patient.fromJson(Map<String, dynamic> json) {
    return Patient(
      name: json['name'],
      dob: json['dob'],
      time: json['time'],
      bloodPressure: json['bloodPressure'],
      respiratoryRate: json['respiratoryRate'],
      bloodOxygen: json['bloodOxygen'],
      heartRate: json['heartRate'],
      heartbeatRate: json['heartbeatRate'],
      bloodOxygenLevel: json['bloodOxygenLevel'],
    );
 }
}
