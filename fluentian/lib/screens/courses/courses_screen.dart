import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../models/course.dart';
import '../../services/api_service.dart';
import '../../services/recently_viewed.dart';
import '../../widgets/course_card.dart';
import '../../widgets/shimmer_card.dart';
import 'course_detail_screen.dart';

class CoursesScreen extends StatefulWidget {
  const CoursesScreen({Key? key}) : super(key: key);

  @override
  State<CoursesScreen> createState() => _CoursesScreenState();
}

class _CoursesScreenState extends State<CoursesScreen> {
  late Future<List<Course>> _coursesFuture;
  String _search = '';
  String _selectedCategory = 'All';
  String _sortBy = 'rating';

  final List<String> _categories = [
    'All', 'Mobile', 'Web', 'Design', 'Programming', 'AI', 'Backend', 'Data'
  ];

  @override
  void initState() {
    super.initState();
    _coursesFuture = ApiService.fetchCourses();
  }

  List<Course> _filter(List<Course> courses) {
    var result = courses.where((c) {
      final matchSearch = c.title.toLowerCase().contains(_search.toLowerCase()) ||
          c.description.toLowerCase().contains(_search.toLowerCase());
      final matchCat =
          _selectedCategory == 'All' || c.category == _selectedCategory;
      return matchSearch && matchCat;
    }).toList();

    switch (_sortBy) {
      case 'rating':
        result.sort((a, b) => b.rating.compareTo(a.rating));
        break;
      case 'price_low':
        result.sort((a, b) => a.price.compareTo(b.price));
        break;
      case 'price_high':
        result.sort((a, b) => b.price.compareTo(a.price));
        break;
      case 'duration':
        result.sort((a, b) => a.duration.compareTo(b.duration));
        break;
      case 'popular':
        result.sort((a, b) => b.enrollments.compareTo(a.enrollments));
        break;
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTopBar(),
            _buildSearchBar(),
            _buildCategoryFilter(),
            _buildSortRow(),
            Expanded(
              child: FutureBuilder<List<Course>>(
                future: _coursesFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return ListView.builder(
                      itemCount: 4,
                      itemBuilder: (_, __) => const ShimmerCard(),
                    );
                  }
                  if (snapshot.hasError) {
                    return _buildError();
                  }
                  final filtered = _filter(snapshot.data ?? []);
                  if (filtered.isEmpty) return _buildEmpty();
                  return ListView.builder(
                    padding: const EdgeInsets.only(bottom: 24),
                    itemCount: filtered.length,
                    itemBuilder: (_, i) {
                      final course = filtered[i];
                      return CourseCard(
                        course: course,
                        onTap: () => _goToDetail(course),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTopBar() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(Icons.arrow_back_ios_new_rounded,
                  color: AppColors.textPrimary, size: 18),
            ),
          ),
          const SizedBox(width: 14),
          const Text(
            'Explore Courses',
            style: TextStyle(
              color: AppColors.textPrimary,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      child: TextField(
        style: const TextStyle(color: AppColors.textPrimary),
        decoration: InputDecoration(
          hintText: 'Search courses...',
          prefixIcon: const Icon(Icons.search_rounded,
              color: AppColors.textMuted, size: 20),
          suffixIcon: _search.isNotEmpty
              ? GestureDetector(
                  onTap: () => setState(() => _search = ''),
                  child: const Icon(Icons.close_rounded,
                      color: AppColors.textMuted, size: 18),
                )
              : null,
        ),
        onChanged: (val) => setState(() => _search = val),
      ),
    );
  }

  Widget _buildCategoryFilter() {
    return SizedBox(
      height: 48,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
        itemCount: _categories.length,
        itemBuilder: (_, i) {
          final cat = _categories[i];
          final selected = cat == _selectedCategory;
          return GestureDetector(
            onTap: () => setState(() => _selectedCategory = cat),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              margin: const EdgeInsets.only(right: 8),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              decoration: BoxDecoration(
                gradient: selected ? AppColors.gradientPurple : null,
                color: selected ? null : AppColors.surface,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: selected
                      ? Colors.transparent
                      : AppColors.divider,
                ),
              ),
              child: Text(
                cat,
                style: TextStyle(
                  color: selected ? Colors.white : AppColors.textSecondary,
                  fontSize: 12,
                  fontWeight:
                      selected ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildSortRow() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
      child: Row(
        children: [
          const Text('Sort by:',
              style: TextStyle(color: AppColors.textMuted, fontSize: 12)),
          const SizedBox(width: 8),
          DropdownButton<String>(
            value: _sortBy,
            dropdownColor: AppColors.surface,
            underline: const SizedBox(),
            style: const TextStyle(
                color: AppColors.primaryLight,
                fontSize: 12,
                fontWeight: FontWeight.w600),
            icon: const Icon(Icons.keyboard_arrow_down_rounded,
                color: AppColors.primaryLight, size: 18),
            items: const [
              DropdownMenuItem(value: 'rating', child: Text('Top Rated')),
              DropdownMenuItem(value: 'popular', child: Text('Most Popular')),
              DropdownMenuItem(value: 'price_low', child: Text('Price: Low')),
              DropdownMenuItem(value: 'price_high', child: Text('Price: High')),
              DropdownMenuItem(value: 'duration', child: Text('Duration')),
            ],
            onChanged: (val) => setState(() => _sortBy = val!),
          ),
        ],
      ),
    );
  }

  Widget _buildError() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.wifi_off_rounded,
              color: AppColors.textMuted, size: 48),
          const SizedBox(height: 12),
          const Text('Could not load courses',
              style: TextStyle(color: AppColors.textSecondary)),
          const SizedBox(height: 16),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary),
            onPressed: () =>
                setState(() => _coursesFuture = ApiService.fetchCourses()),
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }

  Widget _buildEmpty() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.search_off_rounded,
              color: AppColors.textMuted, size: 48),
          SizedBox(height: 12),
          Text('No courses found',
              style: TextStyle(color: AppColors.textSecondary)),
        ],
      ),
    );
  }

  void _goToDetail(Course course) {
    RecentlyViewed.add(course);
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (_, __, ___) => CourseDetailScreen(course: course),
        transitionsBuilder: (_, anim, __, child) =>
            FadeTransition(opacity: anim, child: child),
        transitionDuration: const Duration(milliseconds: 300),
      ),
    );
  }
}
