import 'package:flutter/material.dart';
import '../../data/mock_courses.dart';
import '../../widgets/course_card.dart';
import 'course_detail_screen.dart';
import '../../services/api_service.dart';
class CoursesScreen extends StatefulWidget {
  @override
  _CoursesScreenState createState() => _CoursesScreenState();
}

class _CoursesScreenState extends State<CoursesScreen> {
  String search = "";

  @override
  Widget build(BuildContext context) {
    final filtered = courses
        .where((c) =>
            c.title.toLowerCase().contains(search.toLowerCase()))
        .toList();

    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          SizedBox(height: 50),

          Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              "Explore Courses 🚀",
              style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          ),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: TextField(
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: "Search...",
                hintStyle: TextStyle(color: Colors.white54),
                filled: true,
                fillColor: Colors.white10,
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
              onChanged: (val) => setState(() => search = val),
            ),
          ),
FutureBuilder(
  future: ApiService.fetchCourses(),
  builder: (context, snapshot) {
    if (!snapshot.hasData) {
      return Center(child: CircularProgressIndicator());
    }

    final courses = snapshot.data!;

    return ListView.builder(
      itemCount: courses.length,
      itemBuilder: (_, i) {
        final course = courses[i];

        return CourseCard(
          course: course,
          onTap: () {},
        );
      },
    );
  },
),
          Expanded(
            child: ListView.builder(
              itemCount: filtered.length,
              itemBuilder: (_, i) {
                final course = filtered[i];

                return CourseCard(
                  course: course,
                  onTap: () {
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (_, __, ___) =>
                            CourseDetailScreen(course: course),
                        transitionsBuilder: (_, anim, __, child) {
                          return FadeTransition(
                            opacity: anim,
                            child: child,
                          );
                        },
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}