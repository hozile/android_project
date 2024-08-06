import 'package:final_project/screens/profile.dart';
import 'package:final_project/screens/subject_taken.dart';
import 'package:flutter/material.dart';
import 'package:final_project/services/auth_services.dart';
import 'package:final_project/screens/home.dart';

class ExamResultPage extends StatefulWidget {
  const ExamResultPage({super.key});

  @override
  State<ExamResultPage> createState() => _ExamResultPageState();
}

class _ExamResultPageState extends State<ExamResultPage> {
  int _selectedPageIndex = 2; // Set to 2 to default to ExamResultPage

  void _navigateBottomBar(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  final List<Widget> _pages = [
    const HomePage(),
    SubjectList(),
    _ResultList(), // Create a separate widget for the result list
    ProfileInfo(),
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

class _ResultList extends StatefulWidget {
  @override
  _ResultListState createState() => _ResultListState();
}

class _ResultListState extends State<_ResultList> {
  final AuthService _authService = AuthService();

  void _signoutuser(BuildContext context) {
    _authService.signOutUser(context);
  }

  int _selectedYear = 1;
  int _selectedSemester = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50],
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () =>
                _signoutuser(context), // Pass the context to _signoutuser
            icon: const Icon(Icons.logout),
          ),
        ],
        backgroundColor: Colors.blue,
        title: const Text(
          "EXAM RESULT",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Wrap(
              spacing: 10.0, // gap between adjacent chips
              children: [
                _buildYearButton(1),
                _buildYearButton(2),
              ],
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 10.0, // gap between adjacent chips
              children: [
                _buildSemesterButton(1),
                _buildSemesterButton(2),
              ],
            ),
            const SizedBox(height: 16),
            const Divider(thickness: 2),
            const SizedBox(height: 16),
            Expanded(
              child: ListView(
                children: [
                  _buildResultRow('TCYS123',
                      'Introduction of Forensic and Techniques', 'A-'),
                  _buildResultRow('TGEN123',
                      'Introduction To Information Technology', 'A-'),
                  _buildResultRow(
                      'TGEN164', 'Introduction of Android Programming', 'A-'),
                  _buildResultRow(
                      'TMAT113', 'Introduction of Operating System', 'A-'),
                  _buildResultRow('TPRG113', 'Programming Concepts', 'A-'),
                ],
              ),
            ),
            const Divider(thickness: 2),
            const SizedBox(height: 80),
            Container(
              height: 60,
              width: 300,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Center(
                child: Text(
                  'Current GPA: 3.82 \nCumulative GPA (CGPA): 3.90',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildYearButton(int year) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor:
            _selectedYear == year ? Colors.yellow : Colors.grey[300],
      ),
      onPressed: () {
        setState(() {
          _selectedYear = year;
        });
      },
      child: Text(
        'Year $year',
        style: TextStyle(
          color: _selectedYear == year ? Colors.black : Colors.grey[800],
        ),
      ),
    );
  }

  Widget _buildSemesterButton(int semester) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: _selectedSemester == semester
            ? Colors.pinkAccent
            : Colors.grey[300],
      ),
      onPressed: () {
        setState(() {
          _selectedSemester = semester;
        });
      },
      child: Text(
        'Semester $semester',
        style: TextStyle(
          color:
              _selectedSemester == semester ? Colors.white : Colors.grey[800],
        ),
      ),
    );
  }

  Widget _buildResultRow(String code, String subject, String grade) {
    return Table(
      border: TableBorder.all(),
      columnWidths: const {
        0: FlexColumnWidth(1),
        1: FlexColumnWidth(3),
        2: FlexColumnWidth(1),
      },
      children: [
        TableRow(children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(code),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(subject),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(grade),
          ),
        ]),
      ],
    );
  }
}
