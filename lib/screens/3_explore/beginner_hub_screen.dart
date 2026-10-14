import 'package:flutter/material.dart';

class BeginnerHubScreen extends StatefulWidget {
  const BeginnerHubScreen({super.key});

  @override
  State<BeginnerHubScreen> createState() => _BeginnerHubScreenState();
}

class _BeginnerHubScreenState extends State<BeginnerHubScreen> {
  // Theme Color Palette
  static const Color darkBackground = Color(0xFF05021A);
  static const Color darkCardBg = Color(0xFF0D0D2B);
  static const Color neonPink = Color(0xFFEC4899);
  static const Color neonCyan = Color(0xFF06B6D4);
  static const Color neonPurple = Color(0xFF8B5CF6);

  final List<Map<String, dynamic>> _quickGuides = const [
    {
      'title': 'How to Join Fandoms',
      'subtitle': 'Find & follow your favorite universes in seconds.',
      'description': 'Search for your favorite anime, show, or game in the Explore tab. Tap on the Fandom card and press the "Join Fandom" button to receive updates and join community chats.',
      'icon': Icons.explore_rounded,
      'color': neonPink,
    },
    {
      'title': 'Earning Fan Points',
      'subtitle': 'Take quizzes, post content & rank on the leaderboard.',
      'description': 'You earn Fan Points by playing daily quizzes, getting upvotes on posts, and participating in fandom discussions. Points elevate your profile rank globally!',
      'icon': Icons.stars_rounded,
      'color': Color(0xFFF59E0B),
    },
    {
      'title': 'Community Rules',
      'subtitle': 'Keep the multiverse safe and respectful for everyone.',
      'description': 'Respect fellow fans, avoid posting spoilers without tags, keep content hate-free, and follow category guidelines to maintain a friendly space.',
      'icon': Icons.verified_user_rounded,
      'color': neonCyan,
    },
    {
      'title': 'Creating Your First Post',
      'subtitle': 'Share theories, fan art, and reviews with peers.',
      'description': 'Click the "+" button in any fandom hub, attach images or text, select tags, and share your opinions with thousands of active fans.',
      'icon': Icons.create_rounded,
      'color': neonPurple,
    },
  ];

  final List<Map<String, String>> _faqs = const [
    {
      'question': 'What are Fan Points used for?',
      'answer': 'Fan Points elevate your profile rank on global leaderboards and unlock exclusive badges & perks in fandom communities.'
    },
    {
      'question': 'Can I create my own Fandom community?',
      'answer': 'Yes! Once you reach level 5 in the app, you can submit a request to create a custom fandom hub.'
    },
    {
      'question': 'How do I participate in Fandom Quizzes?',
      'answer': 'Navigate to the Quiz section on the bottom navigation bar, pick a category, and test your fandom knowledge.'
    },
  ];

  void _showGuideDetails(BuildContext context, Map<String, dynamic> guide) {
    showModalBottomSheet(
      context: context,
      backgroundColor: darkCardBg,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: (guide['color'] as Color).withOpacity(0.15),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Icon(guide['icon'], color: guide['color'], size: 28),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Text(
                      guide['title'],
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Text(
                guide['description'],
                style: TextStyle(
                  color: Colors.white.withOpacity(0.8),
                  fontSize: 14,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: guide['color'],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                  onPressed: () => Navigator.pop(context),
                  child: const Text(
                    'Got It!',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkBackground,
      body: Stack(
        children: [
          // Background Gradient Glow Accent 1 (Fixed BoxShadow)
          Positioned(
            top: -50,
            right: -50,
            child: Container(
              height: 200,
              width: 200,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: neonPurple.withOpacity(0.18),
                boxShadow: [
                  BoxShadow(
                    color: neonPurple.withOpacity(0.18),
                    blurRadius: 90,
                    spreadRadius: 20,
                  ),
                ],
              ),
            ),
          ),

          // Background Gradient Glow Accent 2 (Fixed BoxShadow)
          Positioned(
            bottom: 100,
            left: -60,
            child: Container(
              height: 220,
              width: 220,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: neonCyan.withOpacity(0.12),
                boxShadow: [
                  BoxShadow(
                    color: neonCyan.withOpacity(0.12),
                    blurRadius: 100,
                    spreadRadius: 20,
                  ),
                ],
              ),
            ),
          ),

          SafeArea(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ================= HEADER =================
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Container(
                          height: 42,
                          width: 42,
                          decoration: BoxDecoration(
                            color: darkCardBg,
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white12),
                          ),
                          child: const Icon(Icons.arrow_back_rounded,
                              color: Colors.white, size: 20),
                        ),
                      ),
                      const SizedBox(width: 14),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Beginner Hub 🚀',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Your guide to the FandomVerse',
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.55),
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),

                  const SizedBox(height: 24),

                  // ================= WELCOME BANNER =================
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          neonPink.withOpacity(0.85),
                          neonPurple.withOpacity(0.9),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(22),
                      boxShadow: [
                        BoxShadow(
                          color: neonPurple.withOpacity(0.3),
                          blurRadius: 18,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.2),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.auto_awesome_rounded,
                                color: Colors.white,
                                size: 24,
                              ),
                            ),
                            const SizedBox(width: 12),
                            const Text(
                              'Welcome Newbie!',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        const Text(
                          'New to FandomVerse? Explore our step-by-step guides to master fandoms, play quizzes, earn badges, and connect with fellow superfans.',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                            height: 1.5,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 28),

                  // ================= QUICK START GUIDES =================
                  const Text(
                    'Quick Start Guides',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 14),

                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: _quickGuides.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 12),
                    itemBuilder: (context, index) {
                      final item = _quickGuides[index];
                      final Color itemColor = item['color'];

                      return GestureDetector(
                        onTap: () => _showGuideDetails(context, item),
                        child: Container(
                          padding: const EdgeInsets.all(14),
                          decoration: BoxDecoration(
                            color: darkCardBg,
                            borderRadius: BorderRadius.circular(18),
                            border: Border.all(
                              color: itemColor.withOpacity(0.25),
                            ),
                          ),
                          child: Row(
                            children: [
                              Container(
                                height: 48,
                                width: 48,
                                decoration: BoxDecoration(
                                  color: itemColor.withOpacity(0.15),
                                  borderRadius: BorderRadius.circular(14),
                                ),
                                child: Icon(
                                  item['icon'],
                                  color: itemColor,
                                  size: 24,
                                ),
                              ),
                              const SizedBox(width: 14),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      item['title'],
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 3),
                                    Text(
                                      item['subtitle'],
                                      style: TextStyle(
                                        color: Colors.white.withOpacity(0.55),
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Icon(
                                Icons.chevron_right_rounded,
                                color: Colors.white.withOpacity(0.3),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),

                  const SizedBox(height: 28),

                  // ================= FAQ ACCORDION =================
                  const Text(
                    'Frequently Asked Questions',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 14),

                  ..._faqs.map((faq) => Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    decoration: BoxDecoration(
                      color: darkCardBg,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.white10),
                    ),
                    child: ExpansionTile(
                      iconColor: neonCyan,
                      collapsedIconColor: Colors.white38,
                      tilePadding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 4),
                      title: Text(
                        faq['question']!,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 16, right: 16, bottom: 16),
                          child: Text(
                            faq['answer']!,
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.6),
                              fontSize: 13,
                              height: 1.5,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )),

                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}