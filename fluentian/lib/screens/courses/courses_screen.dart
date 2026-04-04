import 'package:flutter/material.dart';
import '../../data/mock_courses.dart';
import '../../models/course.dart';
import '../../widgets/course_card.dart';

class CoursesScreen extends StatefulWidget {
  const CoursesScreen({super.key});

  @override
  State<CoursesScreen> createState() => _CoursesScreenState();
}

class _CoursesScreenState extends State<CoursesScreen> {
  List<Course> filteredCourses = courses;
  String selectedCategory = "All";

  void searchCourses(String query) {
    setState(() {
      filteredCourses = courses.where((course) {
        return course.title.toLowerCase().contains(query.toLowerCase());
      }).toList();
    });
  }

  void filterCategory(String category) {
    setState(() {
      selectedCategory = category;

      if (category == "All") {
        filteredCourses = courses;
      } else {
        filteredCourses = courses
            .where((course) => course.category == category)
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Courses")),
      body: Column(
        children: [
          // SEARCH
          Padding(
            padding: const EdgeInsets.all(10),
            child: TextField(
              onChanged: searchCourses,
              decoration: InputDecoration(
                hintText: "Search...",
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12)),
              ),
            ),
          ),

          // FILTER
          SizedBox(
            height: 50,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: ["All", "Development", "Design"]
                  .map((cat) => Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: ChoiceChip(
                          label: Text(cat),
                          selected: selectedCategory == cat,
                          onSelected: (_) => filterCategory(cat),
                        ),
                      ))
                  .toList(),
            ),
          ),

          const SizedBox(height: 10),

          // LIST
          Expanded(
            child: ListView.builder(
              itemCount: filteredCourses.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(10),
                  child: CourseCard(course: filteredCourses[index]),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}