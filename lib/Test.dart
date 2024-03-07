class Test {
 final String bloodPressure;
 final String heartRate;
 final String respiratoryRate;
 final String oxygenSaturation;
 final String bodyTemperature;

 Test({
    required this.bloodPressure,
    required this.heartRate,
    required this.respiratoryRate,
    required this.oxygenSaturation,
    required this.bodyTemperature,
 });

 factory Test.fromJson(Map<String, dynamic> json) {
    return Test(
      bloodPressure: json['bloodPressure'],
      heartRate: json['heartRate'],
      respiratoryRate: json['respiratoryRate'],
      oxygenSaturation: json['oxygenSaturation'],
      bodyTemperature: json['bodyTemperature'],
    );
 }
}
