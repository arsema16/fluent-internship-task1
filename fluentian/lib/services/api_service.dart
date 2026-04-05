import 'package:flutter/foundation.dart' show kIsWeb;
import '../models/course.dart';
import '../data/mock_courses.dart';

import 'api_service_io.dart' if (dart.library.html) 'api_service_web.dart';

class ApiService {
  static Future<List<Course>> fetchCourses() async {
    if (kIsWeb) {
      await Future.delayed(const Duration(milliseconds: 800));
      return mockCourses;
    }
    return fetchCoursesFromNetwork();
  }
}
