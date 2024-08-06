import 'package:final_project/screens/loginpage.dart';
import 'package:final_project/screens/registerpage.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class StudentInfoRegistrationPage extends StatelessWidget {
  StudentInfoRegistrationPage({super.key});
  final TextEditingController _studentFirstname = TextEditingController();
  final TextEditingController _studentID = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              height: 110.0,
              width: 120.0,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/neuc_logo.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          const Align(
            alignment: Alignment(0.0, -0.6),
            child: Text("Student Register",
              style: TextStyle(
                fontSize: 35,
                wordSpacing: 4,
                letterSpacing: 3,
                color: Colors.black,
              )
            )
          ),
          const SizedBox(height: 20),
                    Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  controller: _studentFirstname,
                  decoration: const InputDecoration(
                    labelText: 'Student Name',
                    prefixIcon: Icon(Icons.email),
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
                    labelText: 'Password',
                    prefixIcon: Icon(Icons.lock),
                    fillColor: Colors.white,
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                  ),
                  obscureText: true,
                ),
                const SizedBox(height: 30),
                InkWell(
                  onTap: () {
                    // Navigate to RegisterPage
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const RegisterPage()),
                    );
                  },
                  child: RichText(
                    text: TextSpan(
                      children: [
                        const TextSpan(
                          text: "Already have an account? ",
                          style: TextStyle(fontSize: 16, color: Colors.black),
                        ),
                        TextSpan(
                          text: 'Login here',
                          style: const TextStyle(
                              fontSize: 16,
                              color: Colors.blue,
                              decoration: TextDecoration.underline),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const LoginPage()),
                              );
                            },
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                SizedBox(
                  width: 150,
                  child: ElevatedButton(
                    onPressed: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const RegisterPage()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                    ),
                    child: const Text(
                      'Continue Registration',
                      style: TextStyle(fontSize: 15, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      )
    );
  }
}