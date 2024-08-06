import 'package:final_project/screens/attendance.dart';
import 'package:final_project/screens/exam_result_page.dart';
import 'package:final_project/screens/profile.dart';
import 'package:flutter/material.dart';
import 'package:final_project/screens/home.dart';
import 'package:final_project/services/auth_services.dart';

class SubjectTakenPage extends StatefulWidget {
  const SubjectTakenPage({super.key});

  @override
  State<SubjectTakenPage> createState() => _BottomNavigationBar();
}

class _BottomNavigationBar extends State<SubjectTakenPage> {
  int _selectedPageIndex = 1; // Set to 1 to default to SubjectTakenPage

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
              type: BottomNavigationBarType
                  .fixed, // Ensure the background color is applied
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

class SubjectList extends StatelessWidget {
  SubjectList({super.key});
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
            onPressed: () => _signoutuser(context),
            icon: const Icon(Icons.logout),
          ),
        ],
        title: const Text(
          "SUBJECT TAKEN",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
        backgroundColor: Colors.blue,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                CustomCard(
                  image: 'assets/forensic_banner.jpg',
                  title: 'Introduction of Forensic and Techniques',
                  lecturer: 'Alex Law Teng Yi',
                  backgroundColor: Colors.yellow,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const attendance_page(
                          subject: 'Introduction of Forensic and Techniques',
                          lecturer: 'Alex Law Teng Yi',
                        ),
                      ),
                    );
                  },
                ),
                CustomCard(
                  image: 'assets/information_technology_banner.jpg',
                  title: 'Introduction of Information Technology',
                  lecturer: 'Alex Law Teng Yi',
                  backgroundColor: Colors.pink,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const attendance_page(
                          subject: 'Introduction of Information Technology',
                          lecturer: 'Alex Law Teng Yi',
                        ),
                      ),
                    );
                  },
                ),
                CustomCard(
                  image: 'assets/android_banner.jpg',
                  title: 'Introduction of Android Programming',
                  lecturer: 'Mr Zulhilmi',
                  backgroundColor: Colors.blue,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const attendance_page(
                          subject: 'Introduction of Android Programming',
                          lecturer: 'Mr Zulhilmi',
                        ),
                      ),
                    );
                  },
                ),
                CustomCard(
                  image: 'assets/operating_system_banner.jpg',
                  title: 'Introduction of Operating System',
                  lecturer: 'Mr Lee Jia Khang',
                  backgroundColor: Colors.orange,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const attendance_page(
                          subject: 'Introduction of Operating System',
                          lecturer: 'Mr Lee Jia Khang',
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


class CustomCard extends StatelessWidget {
  final String image;
  final String title;
  final String lecturer;
  final Color backgroundColor;
  final VoidCallback onTap;

  const CustomCard({
    super.key,
    required this.image,
    required this.title,
    required this.lecturer,
    required this.backgroundColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      child: InkWell(
        onTap: onTap, //handle the tap function
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(image),
            Container(
              width: 320.0,
              decoration: BoxDecoration(
                color: backgroundColor,
                borderRadius: BorderRadius.circular(10),
              ),
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
                      fontStyle: FontStyle.italic,
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

