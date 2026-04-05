class Course {
  final String id;
  final String title;
  final String description;
  final double price;
  final int duration;
  final double rating;
  final int enrollments;
  final String image;

  Course({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.duration,
    required this.rating,
    required this.enrollments,
    required this.image,
  });
}