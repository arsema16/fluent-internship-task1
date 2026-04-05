import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/course.dart';

class ApiService {
  static Future<List<Course>> fetchCourses() async {
    final response = await http.get(Uri.parse(
        "https://mocki.io/v1/0a1b2c3d-1234-5678-9012-abcdef123456"));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      return List<Course>.from(
        data.map((item) => Course(
              id: item['id'],
              title: item['title'],
              description: item['description'],
              price: item['price'].toDouble(),
              duration: item['duration'],
              rating: item['rating'].toDouble(),
              enrollments: item['enrollments'],
              image: item['image'],
            )),
      );
    } else {
      throw Exception("Failed to load courses");
    }
  }
}