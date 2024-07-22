import 'package:flutter/material.dart';
import 'package:final_project/screens/home.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;
  String? _errorMessage;

  void _login() {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    // modify a network request to check username and password
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        _isLoading = false;
        // if usernameand password is correct
        if (_usernameController.text == 'user' &&
            _passwordController.text == 'password') {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const HomePage()),
          );
        } else {
          _errorMessage = 'Invalid username or password';
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 254, 236, 164),
      appBar: AppBar(
        title: const Text(
          'NEUC STUDENT APPLICATION',
          style: TextStyle(
            fontSize: 20,
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color.fromARGB(246, 255, 211, 10),
      ),
      body: Stack(
        children: [
          Container(
            height: 85.0,
            width: 370.0,
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/neuc_logo.png'),
                  fit: BoxFit.cover,
                  alignment: Alignment(-1.0, -0.8)),
            ),
          ),
          const Align(
              alignment: Alignment(0.0, -0.5),
              child: Text("I LOVE NEW ERA !",
                  style: TextStyle(
                    fontSize: 30,
                    color: Color.fromARGB(255, 255, 17, 97),
                  ))),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextField(
                  controller: _usernameController,
                  decoration: const InputDecoration(labelText: 'Username'),
                ),
                TextField(
                  controller: _passwordController,
                  decoration: const InputDecoration(labelText: 'Password'),
                  obscureText: true,
                ),
                const SizedBox(height: 15),
                if (_isLoading)
                  const CircularProgressIndicator()
                else
                  ElevatedButton(
                    onPressed: _login,
                    child: const Text(
                      'Login',
                      style: TextStyle(fontSize: 15, color: Colors.black),
                    ),
                  ),
                if (_errorMessage != null) ...[
                  const SizedBox(height: 15),
                  Text(
                    _errorMessage!,
                    style: const TextStyle(color: Colors.red),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
