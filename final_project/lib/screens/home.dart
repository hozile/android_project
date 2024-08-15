import 'package:final_project/screens/exam_result_page.dart';
import 'package:final_project/screens/profile.dart';
import 'package:final_project/screens/subject_taken.dart';
import 'package:final_project/services/weather_service.dart';
import 'package:flutter/material.dart';
import 'package:final_project/services/auth_services.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Initialize AuthService instance
  final AuthService _authService = AuthService();
  late Future<Map<String, dynamic>> _weatherData;

  void _signoutuser(BuildContext context) {
    _authService.signOutUser(context);
  }

  @override
  void initState() {
    super.initState();
    _weatherData = WeatherService().fetchWeatherInfo(); 
  }

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
        title: const Text(
          'HOME PAGE',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
        backgroundColor: Colors.blue,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          FutureBuilder<Map<String, dynamic>>(
            future: _weatherData,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Center(child: Text('No weather data available'));
              } else {
                final weatherData = snapshot.data!;
                final tempCelsius =
                    weatherData['observations'][0]['imperial']['tempCelsius'];

                return Column(
                  children: [
                    Card(
                      color: Colors.white,
                      elevation: 5,
                      margin: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 20),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Today\'s Weather Information',
                              style: TextStyle(
                                color: Colors.blue,
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              '(Info updated at ${weatherData['observations'][0]['obsTimeLocal']})\n-------------------------------------------------------------------',
                              style: const TextStyle(
                                fontSize: 15,
                              ),
                            ),
                            const SizedBox(height: 10),
                            // Location with Icon
                            Row(
                              children: [
                                const Icon(Icons.location_on,
                                    color: Colors.orange, size: 24),
                                const SizedBox(width: 8),
                                Text(
                                  'Location: ${weatherData['observations'][0]['neighborhood']}',
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            // Temperature and Humidity with Icons
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Row(
                                    children: [
                                      const Icon(Icons.thermostat,
                                          color: Colors.red, size: 24),
                                      const SizedBox(width: 8),
                                      Text(
                                        'Temperature: \n${tempCelsius.toStringAsFixed(1)} °C',
                                        style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Row(
                                    children: [
                                      const Icon(Icons.water_drop,
                                          color: Colors.blue, size: 24),
                                      const SizedBox(width: 8),
                                      Text(
                                        'Humidity: \n${weatherData['observations'][0]['humidity']}%',
                                        style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Center(
                              child: SizedBox(
                                width: 100,
                                child: ElevatedButton(onPressed: (){
                                    setState(() {
                                      _weatherData = WeatherService().fetchWeatherInfo();
                                    });
                                    },
                                    child: const Text("Refresh")
                                    ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              }
            },
          ),
          Align(
            alignment: Alignment.center,
            child: SizedBox(
              width: 325.0, // button width
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SubjectTakenPage()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  textStyle: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                child: const Text('Subject Taken'),
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: SizedBox(
              width: 325.0,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ExamResultPage()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  textStyle: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                child: const Text('Exam Result'),
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: SizedBox(
              width: 325.0, // button width
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const ProfilePage()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  textStyle: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                child: const Text('Profile'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
