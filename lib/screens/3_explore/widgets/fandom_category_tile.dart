import 'package:flutter/material.dart';

class FandomCategoryTile extends StatefulWidget {
  final String title;
  final IconData icon;
  final Color categoryColor;
  final bool isSelected;
  final VoidCallback onTap;

  const FandomCategoryTile({
    super.key,
    required this.title,
    required this.icon,
    this.categoryColor = const Color(0xFFEC4899), // Neon Pink default
    this.isSelected = false,
    required this.onTap,
  });

  @override
  State<FandomCategoryTile> createState() => _FandomCategoryTileState();
}

class _FandomCategoryTileState extends State<FandomCategoryTile> {
  @override
  Widget build(BuildContext context) {
    final activeColor = widget.categoryColor;

    return GestureDetector(
      onTap: widget.onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        curve: Curves.easeInOut,
        width: 80,
        height: 92,
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 6),
        decoration: BoxDecoration(
          color: widget.isSelected
              ? activeColor.withOpacity(0.18)
              : const Color(0xFF0D0D2B).withOpacity(0.90),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: widget.isSelected
                ? activeColor
                : Colors.white.withOpacity(0.08),
            width: widget.isSelected ? 1.8 : 1.0,
          ),
          boxShadow: widget.isSelected
              ? [
            BoxShadow(
              color: activeColor.withOpacity(0.35),
              blurRadius: 12,
              spreadRadius: 1,
              offset: const Offset(0, 3),
            ),
          ]
              : [],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Icon Container with gradient background on select
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: widget.isSelected
                    ? activeColor.withOpacity(0.2)
                    : Colors.white.withOpacity(0.04),
              ),
              child: Icon(
                widget.icon,
                color: widget.isSelected
                    ? activeColor
                    : activeColor.withOpacity(0.75),
                size: 26,
              ),
            ),
            const SizedBox(height: 8),

            // Category Title Text
            Text(
              widget.title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: widget.isSelected ? Colors.white : Colors.white60,
                fontSize: 11,
                fontWeight:
                widget.isSelected ? FontWeight.bold : FontWeight.w500,
                letterSpacing: 0.3,
              ),
            ),
          ],
        ),
      ),
    );
  }
}