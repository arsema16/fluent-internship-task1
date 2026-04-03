import 'package:fluentian/models/course.dart';
import 'package:flutter/material.dart';
import 'screens/dashboard/dashboard_screen.dart';
import 'screens/courses/courses_screen.dart';
import 'screens/courses/course_detail_screen.dart';
import 'models/course_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Fluent',
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: '/',
      routes: {
        '/': (context) => const DashboardScreen(),
        '/courses': (context) => const CoursesScreen(),
      },
      onGenerateRoute: (settings) {
        if (settings.name == '/course-detail') {
          final course = settings.arguments as Course;
          return MaterialPageRoute(
            builder: (context) => CourseDetailScreen(course: course),
          );
        }
        return null;
      },
    );
  }
}