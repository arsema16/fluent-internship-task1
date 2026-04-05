class Course {
  final String id;
  final String title;
  final String description;
  final double price;
  final int duration;
  final double rating;
  final int enrollments;
  final String image;
  final String category;

  Course({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.duration,
    required this.rating,
    required this.enrollments,
    required this.image,
    this.category = 'General',
  });

  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      id: json['id'].toString(),
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      price: (json['price'] ?? 0).toDouble(),
      duration: (json['duration'] ?? 0).toInt(),
      rating: (json['rating'] ?? 0).toDouble(),
      enrollments: (json['enrollments'] ?? 0).toInt(),
      image: json['image'] ?? '',
      category: json['category'] ?? 'General',
    );
  }
}
