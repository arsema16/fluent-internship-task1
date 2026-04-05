import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../models/course.dart';
import '../../services/api_service.dart';
import '../../services/recently_viewed.dart';
import '../../widgets/course_card.dart';
import '../../widgets/section_title.dart';
import '../../widgets/shimmer_card.dart';
import '../courses/course_detail_screen.dart';
import '../courses/courses_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  late Future<List<Course>> _coursesFuture;

  @override
  void initState() {
    super.initState();
    _coursesFuture = ApiService.fetchCourses();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: FutureBuilder<List<Course>>(
          future: _coursesFuture,
          builder: (context, snapshot) {
            final courses = snapshot.data ?? [];
            final isLoading =
                snapshot.connectionState == ConnectionState.waiting;
            return RefreshIndicator(
              color: AppColors.primary,
              backgroundColor: AppColors.surface,
              onRefresh: () async {
                setState(() => _coursesFuture = ApiService.fetchCourses());
              },
              child: CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(child: _buildHeader()),
                  SliverToBoxAdapter(child: _buildStatsRow()),
                  if (RecentlyViewed.courses.isNotEmpty) ...[
                    const SliverToBoxAdapter(child: SizedBox(height: 28)),
                    SliverToBoxAdapter(
                      child: SectionTitle(
                        title: 'Recently Viewed',
                        actionLabel: 'See all',
                        onAction: () => _goToCourses(),
                      ),
                    ),
                    const SliverToBoxAdapter(child: SizedBox(height: 14)),
                    SliverToBoxAdapter(
                      child: SizedBox(
                        height: 220,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: RecentlyViewed.courses.length,
                          itemBuilder: (_, i) {
                            final course = RecentlyViewed.courses[i];
                            return CourseCard(
                              course: course,
                              compact: true,
                              onTap: () => _goToDetail(course),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                  const SliverToBoxAdapter(child: SizedBox(height: 28)),
                  SliverToBoxAdapter(
                    child: SectionTitle(
                      title: 'Featured Courses',
                      actionLabel: 'See all',
                      onAction: () => _goToCourses(),
                    ),
                  ),
                  const SliverToBoxAdapter(child: SizedBox(height: 14)),
                  SliverToBoxAdapter(
                    child: SizedBox(
                      height: 220,
                      child: isLoading
                          ? ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: 3,
                              itemBuilder: (_, __) =>
                                  const ShimmerCard(compact: true),
                            )
                          : ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount:
                                  courses.length > 5 ? 5 : courses.length,
                              itemBuilder: (_, i) => CourseCard(
                                course: courses[i],
                                compact: true,
                                onTap: () => _goToDetail(courses[i]),
                              ),
                            ),
                    ),
                  ),
                  const SliverToBoxAdapter(child: SizedBox(height: 28)),
                  SliverToBoxAdapter(
                    child: SectionTitle(
                      title: 'Recommended for You',
                      actionLabel: 'See all',
                      onAction: () => _goToCourses(),
                    ),
                  ),
                  const SliverToBoxAdapter(child: SizedBox(height: 14)),
                  if (isLoading)
                    SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (_, __) => const ShimmerCard(),
                        childCount: 3,
                      ),
                    )
                  else
                    SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (_, i) {
                          final reversed = courses.reversed.toList();
                          return CourseCard(
                            course: reversed[i],
                            onTap: () => _goToDetail(reversed[i]),
                          );
                        },
                        childCount: courses.length > 4 ? 4 : courses.length,
                      ),
                    ),
                  const SliverToBoxAdapter(child: SizedBox(height: 24)),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      ShaderMask(
                        shaderCallback: (bounds) =>
                            AppColors.gradientHero.createShader(bounds),
                        child: const Text(
                          'Fluent',
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.w900,
                            color: Colors.white,
                            letterSpacing: -0.5,
                          ),
                        ),
                      ),
                      const SizedBox(width: 6),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                          color: AppColors.primary.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Text(
                          'PRO',
                          style: TextStyle(
                            color: AppColors.primaryLight,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'Good morning, Learner 👋',
                    style:
                        TextStyle(color: AppColors.textSecondary, fontSize: 14),
                  ),
                ],
              ),
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  gradient: AppColors.gradientPurple,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: const Icon(Icons.person_rounded,
                    color: Colors.white, size: 22),
              ),
            ],
          ),
          const SizedBox(height: 24),
          _buildHeroBanner(),
        ],
      ),
    );
  }

  Widget _buildHeroBanner() {
    return GestureDetector(
      onTap: _goToCourses,
      child: Container(
        height: 160,
        decoration: BoxDecoration(
          gradient: AppColors.gradientHero,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withOpacity(0.4),
              blurRadius: 24,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Stack(
          children: [
            Positioned(
              right: -20,
              top: -20,
              child: Container(
                width: 140,
                height: 140,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withOpacity(0.08),
                ),
              ),
            ),
            Positioned(
              right: 30,
              bottom: -30,
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withOpacity(0.06),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Start Learning Today',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    'Explore top courses & boost your career',
                    style: TextStyle(color: Colors.white70, fontSize: 13),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 18, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text(
                      'Browse Courses →',
                      style: TextStyle(
                        color: AppColors.primary,
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatsRow() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 0),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final itemWidth = (constraints.maxWidth - 24) / 3;
          return Row(
            children: [
              _statCard('12', 'Enrolled', AppColors.primary,
                  Icons.play_circle_rounded, itemWidth),
              const SizedBox(width: 12),
              _statCard('4', 'Completed', AppColors.accentGreen,
                  Icons.check_circle_rounded, itemWidth),
              const SizedBox(width: 12),
              _statCard('68%', 'Progress', AppColors.accentOrange,
                  Icons.trending_up_rounded, itemWidth),
            ],
          );
        },
      ),
    );
  }

  Widget _statCard(
      String value, String label, Color color, IconData icon, double width) {
    return SizedBox(
      width: width,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: color.withValues(alpha: 0.2)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: color, size: 18),
            const SizedBox(height: 8),
            Text(
              value,
              style: TextStyle(
                  color: color, fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 2),
            Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                  color: AppColors.textSecondary, fontSize: 11),
            ),
          ],
        ),
      ),
    );
  }

  void _goToCourses() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const CoursesScreen()),
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
    ).then((_) => setState(() {})); // refresh to show recently viewed
  }
}
