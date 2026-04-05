import 'package:flutter/foundation.dart' show kIsWeb;
import '../models/course.dart';
import '../data/mock_courses.dart';

// Conditional import — only loads http on non-web platforms
import 'api_service_io.dart' if (dart.library.html) 'api_service_web.dart';

class ApiService {
  static Future<List<Course>> fetchCourses() async {
    if (kIsWeb) {
      // Skip HTTP on web to avoid CORS issues — use mock data directly
      await Future.delayed(const Duration(milliseconds: 800)); // simulate load
      return mockCourses;
    }
    return fetchCoursesFromNetwork();
  }
}
