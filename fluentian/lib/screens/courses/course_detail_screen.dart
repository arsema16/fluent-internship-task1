import 'package:flutter/material.dart';
import '../../models/course.dart';
import '../../core/theme/app_colors.dart';

class CourseDetailScreen extends StatelessWidget {
  final Course course;

  const CourseDetailScreen({super.key, required this.course});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 250,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [AppColors.primary, AppColors.secondary],
              ),
            ),
            child: SafeArea(
              child: Center(
                child: Text(course.title,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold)),
              ),
            ),
          ),

          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("⭐ ${course.rating} • ${course.students} students"),
                  const SizedBox(height: 10),
                  Text("\$${course.price} • ${course.duration} hours"),
                  const SizedBox(height: 20),
                  Text(course.description),

                  const Spacer(),

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {},
                      child: const Text("Enroll Now"),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}