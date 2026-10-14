import 'package:flutter/material.dart';
import '/../core/constants/app_colors.dart';

class CategoryCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final String? count;
  final VoidCallback onTap;
  final bool isSelected;
  final List<Color>? gradientColors;

  const CategoryCard({
    super.key,
    required this.title,
    required this.icon,
    this.count,
    required this.onTap,
    this.isSelected = false,
    this.gradientColors,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveGradients = gradientColors ??
        [
          AppColors.primary,
          AppColors.pink,
        ];

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(18),
        splashColor: AppColors.cyan.withValues(alpha: 0.2),
        highlightColor: Colors.transparent,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: isSelected
                ? AppColors.primary.withValues(alpha: 0.25)
                : AppColors.cardBg.withValues(alpha: 0.85),
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: isSelected
                  ? AppColors.cyan
                  : Colors.white.withValues(alpha: 0.08),
              width: isSelected ? 1.5 : 1.0,
            ),
            boxShadow: isSelected
                ? [
              BoxShadow(
                color: AppColors.cyan.withValues(alpha: 0.35),
                blurRadius: 12,
                spreadRadius: 1,
              )
            ]
                : [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.3),
                blurRadius: 8,
                offset: const Offset(0, 4),
              )
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Icon with Gradient Circle Container
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: effectiveGradients,
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: effectiveGradients.first.withValues(alpha: 0.4),
                      blurRadius: 8,
                    )
                  ],
                ),
                child: Icon(
                  icon,
                  color: Colors.white,
                  size: 18,
                ),
              ),

              const SizedBox(width: 10),

              // Title & Count
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight:
                      isSelected ? FontWeight.bold : FontWeight.w600,
                    ),
                  ),
                  if (count != null) ...[
                    const SizedBox(height: 2),
                    Text(
                      count!,
                      style: const TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 11,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}