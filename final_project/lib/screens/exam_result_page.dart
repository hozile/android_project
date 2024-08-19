import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:final_project/services/auth_services.dart';
import 'package:final_project/screens/home.dart';
import 'package:final_project/screens/profile.dart';
import 'package:final_project/screens/subject_taken.dart';

class ExamResultPage extends StatefulWidget {
  const ExamResultPage({super.key});

  @override
  State<ExamResultPage> createState() => _ExamResultPageState();
}

class _ExamResultPageState extends State<ExamResultPage> {
  int _selectedPageIndex = 2; // Default to ExamResultPage

  void _navigateBottomBar(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  final List<Widget> _pages = [
    const HomePage(),
    SubjectList(),
    const _ResultList(),
    ProfileInfo(),
  ];

  final List<bool> _showBottomNavBar = [
    false, // Hide BottomNavigationBar for HomePage
    true, // Show BottomNavigationBar for SubjectList
    true, // Show BottomNavigationBar for Exam Result
    true, // Show BottomNavigationBar for ProfileInfo
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
}

class _ResultList extends StatefulWidget {
  const _ResultList();

  @override
  _ResultListState createState() => _ResultListState();
}

class _ResultListState extends State<_ResultList> {
  final AuthService _authService = AuthService();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  void _signoutUser(BuildContext context) {
    _authService.signOutUser(context);
  }

  Future<List<Map<String, dynamic>>> _fetchExamResults() async {
    User? user = _auth.currentUser;
    if (user == null) return [];

    String userEmail = user.email!;

    final examResultsQuery =
        FirebaseFirestore.instance.collection('exam_result').get();

    final studentCGPAQuery = FirebaseFirestore.instance
        .collection("student_CGPA")
        .doc("current_CGPA")
        .collection('students')
        .doc(userEmail)
        .get();

    final cgpaData = await studentCGPAQuery;
    final currentCgpa = cgpaData.data()?['currentCGPA'];

    final List<Map<String, dynamic>> results = [];

    try {
      final querySnapshot = await examResultsQuery;
      for (var subjectDoc in querySnapshot.docs) {
        final studentDoc = await subjectDoc.reference
            .collection('students')
            .doc(userEmail)
            .get();

        if (studentDoc.exists) {
          final data = studentDoc.data();
          final studentResult = data?['result'] ?? 'No result available';

          results.add({
            'subject': subjectDoc.id,
            'result': studentResult,
            'currentCGPA': currentCgpa,
          });
        }
      }
    } catch (e) {
      print("Error fetching exam results: $e");
    }

    return results;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50],
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () => _signoutUser(context),
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
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _fetchExamResults(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          final results = snapshot.data ?? [];
          final currentCGPA =
              results.isNotEmpty ? results.last['currentCGPA'] : 0.0;

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Expanded(
                  child: ListView(
                    children: [
                      Center(
                        child: DataTable(
                          columns: const [
                            DataColumn(
                                label: Text(
                              'Subject',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            )),
                            DataColumn(
                                label: Text(
                              'Result',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            )),
                          ],
                          rows: results.map((result) {
                            return DataRow(
                              cells: [
                                DataCell(Text(
                                  result['subject'],
                                  style: const TextStyle(
                                    fontSize: 15,
                                  )
                                  )),
                                DataCell(Text(
                                  result['result'],
                                  style: const TextStyle(
                                    fontSize: 15,
                                  )
                                  )),
                              ],
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  height: 60,
                  width: 300,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Center(
                    child: Text(
                      'Current CGPA: ${currentCGPA?.toStringAsFixed(2) ?? '0.00'}',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

}
