import 'dart:convert';
import 'package:http/http.dart' as http;

class WeatherService {
  final String apikey = 'e1f10a1e78da46f5b10a1e78da96f525'; 
  final String stationId = 'IKAJAN4'; //IKUALA6 - Kuala Lumpur INEGER3 - Negeri Sembilan ISEMEN3 - Semenyih 
  final String apiUrl = 'https://api.weather.com/v2/pws/observations/current';

  double fahrenheitToCelsius(int fahrenheit) {
    return (fahrenheit - 32) * 5 / 9;
  }

  Future<Map<String, dynamic>> fetchWeatherInfo() async {
    final response = await http.get(
      Uri.parse(
          '$apiUrl?apiKey=$apikey&units=e&stationId=$stationId&format=json'),
    );

    if (response.statusCode == 200) {
      print(response.body);
      final data = jsonDecode(response.body);
      
      int fahrenheit = data['observations'][0]['imperial']['temp'];
      double celsius = fahrenheitToCelsius(fahrenheit);
      
      data['observations'][0]['imperial']['tempCelsius'] = celsius;

      return data;
    } else {
      throw Exception('Failed to fetch weather info: ${response.statusCode}');
    }
  }
}
