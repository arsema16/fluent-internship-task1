import 'package:flutter/material.dart';
import '../../models/course.dart';

class CourseDetailScreen extends StatelessWidget {
  final Course course;

  CourseDetailScreen({required this.course});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Hero(
            tag: course.id,
            child: Image.network(
              course.image,
              height: 300,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),

          Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(course.title,
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white)),

                SizedBox(height: 10),

                Text(course.description,
                    style: TextStyle(color: Colors.white70)),

                SizedBox(height: 20),

                Text("💰 \$${course.price}",
                    style: TextStyle(color: Colors.white)),
                Text("⏱ ${course.duration} hrs",
                    style: TextStyle(color: Colors.white)),
                Text("⭐ ${course.rating}",
                    style: TextStyle(color: Colors.white)),
                Text("👥 ${course.enrollments}",
                    style: TextStyle(color: Colors.white)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}