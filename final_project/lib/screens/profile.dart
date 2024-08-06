import 'package:final_project/screens/exam_result_page.dart';
import 'package:final_project/screens/home.dart';
import 'package:final_project/screens/subject_taken.dart';
import 'package:flutter/material.dart';
import 'package:final_project/services/auth_services.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  int _selectedPageIndex = 3; // Set to 3 to default to ProfileInfo

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
    const ExamResultPage(), // Placeholder for ExamResultPage
    ProfileInfo(), // ProfileInfo widget
  ];

  // Define which pages should show the bottom navigation bar
  final List<bool> _showBottomNavBar = [
    false,  // Hide BottomNavigationBar for HomePage
    true,  // Show BottomNavigationBar for SubjectList
    true,  // Show BottomNavigationBar for Exam Result
    true,  // Show BottomNavigationBar for ProfileInfo
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple,
      bottomNavigationBar: _showBottomNavBar[_selectedPageIndex]
          ? BottomNavigationBar(
              currentIndex: _selectedPageIndex,
              onTap: _navigateBottomBar,
              selectedItemColor: Colors.blue, // Set selected item color
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
}

class ProfileInfo extends StatelessWidget {
  ProfileInfo({super.key});

  final AuthService _authService = AuthService();

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
            onPressed: () => _signoutuser(context), // Pass the context to _signoutuser
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
      body: Column(
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
                  image: AssetImage('assets/student_pic.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          const Text("아이유"),
          const SizedBox(height: 40),
          Card(
            color: Colors.white,
            elevation: 5,
            margin:
                const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Padding(
                padding: EdgeInsets.all(30.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Student Name: IU',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        'Student ID: 2312345',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 15),                        
                      Text(
                        'Course Taken: Diploma in Computer Science',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),  
                      SizedBox(height: 20),                        
                      Text(
                        'Year Intake: 2023',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 20),                        
                      Text(
                        'Current CGPA: 3.9',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ]
                  )
            )
          )
        ],
      )
    );
  }
}
