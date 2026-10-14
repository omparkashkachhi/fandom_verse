import 'package:flutter/material.dart';
import '/../core/constants/app_colors.dart';

class TrendingCard extends StatelessWidget {
  final String title;
  final String category;
  final String imageUrl;
  final String likesCount;
  final String commentsCount;
  final VoidCallback onTap;
  final VoidCallback? BookmarkTap;
  final bool isBookmarked;

  const TrendingCard({
    super.key,
    required this.title,
    required this.category,
    required this.imageUrl,
    required this.likesCount,
    required this.commentsCount,
    required this.onTap,
    this.BookmarkTap,
    this.isBookmarked = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 240,
      margin: const EdgeInsets.only(right: 16),
      decoration: BoxDecoration(
        color: AppColors.cardBg,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.08),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.4),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            splashColor: AppColors.primary.withValues(alpha: 0.2),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top Visual Image Banner with Badges
                SizedBox(
                  height: 140,
                  width: double.infinity,
                  child: Stack(
                    children: [
                      // Background Image
                      Positioned.fill(
                        child: Image.network(
                          imageUrl,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              color: AppColors.cardBg,
                              child: const Center(
                                child: Icon(
                                  Icons.movie_filter_rounded,
                                  color: AppColors.textSecondary,
                                  size: 40,
                                ),
                              ),
                            );
                          },
                        ),
                      ),

                      // Gradient Bottom Overlay for Text Visibility
                      Positioned.fill(
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.transparent,
                                AppColors.cardBg.withValues(alpha: 0.95),
                              ],
                              stops: const [0.5, 1.0],
                            ),
                          ),
                        ),
                      ),

                      // Category Pill Badge
                      Positioned(
                        top: 12,
                        left: 12,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.primary.withValues(alpha: 0.85),
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.primary.withValues(alpha: 0.4),
                                blurRadius: 6,
                              ),
                            ],
                          ),
                          child: Text(
                            category.toUpperCase(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0.8,
                            ),
                          ),
                        ),
                      ),

                      // Bookmark Button
                      Positioned(
                        top: 8,
                        right: 8,
                        child: IconButton(
                          onPressed: BookmarkTap,
                          icon: Icon(
                            isBookmarked
                                ? Icons.bookmark_rounded
                                : Icons.bookmark_border_rounded,
                            color: isBookmarked ? AppColors.pink : Colors.white,
                            size: 22,
                          ),
                          style: IconButton.styleFrom(
                            backgroundColor:
                            Colors.black.withValues(alpha: 0.4),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // Content Details
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Card Title
                      Text(
                        title,
                        maxLines: 2,
                        overflow: TextBaseline.alphabetic != null
                            ? TextOverflow.ellipsis
                            : TextOverflow.clip,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          height: 1.25,
                        ),
                      ),

                      const SizedBox(height: 12),

                      // Engagement Stats Row
                      Row(
                        children: [
                          _buildStatItem(
                            icon: Icons.favorite_rounded,
                            color: AppColors.pink,
                            label: likesCount,
                          ),
                          const SizedBox(width: 14),
                          _buildStatItem(
                            icon: Icons.chat_bubble_rounded,
                            color: AppColors.cyan,
                            label: commentsCount,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Helper Widget for Engagement Counters
  Widget _buildStatItem({
    required IconData icon,
    required Color color,
    required String label,
  }) {
    return Row(
      children: [
        Icon(
          icon,
          size: 14,
          color: color,
        ),
        const SizedBox(width: 4),
        Text(
          label,
          style: const TextStyle(
            color: AppColors.textSecondary,
            fontSize: 11,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}