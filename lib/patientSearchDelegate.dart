// patient_search_delegate.dart
import 'package:flutter/material.dart';
import 'patient.dart';

class PatientSearchDelegate extends SearchDelegate<Patient?> {
 final List<Patient> patients;

 PatientSearchDelegate({required this.patients});

 @override
 List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
 }

 @override
 Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        // Simply close the search delegate without passing null
        close(context, null);
      },
    );
 }

 @override
 Widget buildResults(BuildContext context) {
    return Container();
 }

 @override
 Widget buildSuggestions(BuildContext context) {
    final suggestions = query.isEmpty
        ? patients
        : patients.where((patient) {
            return patient.name.toLowerCase().contains(query.toLowerCase());
          }).toList();

    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(suggestions[index].name),
          onTap: () {
            close(context, suggestions[index]);
          },
        );
      },
    );
 }
}
