import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../core/theme/app_colors.dart';

class ShimmerCard extends StatelessWidget {
  final bool compact;
  const ShimmerCard({Key? key, this.compact = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColors.surface,
      highlightColor: AppColors.surfaceLight,
      child: Container(
        width: compact ? 220 : double.infinity,
        height: compact ? 180 : 260,
        margin: compact
            ? const EdgeInsets.only(left: 16, right: 4, top: 4, bottom: 8)
            : const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }
}
