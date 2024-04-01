import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application_1/AddPatientScreen.dart';
import 'package:flutter_application_1/patients.dart';

void main() {
 // Test that the form is displayed with all the necessary fields and labels
 testWidgets('The form is displayed with all the necessary fields and labels', (WidgetTester tester) async {
    // Initialize the widget
    final widget = MaterialApp(
      home: AddPatientScreen(),
    );

    // Pump the widget
    await tester.pumpWidget(widget);

    // Verify the presence of necessary fields and labels
    expect(find.text('Name'), findsOneWidget);
    expect(find.text('Age'), findsOneWidget);
    expect(find.text('Address'), findsOneWidget);
    expect(find.text('Phone Number'), findsOneWidget);
    expect(find.text('Clinical Data'), findsOneWidget);
    expect(find.text('Blood Pressure'), findsOneWidget);
    expect(find.text('Respiratory Rate'), findsOneWidget);
    expect(find.text('Oxygen Saturation'), findsOneWidget);
    expect(find.text('Heart Rate'), findsOneWidget);
    expect(find.text('Body Temperature'), findsOneWidget);
    expect(find.text('Gender'), findsOneWidget);
 });




      
}