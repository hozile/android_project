import 'package:flutter/material.dart';
import 'package:final_project/screens/authpage.dart';
import 'package:final_project/screens/home.dart';
import 'package:final_project/services/auth_services.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: SubjectTakenPage(),
    );
  }
}

class SubjectTakenPage extends StatefulWidget {
  const SubjectTakenPage({super.key});

  @override
  State<SubjectTakenPage> createState() => _SubjectTakenPageState();
}

class _SubjectTakenPageState extends State<SubjectTakenPage> {
  int _selectedPageIndex = 1; // Set to 1 to default to SubjectTakenPage

  void _navigateBottomBar(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  final List<Widget> _pages = [
    HomePage(),
    SubjectList(), // Create a separate widget for the subject list
    const AuthPage(),
  ];

  // Define which pages should show the bottom navigation bar
  final List<bool> _showBottomNavBar = [
    false, // Show BottomNavigationBar for HomePage
    true, // Hide BottomNavigationBar for SubjectList
    false, // Hide BottomNavigationBar for AuthPage
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple,
      bottomNavigationBar: _showBottomNavBar[_selectedPageIndex]
          ? BottomNavigationBar(
              currentIndex: _selectedPageIndex,
              onTap: _navigateBottomBar,
              backgroundColor: Colors.deepPurple, // Set background color
              selectedItemColor: Colors.amber, // Set selected item color
              unselectedItemColor: Colors.white,
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
                  icon: Icon(Icons.table_chart_rounded),
                  label: "Attendance",
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
      backgroundColor: const Color.fromARGB(255, 254, 236, 164),

      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () =>
                _signoutuser(context), // Pass the context to _signoutuser
            icon: const Icon(Icons.logout),
          ),
        ],
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
                  image: 'assets/NEUC_non_transparent.jpg',
                  title: 'Introduction of Forensic and Techniques',
                  lecturer: 'Alex Law Teng Yi',
                  backgroundColor: Colors.yellow,
                ),
                CustomCard(
                  image: 'assets/NEUC_non_transparent.jpg',
                  title: 'Introduction of Information Technology',
                  lecturer: 'Alex Law Teng Yi',
                  backgroundColor: Colors.pink,
                ),
                CustomCard(
                  image: 'assets/NEUC_non_transparent.jpg',
                  title: 'Introduction of Android Programming',
                  lecturer: 'Mr Zulhilmi',
                  backgroundColor: Colors.blue,
                ),
                CustomCard(
                  image: 'assets/NEUC_non_transparent.jpg',
                  title: 'Introduction of Operating System',
                  lecturer: 'Mr Lee Jia Khang',
                  backgroundColor: Colors.orange,
                ),
                CustomCard(
                  image: 'assets/NEUC_non_transparent.jpg',
                  title: 'Security in Computing',
                  lecturer: 'Cikgu Eliana',
                  backgroundColor: Colors.green,
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
              width: 320.0,
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
