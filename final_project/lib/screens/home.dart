import 'package:flutter/material.dart';
import 'package:final_project/screens/login.dart';
import 'package:final_project/screens/subject_taken.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 254, 236, 164),
      appBar: AppBar(
        title: const Text(
          'Home Page',
          style: TextStyle(
            fontSize: 25,
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.bold, 

          ),
        ),
        backgroundColor: const Color.fromARGB(246, 255, 211, 80),

      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const Align(
            alignment: Alignment.topLeft,
            child: Text(
              'Today\'s Weather: Sunny🌤\nTemperature: 30°C',
              style: TextStyle(fontSize: 25),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: SizedBox(
              width: 200.0, // button width
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SubjectTakenPage()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.yellow,
                  foregroundColor: Colors.white, 
                  textStyle: const TextStyle(
                    fontSize: 22, 
                    fontWeight: FontWeight.bold, 
                  ),
                ),
                child: const Text('Subject Taken'),
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: SizedBox(
              width: 200.0, 
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const LoginPage()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red, 
                  foregroundColor: Colors.white, 
                  textStyle: const TextStyle(
                    fontSize: 22, 
                    fontWeight: FontWeight.bold, 
                  ),
                ),
                child: const Text('Exam Result'),
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: SizedBox(
              width: 200.0, // button width
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const LoginPage()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue, 
                  foregroundColor: Colors.white, 
                  textStyle: const TextStyle(
                    fontSize: 22, 
                    fontWeight: FontWeight.bold, 
                  ),
                ),
                child: const Text('Attendance'),
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: SizedBox(
              width: 200.0, // button width
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const LoginPage()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green, 
                  foregroundColor: Colors.white, 
                  textStyle: const TextStyle(
                    fontSize: 22, 
                    fontWeight: FontWeight.bold, 
                  ),
                ),
                child: const Text('Profile'),
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: SizedBox(
              width: 200.0, // button width
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const LoginPage()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey, 
                  foregroundColor: Colors.white, 
                  textStyle: const TextStyle(
                    fontSize: 22, 
                    fontWeight: FontWeight.bold, 
                  ),
                ),
                child: const Text('Logout'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
