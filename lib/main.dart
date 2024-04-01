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

 @override
 _MyLoginScreenState createState() => _MyLoginScreenState();
}

class _MyLoginScreenState extends State<MyLoginScreen> {
 final _formKey = GlobalKey<FormState>();
 final TextEditingController _usernameController = TextEditingController();
 final TextEditingController _passwordController = TextEditingController();
 String? _errorMessage; // State variable for the error message

 String? _validateUsername(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your username';
    }
    return null;
 }

 String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }
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
                const Text(
                 'Sign in to your account',
                 textAlign: TextAlign.center,
                 style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                 ),
                ),
                const SizedBox(height: 16),

                TextFormField(
                 controller: _usernameController,
                 decoration: const InputDecoration(
                    labelText: 'Username',
                    border: OutlineInputBorder(),
                 ),
                 validator: _validateUsername,
                ),
                const SizedBox(height: 8),

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

                if (_errorMessage != null)
                 Text(
                    _errorMessage!,
                    style: TextStyle(color: Colors.red),
                 ),

                ElevatedButton(
                 onPressed: () {
                    if (_formKey.currentState?.validate() ?? false) {
                      if (_usernameController.text == "admin" &&
                          _passwordController.text == "password") {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PatientListScreen()),
                        );
                      } else {
                        setState(() {
                          _errorMessage = 'Invalid username or password';
                        });
                      }
                    }
                 },
                 style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.blue,
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
