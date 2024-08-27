// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project/screens/loginpage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class StudentInfoRegistrationPage extends StatefulWidget {
  const StudentInfoRegistrationPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _StudentInfoRegistrationPageState createState() => _StudentInfoRegistrationPageState();
}

class _StudentInfoRegistrationPageState extends State<StudentInfoRegistrationPage> {
  final TextEditingController _studentName = TextEditingController();
  final TextEditingController _studentID = TextEditingController();
  final TextEditingController _courseTaken = TextEditingController();
  final TextEditingController _yearIntake = TextEditingController();

  String? _profileImageUrl;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50],
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          'NEUC STUDENT APPLICATION',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Student Register",
                  style: TextStyle(
                    fontSize: 25,
                    wordSpacing: 4,
                    letterSpacing: 3,
                    color: Colors.black,
                  )),
              const SizedBox(height: 20),
              // Display the uploaded profile picture in a circular container
              _profileImageUrl != null
                  ? CircleAvatar(
                      radius: 50,
                      backgroundImage: NetworkImage(_profileImageUrl!),
                    )
                  : const CircleAvatar(
                      radius: 50,
                      child: Icon(Icons.person, size: 50),
                    ),
              const SizedBox(height: 20),
              TextField(
                controller: _studentName,
                decoration: const InputDecoration(
                  labelText: 'Student Name',
                  prefixIcon: Icon(Icons.person),
                  fillColor: Colors.white,
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _studentID,
                decoration: const InputDecoration(
                  labelText: 'Student ID',
                  prefixIcon: Icon(Icons.picture_in_picture_rounded),
                  fillColor: Colors.white,
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _courseTaken,
                decoration: const InputDecoration(
                  labelText: 'Course Taken',
                  prefixIcon: Icon(Icons.menu_book),
                  fillColor: Colors.white,
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _yearIntake,
                decoration: const InputDecoration(
                  labelText: 'Year Intake',
                  prefixIcon: Icon(Icons.edit_calendar_sharp),
                  fillColor: Colors.white,
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                ),
              ),
              const SizedBox(height: 40),
              SizedBox(
                width: 200,
                child: ElevatedButton(
                  onPressed: () {
                    _saveStudentInfo(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                  ),
                  child: const Text(
                    'Confirm',
                    style: TextStyle(fontSize: 15, color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _saveStudentInfo(BuildContext context) async {
    if (_studentName.text.isEmpty ||
        _studentID.text.isEmpty ||
        _courseTaken.text.isEmpty ||
        _yearIntake.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text(
                'Please fill in all information for student registrations.')),
      );
    } else {
      try {
        final User? user = FirebaseAuth.instance.currentUser;

        if (user != null) {
          String userEmail = user.email!;

          // Save student information to Firestore
          await FirebaseFirestore.instance
              .collection('users')
              .doc(userEmail)
              .set({
            'studentName': _studentName.text,
            'studentID': _studentID.text,
            'courseTaken': _courseTaken.text,
            'yearIntake': _yearIntake.text,
          });

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Student Info Saved Successfully')),
          );
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const LoginPage()),
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to save student info: $e')),
        );
      }
    }
  }
}
