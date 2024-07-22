import 'package:flutter/material.dart';
import 'package:final_project/screens/home.dart';
import 'package:final_project/screens/login.dart';

class SubjectTakenPage extends StatelessWidget {
  const SubjectTakenPage({super.key});

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
                      MaterialPageRoute(builder: (context) => const HomePage()),
                    );
                  },
                  child: const Text('Home'),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Navigate to LoginPage
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginPage()),
                    );
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
