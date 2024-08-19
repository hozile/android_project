// ignore_for_file: use_build_context_synchronously

import 'package:final_project/screens/student_info_reg.dart';
import 'package:flutter/material.dart';
import 'package:final_project/screens/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:final_project/screens/loginpage.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Register Function
  Future<void> registerWithEmailPassword(BuildContext context, String email,
      String password, String confirmPassword) async {
    if (confirmPassword != password) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text(
                "Registration Failed: Confirm password must same to the password")),
      );
    } else {
      try {
        UserCredential userCredential =
            await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        // Create snackbar to show register status
        WidgetsBinding.instance.addPostFrameCallback((_) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content: Text(
                    "Register Successfully: ${userCredential.user?.email}")),
          );
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => StudentInfoRegistrationPage()),
          );
        });
        // catch if exception occurs
      } on FirebaseAuthException catch (e) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (e.code == 'weak-password') {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Weak Password')),
            );
          } else if (e.code == 'email-already-in-use') {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Email Existed!')),
            );
          }
        });
      } catch (e) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Register Failed: $e')),
          );
        });
      }
    }
  }

  Future<void> signInWithEmailPassword(
      BuildContext context, String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      // create SnackBar and direct to HomePage
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text("Login Successful: ${userCredential.user?.email}")),
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('No user found for that email.')),
        );
      } else if (e.code == 'wrong-password') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('Wrong password provided for that user.')),
        );
      } else if (e.code == 'invalid-email') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Invalid email provided.')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Login Failed: ${e.message}')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Login Failed: $e')),
      );
    }
  }

  // Logout Function
  void signOutUser(BuildContext context) {
    _auth.signOut().then((_) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Logout Successful')),
        );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LoginPage()),
        );
      });
    }).catchError((error) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Logout Failed: $error')),
        );
      });
    });
  }
}
