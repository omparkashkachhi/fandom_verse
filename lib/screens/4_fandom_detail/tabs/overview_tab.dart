import 'package:flutter/material.dart';

class OverviewTab extends StatelessWidget {
  final String description;

  const OverviewTab({
    super.key,
    this.description =
    'Welcome to the ultimate universe hub! Dive deep into lore, explore character dynamics, discuss theories with millions of active fans, and test your knowledge in daily quizzes.',
  });

  // Theme Color Palette
  static const Color darkCardBg = Color(0xFF0D0D2B);
  static const Color neonPink = Color(0xFFEC4899);
  static const Color neonCyan = Color(0xFF06B6D4);
  static const Color neonPurple = Color(0xFF8B5CF6);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ================= UNIVERSE OVERVIEW =================
          const Text(
            'About the Universe 🌌',
            style: TextStyle(
              color: Colors.white,
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: darkCardBg,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: Colors.white10),
            ),
            child: Text(
              description,
              style: TextStyle(
                color: Colors.white.withOpacity(0.75),
                fontSize: 13,
                height: 1.6,
              ),
            ),
          ),

          const SizedBox(height: 22),

          // ================= STATS COUNTERS =================
          Row(
            children: [
              _buildStatCard(
                title: 'Active Fans',
                value: '1.2M+',
                icon: Icons.people_alt_rounded,
                color: neonCyan,
              ),
              const SizedBox(width: 12),
              _buildStatCard(
                title: 'User Rating',
                value: '4.9 ★',
                icon: Icons.star_rounded,
                color: const Color(0xFFF59E0B),
              ),
              const SizedBox(width: 12),
              _buildStatCard(
                title: 'Stories',
                value: '850+',
                icon: Icons.auto_stories_rounded,
                color: neonPink,
              ),
            ],
          ),

          const SizedBox(height: 24),

          // ================= POPULAR LORE TAGS =================
          const Text(
            'Trending Lore Tags',
            style: TextStyle(
              color: Colors.white,
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: const [
              _LoreTag(label: '#ShadowWarriors', color: neonCyan),
              _LoreTag(label: '#MultiverseTheory', color: neonPurple),
              _LoreTag(label: '#ForbiddenSpells', color: neonPink),
              _LoreTag(label: '#VoidRealms', color: Color(0xFF10B981)),
              _LoreTag(label: '#CharacterLore', color: neonCyan),
            ],
          ),

          const SizedBox(height: 24),

          // ================= TRENDING DISCUSSION BANNER =================
          const Text(
            'Hot Discussion 🔥',
            style: TextStyle(
              color: Colors.white,
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  neonPurple.withOpacity(0.25),
                  darkCardBg,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: neonPurple.withOpacity(0.4)),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: neonPurple.withOpacity(0.2),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.forum_rounded,
                    color: neonCyan,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Who is the ultimate dark mage?',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        '342 fans discussing right now...',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.55),
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
                ),
                const Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: Colors.white54,
                  size: 14,
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildStatCard({
    required String title,
    required String value,
    required IconData icon,
    required Color color,
  }) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 10),
        decoration: BoxDecoration(
          color: darkCardBg,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: color.withOpacity(0.25)),
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: 22),
            const SizedBox(height: 6),
            Text(
              value,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              title,
              style: TextStyle(
                color: Colors.white.withOpacity(0.5),
                fontSize: 10,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _LoreTag extends StatelessWidget {
  final String label;
  final Color color;

  const _LoreTag({required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.12),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withOpacity(0.4)),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: color,
          fontSize: 11,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}