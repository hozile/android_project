import 'package:final_project/services/auth_services.dart';
import 'package:flutter/material.dart';

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

  void _signoutuser(BuildContext context) {
    _authService.signOutUser(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        leading: IconButton(
            icon: const Icon(Icons.arrow_back_sharp),
            onPressed: () {
              Navigator.pop(context);
            }),
        actions: [
          IconButton(
            onPressed: () => _signoutuser(context),
            icon: const Icon(Icons.logout),
          ),
        ],
        title: Text('Attendance marked for ${widget.subject}'),
        backgroundColor: Colors.blue,
      ),
    );
  }
}
