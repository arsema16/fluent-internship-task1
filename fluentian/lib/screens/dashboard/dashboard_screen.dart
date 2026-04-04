import 'package:flutter/material.dart';
import '../../data/mock_courses.dart';
import '../../widgets/course_card.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FB),
      body: SafeArea(
        child: SingleChildScrollView( // ✅ prevents overflow
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),

                const Text(
                  "Fluent",
                  style: TextStyle(
                      fontSize: 28, fontWeight: FontWeight.bold),
                ),

                const SizedBox(height: 5),

                const Text(
                  "Upgrade your skills 🚀",
                  style: TextStyle(color: Colors.grey),
                ),

                const SizedBox(height: 25),

                // Search
                Container(
                  height: 50,
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: const Row(
                    children: [
                      Icon(Icons.search, color: Colors.grey),
                      SizedBox(width: 10),
                      Text("Search courses...",
                          style: TextStyle(color: Colors.grey)),
                    ],
                  ),
                ),

                const SizedBox(height: 25),

                const Text(
                  "Popular Courses",
                  style: TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),

                const SizedBox(height: 15),

                // ✅ FIXED HEIGHT (NO OVERFLOW)
                SizedBox(
                  height: 230,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: courses.length,
                    itemBuilder: (context, index) {
                      return CourseCard(course: courses[index]);
                    },
                  ),
                ),

                const SizedBox(height: 30),

                SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/courses');
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    child: const Text("Browse All Courses"),
                  ),
                ),

                const SizedBox(height: 20), // ✅ extra spacing
              ],
            ),
          ),
        ),
      ),
    );
  }
}