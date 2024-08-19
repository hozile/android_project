import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:final_project/screens/home.dart';
import 'package:final_project/screens/exam_result_page.dart';
import 'package:final_project/screens/subject_taken.dart';
import 'package:final_project/services/auth_services.dart';
import 'package:flutter/painting.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  int _selectedPageIndex = 3; // Set to 3 to default to ProfileInfo
  Map<String, dynamic>? studentData;

  @override
  void initState() {
    super.initState();
    fetchStudentInfo().then((data) {
      setState(() {
        studentData = data as Map<String, dynamic>?;
      });
    });
  }

  void _navigateBottomBar(int index) {
    if (index == 2) {
      // Navigate to ExamResultPage
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const ExamResultPage()),
      );
    } else {
      setState(() {
        _selectedPageIndex = index;
      });
    }
  }

  final List<Widget> _pages = [
    const HomePage(),
    SubjectList(),
    const ExamResultPage(),
    ProfileInfo(),
  ];

  final List<bool> _showBottomNavBar = [
    false,
    true,
    true,
    true,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple,
      bottomNavigationBar: _showBottomNavBar[_selectedPageIndex]
          ? BottomNavigationBar(
              currentIndex: _selectedPageIndex,
              onTap: _navigateBottomBar,
              selectedItemColor: Colors.blue,
              unselectedItemColor: Colors.grey,
              type: BottomNavigationBarType.fixed,
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: "Home",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.subject),
                  label: "Subject Taken",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.percent_rounded),
                  label: "Exam Result",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person),
                  label: "Profile",
                ),
              ],
            )
          : null,
      body: _pages[_selectedPageIndex],
    );
  }

  Future<List<Map<String, dynamic>>?> fetchStudentInfo() async {
    try {
      final User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        // Fetch student information
        final studentInfoSnapshot = await FirebaseFirestore.instance
            .collection('users')
            .doc(user.email)
            .get();

        final studentCGPAQuery = FirebaseFirestore.instance
            .collection("student_CGPA")
            .doc("current_CGPA")
            .collection('students')
            .doc(user.email)
            .get();

        final cgpaData = await studentCGPAQuery;
        final currentCgpa = cgpaData.data()?['currentCGPA'];
        final List<Map<String, dynamic>> results = [];

        if (studentInfoSnapshot.exists) {
          final studentInfo = studentInfoSnapshot.data();

          results.add({
            'studentName': studentInfo?['studentName'],
            'studentID': studentInfo?['studentID'],
            'courseTaken': studentInfo?['courseTaken'],
            'yearIntake': studentInfo?['yearIntake'],
            'currentCGPA': currentCgpa,
          });
          // Combine the student info with the CGPA
          return results;
        }
      }
    } catch (e) {
      print('Failed to fetch student info: $e');
    }

    return null;
  }
}

class ProfileInfo extends StatelessWidget {
  ProfileInfo({super.key});

  final AuthService _authService = AuthService();

  Future<Map<String, dynamic>?> fetchStudentInfo() async {
    try {
      final User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        // Fetch student information
        final studentInfoSnapshot = await FirebaseFirestore.instance
            .collection('users')
            .doc(user.email)
            .get();

        final studentCGPAQuery = FirebaseFirestore.instance
            .collection("student_CGPA")
            .doc("current_CGPA")
            .collection('students')
            .doc(user.email)
            .get();

        final cgpaData = await studentCGPAQuery;
        final currentCgpa = cgpaData.data()?['currentCGPA'];

        if (studentInfoSnapshot.exists) {
          final studentInfo = studentInfoSnapshot.data();

          // Combine the student info with the CGPA
          return {
            'studentName': studentInfo?['studentName'],
            'studentID': studentInfo?['studentID'],
            'courseTaken': studentInfo?['courseTaken'],
            'yearIntake': studentInfo?['yearIntake'],
            'currentCGPA': currentCgpa,
          };
        }
      }
    } catch (e) {
      print('Failed to fetch student info: $e');
    }

    return null;
  }

  void _signoutuser(BuildContext context) {
    _authService.signOutUser(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50],
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () => _signoutuser(context),
            icon: const Icon(Icons.logout),
          ),
        ],
        title: const Text(
          'PROFILE PAGE',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
        backgroundColor: Colors.blue,
      ),
      body: FutureBuilder<Map<String, dynamic>?>(
        future: fetchStudentInfo(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('An error occurred!'));
          } else if (!snapshot.hasData || snapshot.data == null) {
            return const Center(child: Text('No data available.'));
          }

          final studentData = snapshot.data!;
          return Column(
            children: [
              const SizedBox(height: 30),
              Align(
                alignment: Alignment.center,
                child: Container(
                  height: 120.0,
                  width: 120.0,
                  decoration: BoxDecoration(
                    color: Colors.amber,
                    border: Border.all(color: Colors.black, width: 1.8),
                    borderRadius: BorderRadius.circular(60),
                    image: const DecorationImage(
                      image: NetworkImage(
                          'https://firebasestorage.googleapis.com/v0/b/final-project-19699.appspot.com/o/assets%2Fstudent_pic.jpg?alt=media&token=b00be428-be6e-478c-aaa1-13e5cb35638a'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 50),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  padding: const EdgeInsets.all(
                      10), // Optional: Add padding if needed
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(width: 2.0),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment
                        .start, // Aligns text to the start (left)
                    children: [
                      Text(
                        'Student Name: ${studentData['studentName']}',
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 25,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        'Student ID: ${studentData['studentID']}',
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 25,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        'Course Taken: ${studentData['courseTaken']}',
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 25,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        'Year Intake: ${studentData['yearIntake']}',
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 25,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        'Current CGPA: ${studentData['currentCGPA'].toStringAsFixed(2) ?? '0.00'}',
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 25,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
