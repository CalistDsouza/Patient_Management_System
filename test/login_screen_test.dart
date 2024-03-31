import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_application_1/main.dart'; // Import your login screen


void main() {
 testWidgets('Login Form Display Test', (WidgetTester tester) async {
    // Arrange
    final widget = MaterialApp(
      home: MyLoginScreen(),
    );
    // Act
    await tester.pumpWidget(widget);
    // Assert
    expect(find.text('Sign in to your account'), findsOneWidget);
    expect(find.byType(TextFormField), findsNWidgets(2));
    expect(find.text('Log In'), findsOneWidget);
 });

 

 testWidgets('Invalid Credentials Error Message Displayed Test', (WidgetTester tester) async {
    // Arrange
    final widget = MaterialApp(
      home: MyLoginScreen(),
    );
    // Act
    await tester.pumpWidget(widget);
    await tester.enterText(find.byType(TextFormField).first, 'username');
    await tester.enterText(find.byType(TextFormField).last, 'password');
    await tester.tap(find.byType(ElevatedButton));
    await tester.pump();
    // Assert
    // Adjust the assertions based on how your validation logic is implemented
    // For example, if you display an error message when the credentials are invalid
    expect(find.text('Invalid username or password'), findsOneWidget);
 });

 testWidgets('Empty Username or Password Test', (WidgetTester tester) async {
    // Arrange
    final widget = MaterialApp(
      home: MyLoginScreen(),
    );
    // Act
    await tester.pumpWidget(widget);
    // Enter empty username and password
    await tester.enterText(find.byType(TextFormField).first, '');
    await tester.enterText(find.byType(TextFormField).last, '');
    await tester.tap(find.byType(ElevatedButton));
    await tester.pump();
    // Assert
    expect(find.text('Please enter your username'), findsOneWidget);
    expect(find.text('Please enter your password'), findsOneWidget);
 });
}
