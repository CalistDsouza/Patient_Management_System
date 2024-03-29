// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'patients.dart'; // Import the Patients model
import 'Patientlistscreen.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => Patients(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyLoginScreen(),
    );
  }
}

class MyLoginScreen extends StatefulWidget {
  const MyLoginScreen({super.key});

  // Define MyLoginScreen as a StatefulWidget
  @override
  _MyLoginScreenState createState() => _MyLoginScreenState();
}

class _MyLoginScreenState extends State<MyLoginScreen> {
  // Your login screen logic here

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

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
      appBar: AppBar(title: const Text('Login Screen')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Sign in to your account title
                const Text(
                  'Sign in to your account',
                  textAlign: TextAlign.center, // Center the text
                  style: TextStyle(
                    fontSize: 24, // Adjust the font size as needed
                    fontWeight: FontWeight.bold, // Make the text bold
                  ),
                ),
                const SizedBox(
                    height:
                        16), // Add some space between the title and the input fields

                // Email Input Field
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    labelText: 'Username',
                    border: OutlineInputBorder(),
                  ),
                  validator: _validateEmail,
                ),
                const SizedBox(height: 8),

                // Password Input Field
                TextFormField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(),
                  ),
                  validator: _validatePassword,
                ),
                const SizedBox(height: 8),

                // Log In Button
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState?.validate() ?? false) {
                      // Check default credentials
                      if (_emailController.text == "admin" &&
                          _passwordController.text == "password") {
                        // Navigate to PatientListScreen
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PatientListScreen()),
                        );
                      } else {
                        // Show error message or implement additional login logic
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.blue, // Set text color to white
                  ),
                  child: const Text('Log In'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
