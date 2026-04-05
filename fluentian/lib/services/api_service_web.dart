import '../models/course.dart';
import '../data/mock_courses.dart';

Future<List<Course>> fetchCoursesFromNetwork() async {
  await Future.delayed(const Duration(milliseconds: 800));
  return mockCourses;
}
