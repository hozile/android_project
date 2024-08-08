import 'package:final_project/services/auth_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

// ignore: camel_case_types
class attendance_page extends StatefulWidget {
  final String subject;
  final String lecturer;

  const attendance_page({
    super.key,
    required this.subject,
    required this.lecturer,
  });

  @override
  State<attendance_page> createState() => _AttendanceStatusPage();
}

class _AttendanceStatusPage extends State<attendance_page> {
  final AuthService _authService = AuthService();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  bool _attendanceSigned =
      false; // State variable to track if attendance is signed

  void _signoutuser(BuildContext context) {
    _authService.signOutUser(context);
  }
  
  Future<void> _checkAttendanceStatus() async {
  User? user = _auth.currentUser;
  if (user == null) {
    return;
  }
  
  String email = user.email!;
  String subject = widget.subject;

  DocumentReference studentRef = _firestore
      .collection('subjects')
      .doc(subject)
      .collection('students')
      .doc(email);

  // Get all weeks' attendance documents for the student
  QuerySnapshot weeksSnapshot = await studentRef.collection('weeks').get();

  for (var doc in weeksSnapshot.docs) {
    Map<String, dynamic>? weekData = doc.data() as Map<String, dynamic>?;

    // Ensure the 'date' field exists and is a Timestamp
    if (weekData != null && weekData.containsKey('date')) {
      Timestamp timestamp = weekData['date'] as Timestamp;
      DateTime weekDate = timestamp.toDate();

      // If the date has passed and attendance was not marked
      if (weekDate.isBefore(DateTime.now()) && weekData['attended'] != true) {
        await doc.reference.update({'attended': false});
      }
    }
  }
}

@override
void initState() {
  super.initState();
  _checkAttendanceStatus(); // Automatically check and mark attendance status if needed
}


  Future<void> _signAttendance() async {
    User? user = _auth.currentUser;
    if (user == null) {
      return;
    }
    String email = user.email!;
    String subject = widget.subject;

    DocumentReference studentRef = _firestore
        .collection('subjects')
        .doc(subject)
        .collection('students')
        .doc(email);

    DocumentReference attendanceCountRef =
        studentRef.collection('weeks').doc('attendanceCount');
    DateTime now = DateTime.now();
    DateTime today =
        DateTime(now.year, now.month, now.day); // Only keep the date

    await _firestore.runTransaction((transaction) async {
      DocumentSnapshot snapshot = await transaction.get(attendanceCountRef);

      int newWeekId = 1;
      DateTime lastSignedDate =
          today.subtract(const Duration(days: 8)); // Default to a past date

      if (snapshot.exists) {
        Map<String, dynamic>? data = snapshot.data() as Map<String, dynamic>?;
        newWeekId = (data?['currentWeekId'] ?? 0) + 1;
        lastSignedDate = (data?['lastSignedDate'] as Timestamp).toDate();
      }

      if (today.isBefore(lastSignedDate.add(const Duration(days: 7)))) {
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('You can only sign attendance once a week.'),
            duration: Duration(seconds: 1),
          ),
        );
        return;
      }

      String weekId = 'Week$newWeekId';
      DocumentReference weekRef = studentRef.collection('weeks').doc(weekId);

      transaction.set(attendanceCountRef, {
        'currentWeekId': newWeekId,
        'lastSignedDate': Timestamp.fromDate(today) // Store only the date
      });

      transaction.set(weekRef, {
        'week': weekId,
        'date': Timestamp.fromDate(today), // Store only the date
        'attended': true,
        'lecturer': widget.lecturer,
      });

      setState(() {
        _attendanceSigned = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    User? user = _auth.currentUser;

    if (user == null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('ATTENDANCE'),
          backgroundColor: Colors.blue,
        ),
        body: const Center(
          child: Text('User not authenticated.'),
        ),
      );
    }

    String email = user.email!;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_sharp),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            onPressed: () => _signoutuser(context),
            icon: const Icon(Icons.logout),
          ),
        ],
        title: const Text('ATTENDANCE'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Align(
          alignment: Alignment.topCenter,
          child: Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(8.0),
              border: Border.all(color: Colors.blue),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Attendance marked for ${widget.subject}',
                  style: const TextStyle(
                      fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 5),
                Text(
                  'Lecturer: ${widget.lecturer}',
                  style: const TextStyle(
                      fontSize: 16, fontStyle: FontStyle.italic),
                ),
                const SizedBox(height: 20),
                StreamBuilder<QuerySnapshot>(
                  stream: _firestore
                      .collection('subjects')
                      .doc(widget.subject)
                      .collection('students')
                      .doc(email)
                      .collection('weeks')
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const CircularProgressIndicator();
                    }
                    var weeks = snapshot.data!.docs;
                    return SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: DataTable(
                        columns: const [
                          DataColumn(label: Text('Week Count')),
                          DataColumn(label: Text('Date')),
                          DataColumn(label: Text('Attended')),
                        ],
                        rows: weeks.map((week) {
                          var weekData =
                              week.data() as Map<String, dynamic>? ?? {};
                          String weekCount = weekData['week'] ?? 'N/A';
                          Timestamp? timestamp = weekData['date'] as Timestamp?;
                          String date = timestamp != null
                              ? DateFormat('yyyy-MM-dd')
                                  .format(timestamp.toDate())
                              : 'N/A';
                          bool attended = weekData['attended'] != null &&
                              weekData['attended'];

                          return DataRow(
                            cells: [
                              DataCell(Text(weekCount)),
                              DataCell(Text(date)),
                              DataCell(Text(attended ? 'Y' : 'N')),
                            ],
                          );
                        }).toList(),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 20),
                _attendanceSigned
                    ? const Text(
                        'ATTENDANCE HAS SIGNED',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.green),
                      )
                    : ElevatedButton(
                        onPressed: _signAttendance,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blueAccent,
                        ),
                        child: const Text(
                          'Sign Attendance',
                          style: TextStyle(fontSize: 15, color: Colors.white),
                        ),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
