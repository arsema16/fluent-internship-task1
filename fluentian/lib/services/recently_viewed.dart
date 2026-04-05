import '../models/course.dart';

class RecentlyViewed {
  static final List<Course> _courses = [];

  static List<Course> get courses => List.unmodifiable(_courses);

  static void add(Course course) {
    _courses.removeWhere((c) => c.id == course.id);
    _courses.insert(0, course);
    if (_courses.length > 5) _courses.removeLast();
  }
}
