import 'package:flutter/material.dart';
import 'package:final_project/services/auth_services.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final AuthService _authService = AuthService();

  // initialize register and login function with authService
  // pass parameters(email and password) into the function
  Future<void> _register() async {
    await _authService.registerWithEmailPassword(
      context,
      _emailController.text,
      _passwordController.text,
    );
  }

  Future<void> _login() async {
    await _authService.signInWithEmailPassword(
      context,
      _emailController.text,
      _passwordController.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 254, 236, 164),
      appBar: AppBar(
        // disable showing leading on app bar
        automaticallyImplyLeading: false,
        // show appbar in flat
        elevation: 0,
        title: const Text(
          'NEUC STUDENT APPLICATION',
          style: TextStyle(
            fontSize: 20,
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color.fromARGB(246, 255, 211, 80),
      ),
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Column(
            children: [
              Container(
                height: 85.0,
                width: 350.0,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/neuc_logo.png'),
                    fit: BoxFit.cover,
                    alignment: Alignment(0.0, -1.0),
                  ),
                ),
              ),
            ],
          ),
          const Align(
            alignment: Alignment(0.0, -0.6),
            child: Text("❤ I LOVE NEW ERA ❤",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.purple,
                )
            )
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  controller: _emailController,
                  decoration: const InputDecoration(labelText: 'Email'),
                ),
                TextField(
                  controller: _passwordController,
                  decoration: const InputDecoration(labelText: 'Password'),
                  obscureText: true,
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _register,
                  child: const Text('Register'),
                ),
                ElevatedButton(
                  onPressed: _login,
                  child: const Text('Login'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
