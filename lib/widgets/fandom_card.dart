import 'package:flutter/material.dart';
import '../models/fandom_model.dart';

class FandomCard extends StatelessWidget {
  final Fandom fandom;
  final VoidCallback? onTap;

  const FandomCard({
    super.key,
    required this.fandom,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 150,
        margin: const EdgeInsets.only(right: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF24114D),
              Color(0xFF101936),
            ],
          ),
          border: Border.all(
            color: Colors.white12,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(18),
                  ),
                  gradient: LinearGradient(
                    colors: [
                      Color(0xFF7C3AED),
                      Color(0xFF2563EB),
                    ],
                  ),
                ),
                child: const Center(
                  child: Icon(
                    Icons.auto_awesome,
                    size: 55,
                    color: Colors.white,
                  ),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    fandom.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),

                  const SizedBox(height: 4),

                  Text(
                    fandom.category,
                    style: const TextStyle(
                      color: Color(0xFF22DDEE),
                      fontSize: 11,
                    ),
                  ),

                  const SizedBox(height: 3),

                  Text(
                    fandom.fans,
                    style: const TextStyle(
                      color: Colors.white60,
                      fontSize: 11,
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
}