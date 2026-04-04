class Course {
  final String title;
  final String description;
  final double price;
  final int duration;
  final double rating;
  final int students;
  final String image;
  final String category;

  Course({
    required this.title,
    required this.description,
    required this.price,
    required this.duration,
    required this.rating,
    required this.students,
    required this.image,
    required this.category,
  });

  // 🔄 Convert JSON → Course object
  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      title: json['title'],
      description: json['description'],
      price: json['price'].toDouble(),
      duration: json['duration'],
      rating: json['rating'].toDouble(),
      students: json['students'],
      image: json['image'],
      category: json['category'],
    );
  }

  // 🔄 Convert Course → JSON
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'price': price,
      'duration': duration,
      'rating': rating,
      'students': students,
      'image': image,
      'category': category,
    };
  }
}