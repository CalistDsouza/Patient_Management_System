import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'patients.dart'; // Import the Patients model
import 'Patientlistscreen.dart';

void main() {
 runApp(
    ChangeNotifierProvider(
      create: (context) => Patients(),
      child: MyApp(),
    ),
 );
}

class MyApp extends StatelessWidget {
 @override
 Widget build(BuildContext context) {
    return MaterialApp(
      home: MyLoginScreen(),
    );
 }
}

class MyLoginScreen extends StatefulWidget { // Define MyLoginScreen as a StatefulWidget
 @override
 _MyLoginScreenState createState() => _MyLoginScreenState();
}

class _MyLoginScreenState extends State<MyLoginScreen> {
 // Your login screen logic here

 final _formKey = GlobalKey<FormState>();
 TextEditingController _emailController = TextEditingController();
 TextEditingController _passwordController = TextEditingController();

 String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    }
    // Add additional email validation logic here
    return null;
 }

 String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }
    // Add additional password validation logic here
    return null;
 }

@override
Widget build(BuildContext context) {
 return Scaffold(
    appBar: AppBar(title: Text('Login Screen')),
    body: Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Sign in to your account title
              Text(
                'Sign in to your account',
                textAlign: TextAlign.center, // Center the text
                style: TextStyle(
                 fontSize: 24, // Adjust the font size as needed
                 fontWeight: FontWeight.bold, // Make the text bold
                ),
              ),
              SizedBox(height: 16), // Add some space between the title and the input fields

              // Email Input Field
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                 labelText: 'Username',
                 border: OutlineInputBorder(),
                ),
                validator: _validateEmail,
              ),
              SizedBox(height: 8),

              // Password Input Field
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                 labelText: 'Password',
                 border: OutlineInputBorder(),
                ),
                validator: _validatePassword,
              ),
              SizedBox(height: 8),

              // Log In Button
              ElevatedButton(
                onPressed: () {
                 if (_formKey.currentState?.validate() ?? false) {
                    // Check default credentials
                    if (_emailController.text == "admin" && _passwordController.text == "password") {
                      // Navigate to PatientListScreen
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => PatientListScreen()),
                      );
                    } else {
                      // Show error message or implement additional login logic
                    }
                 }
                },
                child: Text('Log In'),
                style: ElevatedButton.styleFrom(
                 foregroundColor: Colors.white, backgroundColor: Colors.blue, // Set text color to white
                ),
              ),
            ],
          ),
        ),
      ),
    ),
 );
}
}