import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/course.dart';
import '../data/mock_courses.dart';

Future<List<Course>> fetchCoursesFromNetwork() async {
  try {
    final response = await http
        .get(Uri.parse('https://jsonplaceholder.typicode.com/posts'))
        .timeout(const Duration(seconds: 5));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      final count =
          data.length < mockCourses.length ? data.length : mockCourses.length;
      return List.generate(count, (i) {
        final post = data[i];
        final mock = mockCourses[i];
        return Course(
          id: post['id'].toString(),
          title: mock.title,
          description: post['body']
              .toString()
              .replaceAll('\n', ' ')
              .replaceAll(RegExp(r'\s+'), ' '),
          price: mock.price,
          duration: mock.duration,
          rating: mock.rating,
          enrollments: mock.enrollments,
          image: mock.image,
          category: mock.category,
        );
      });
    }
  } catch (_) {
  }
  return mockCourses;
}
