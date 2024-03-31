import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_application_1/AddPatientScreen.dart'; // Import your login screen

void main() {
 // The form is displayed with all the necessary fields and labels
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
     });

 // The form cannot be submitted with invalid data
 testWidgets('The form cannot be submitted with invalid data', (WidgetTester tester) async {
 // Initialize the widget
 final widget = MaterialApp(
    home: AddPatientScreen(),
 );

 // Pump the widget
 await tester.pumpWidget(widget);

 // Simulate user input into the form fields
 await tester.enterText(find.byType(TextFormField).at(0), ''); // Name field
 await tester.enterText(find.byType(TextFormField).at(1), ''); // Age field
 await tester.enterText(find.byType(TextFormField).at(2), ''); // Address field
 await tester.enterText(find.byType(TextFormField).at(3), ''); // Phone Number field
 await tester.enterText(find.byType(TextFormField).at(4), ''); // Blood Pressure field
 await tester.enterText(find.byType(TextFormField).at(5), ''); // Respiratory Rate field
 await tester.enterText(find.byType(TextFormField).at(6), ''); // Oxygen Saturation field
 await tester.enterText(find.byType(TextFormField).at(7), ''); // Heart Rate field
 await tester.enterText(find.byType(TextFormField).at(8), ''); // Body Temperature field

 // Tap the 'Save' button
 await tester.tap(find.byType(ElevatedButton));
 await tester.pumpAndSettle(); // Wait for any asynchronous operations to complete

 // Verify that the form did not submit and that error messages are displayed
 expect(find.text('Please enter a name'), findsOneWidget);
 expect(find.text('Please enter an age'), findsOneWidget);
 expect(find.text('Please enter an address'), findsOneWidget);
 expect(find.text('Please enter a phone number'), findsOneWidget);
 expect(find.text('Please enter blood pressure'), findsOneWidget);
 expect(find.text('Please enter respiratory rate'), findsOneWidget);
 expect(find.text('Please enter oxygen saturation'), findsOneWidget);
 expect(find.text('Please enter heart rate'), findsOneWidget);
 expect(find.text('Please enter body temperature'), findsOneWidget);
});


}
