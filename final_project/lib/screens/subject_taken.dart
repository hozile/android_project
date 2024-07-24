import 'package:flutter/material.dart';
import 'package:final_project/screens/home.dart';
import 'package:final_project/services/auth_services.dart';

class SubjectTakenPage extends StatelessWidget {
  SubjectTakenPage({super.key});

  // Initialize AuthService instance
  final AuthService _authService = AuthService();

  void _signoutuser(BuildContext context) {
    _authService.signOutUser(context);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: const Color.fromARGB(255, 254, 236, 164),
        appBar: AppBar(
          title: const Text(
            "Subject Taken",
            style: TextStyle(
              fontSize: 25,
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: const Color.fromARGB(246, 255, 211, 80),
        ),
        body: Column(
          children: [
            Expanded(
              child: ListView(
                children: const [
                  CustomCard(
                    image: 'assets/neuc_logo.png',
                    title: 'Introduction of Forensic and Techniques',
                    lecturer: 'Alex Law Teng Yi',
                    backgroundColor: Colors.yellow,
                  ),
                  CustomCard(
                    image: 'assets/neuc_logo.png',
                    title: 'Introduction To Information Technology',
                    lecturer: 'Alex Law Teng Yi',
                    backgroundColor: Colors.pink,
                  ),
                  CustomCard(
                    image: 'assets/neuc_logo.png',
                    title: 'Introduction To Android Programming',
                    lecturer: 'Mr Zulhilmi',
                    backgroundColor: Colors.blue,
                  ),
                  CustomCard(
                    image: 'assets/neuc_logo.png',
                    title: 'Introduction To Operating System',
                    lecturer: 'Mr Lee Jia Khang',
                    backgroundColor: Colors.orange,
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Navigate to HomePage
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HomePage()),
                    );
                  },
                  child: const Text('Home'),
                ),
                ElevatedButton(
                onPressed: () {
                  _signoutuser(context);
                },
                  child: const Text('Logout'),
                ),
              ],
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

class CustomCard extends StatelessWidget {
  final String image;
  final String title;
  final String lecturer;
  final Color backgroundColor;

  const CustomCard({
    super.key,
    required this.image,
    required this.title,
    required this.lecturer,
    required this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      child: InkWell(
        onTap: () {
          // Handle card tap
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(image),
            Container(
              color: backgroundColor,
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    'Lecturer: $lecturer',
                    style: const TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
