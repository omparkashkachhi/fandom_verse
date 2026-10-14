import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  int selectedTab = 0;

  final List<Map<String, dynamic>> fandoms = [
    {
      'name': 'Anime',
      'fans': '18.6K',
      'icon': Icons.auto_awesome_rounded,
      'color': Color(0xFFE040FB),
    },
    {
      'name': 'Gaming',
      'fans': '21.9K',
      'icon': Icons.sports_esports_rounded,
      'color': Color(0xFF7C4DFF),
    },
    {
      'name': 'Movies',
      'fans': '24.8K',
      'icon': Icons.movie_creation_rounded,
      'color': Color(0xFFFF4081),
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF050316),
      body: Stack(
        children: [
          _backgroundGlow(),
          SafeArea(
            child: Column(
              children: [
                _topBar(),
                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.fromLTRB(20, 10, 20, 30),
                    child: Column(
                      children: [
                        _profileHeader(),
                        const SizedBox(height: 24),
                        _statsCard(),
                        const SizedBox(height: 28),
                        _tabBar(),
                        const SizedBox(height: 20),
                        _tabContent(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ------------------------------------------------------------
  // BACKGROUND
  // ------------------------------------------------------------

  Widget _backgroundGlow() {
    return Stack(
      children: [
        Positioned(
          top: -120,
          right: -100,
          child: Container(
            width: 300,
            height: 300,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: const Color(0xFFD946EF).withOpacity(0.10),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFFD946EF).withOpacity(0.18),
                  blurRadius: 130,
                  spreadRadius: 45,
                ),
              ],
            ),
          ),
        ),
        Positioned(
          top: 430,
          left: -140,
          child: Container(
            width: 280,
            height: 280,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: const Color(0xFF00BCD4).withOpacity(0.06),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF00BCD4).withOpacity(0.12),
                  blurRadius: 120,
                  spreadRadius: 45,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // ------------------------------------------------------------
  // TOP BAR
  // ------------------------------------------------------------

  Widget _topBar() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 8),
      child: Row(
        children: [
          Image.asset(
            'assets/images/fandom_logo_clean.png',
            width: 42,
            height: 42,
            fit: BoxFit.contain,
            errorBuilder: (_, __, ___) {
              return const Icon(
                Icons.auto_awesome,
                color: Color(0xFFE879F9),
                size: 30,
              );
            },
          ),

          const SizedBox(width: 10),

          const Expanded(
            child: Text(
              'MY PROFILE',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w800,
                letterSpacing: 1.5,
              ),
            ),
          ),

          _iconButton(
            Icons.settings_outlined,
                () {
              _showMessage('Settings coming soon');
            },
          ),
        ],
      ),
    );
  }

  Widget _iconButton(IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 43,
        height: 43,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.055),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: Colors.white.withOpacity(0.08),
          ),
        ),
        child: Icon(
          icon,
          color: Colors.white70,
          size: 21,
        ),
      ),
    );
  }

  // ------------------------------------------------------------
  // PROFILE HEADER
  // ------------------------------------------------------------

  Widget _profileHeader() {
    return Column(
      children: [
        Stack(
          alignment: Alignment.bottomRight,
          children: [
            Container(
              width: 112,
              height: 112,
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFFE879F9),
                    Color(0xFF7C3AED),
                    Color(0xFF06B6D4),
                  ],
                ),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFFD946EF).withOpacity(0.30),
                    blurRadius: 28,
                    spreadRadius: 3,
                  ),
                ],
              ),
              child: Container(
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFF171025),
                ),
                child: const Icon(
                  Icons.person_rounded,
                  color: Colors.white,
                  size: 54,
                ),
              ),
            ),

            GestureDetector(
              onTap: () {
                _showMessage('Edit profile coming soon');
              },
              child: Container(
                width: 34,
                height: 34,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xFFD946EF),
                      Color(0xFF7C3AED),
                    ],
                  ),
                  border: Border.all(
                    color: const Color(0xFF050316),
                    width: 3,
                  ),
                ),
                child: const Icon(
                  Icons.edit_rounded,
                  color: Colors.white,
                  size: 15,
                ),
              ),
            ),
          ],
        ),

        const SizedBox(height: 16),

        const Text(
          'Fandom Explorer',
          style: TextStyle(
            color: Colors.white,
            fontSize: 23,
            fontWeight: FontWeight.w900,
          ),
        ),

        const SizedBox(height: 5),

        Text(
          '@fandom_explorer',
          style: TextStyle(
            color: const Color(0xFFE879F9).withOpacity(0.9),
            fontSize: 13,
            fontWeight: FontWeight.w600,
          ),
        ),

        const SizedBox(height: 12),

        Text(
          'Exploring fandoms • Sharing passions •\nConnecting with amazing communities ✨',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white.withOpacity(0.48),
            fontSize: 12,
            height: 1.55,
          ),
        ),

        const SizedBox(height: 15),

        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 13,
            vertical: 7,
          ),
          decoration: BoxDecoration(
            color: const Color(0xFFD946EF).withOpacity(0.09),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: const Color(0xFFD946EF).withOpacity(0.18),
            ),
          ),
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.calendar_month_rounded,
                color: Color(0xFFE879F9),
                size: 14,
              ),
              SizedBox(width: 6),
              Text(
                'Member since 2026',
                style: TextStyle(
                  color: Colors.white60,
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ------------------------------------------------------------
  // STATS
  // ------------------------------------------------------------

  Widget _statsCard() {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 20,
        horizontal: 8,
      ),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.045),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: Colors.white.withOpacity(0.08),
        ),
      ),
      child: Row(
        children: [
          _statItem('24', 'Fandoms'),
          _verticalDivider(),
          _statItem('186', 'Followers'),
          _verticalDivider(),
          _statItem('72', 'Following'),
        ],
      ),
    );
  }

  Widget _statItem(String number, String label) {
    return Expanded(
      child: Column(
        children: [
          Text(
            number,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            label,
            style: const TextStyle(
              color: Colors.white38,
              fontSize: 11,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _verticalDivider() {
    return Container(
      width: 1,
      height: 35,
      color: Colors.white.withOpacity(0.08),
    );
  }

  // ------------------------------------------------------------
  // TABS
  // ------------------------------------------------------------

  Widget _tabBar() {
    final tabs = [
      'Fandoms',
      'Achievements',
      'Activity',
    ];

    return Container(
      height: 50,
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.04),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: List.generate(
          tabs.length,
              (index) {
            final selected = selectedTab == index;

            return Expanded(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    selectedTab = index;
                  });
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(13),
                    gradient: selected
                        ? const LinearGradient(
                      colors: [
                        Color(0xFF7C3AED),
                        Color(0xFFD946EF),
                      ],
                    )
                        : null,
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    tabs[index],
                    style: TextStyle(
                      color: selected
                          ? Colors.white
                          : Colors.white38,
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  // ------------------------------------------------------------
  // TAB CONTENT
  // ------------------------------------------------------------

  Widget _tabContent() {
    if (selectedTab == 1) {
      return _achievements();
    }

    if (selectedTab == 2) {
      return _activity();
    }

    return _myFandoms();
  }

  // ------------------------------------------------------------
  // MY FANDOMS
  // ------------------------------------------------------------

  Widget _myFandoms() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _contentTitle(
          'My Fandoms',
          'Communities you joined',
        ),

        const SizedBox(height: 14),

        ...fandoms.map(
              (fandom) => _fandomTile(fandom),
        ),

        const SizedBox(height: 8),

        GestureDetector(
          onTap: () {
            _showMessage('Explore fandoms coming soon');
          },
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 16),
            decoration: BoxDecoration(
              color: const Color(0xFFD946EF).withOpacity(0.06),
              borderRadius: BorderRadius.circular(17),
              border: Border.all(
                color: const Color(0xFFD946EF).withOpacity(0.15),
              ),
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.add_rounded,
                  color: Color(0xFFE879F9),
                  size: 20,
                ),
                SizedBox(width: 8),
                Text(
                  'Discover More Fandoms',
                  style: TextStyle(
                    color: Color(0xFFE879F9),
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _contentTitle(String title, String subtitle) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 19,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          subtitle,
          style: const TextStyle(
            color: Colors.white38,
            fontSize: 11,
          ),
        ),
      ],
    );
  }

  Widget _fandomTile(Map<String, dynamic> fandom) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(13),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.045),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: Colors.white.withOpacity(0.07),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: (fandom['color'] as Color).withOpacity(0.13),
            ),
            child: Icon(
              fandom['icon'] as IconData,
              color: fandom['color'] as Color,
              size: 25,
            ),
          ),

          const SizedBox(width: 13),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  fandom['name'] as String,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '${fandom['fans']} community members',
                  style: const TextStyle(
                    color: Colors.white38,
                    fontSize: 10,
                  ),
                ),
              ],
            ),
          ),

          const Icon(
            Icons.arrow_forward_ios_rounded,
            color: Colors.white24,
            size: 15,
          ),
        ],
      ),
    );
  }

  // ------------------------------------------------------------
  // ACHIEVEMENTS
  // ------------------------------------------------------------

  Widget _achievements() {
    final badges = [
      {
        'icon': Icons.local_fire_department_rounded,
        'title': 'Fandom Starter',
        'text': 'Joined your first fandom',
      },
      {
        'icon': Icons.explore_rounded,
        'title': 'Explorer',
        'text': 'Explored 10 communities',
      },
      {
        'icon': Icons.emoji_events_rounded,
        'title': 'Quiz Master',
        'text': 'Completed 5 quizzes',
      },
      {
        'icon': Icons.people_alt_rounded,
        'title': 'Community',
        'text': 'Connected with 50 fans',
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _contentTitle(
          'Achievements',
          'Your fandom journey',
        ),

        const SizedBox(height: 14),

        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: badges.length,
          gridDelegate:
          const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 1.12,
          ),
          itemBuilder: (context, index) {
            final badge = badges[index];

            return Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.045),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: Colors.white.withOpacity(0.07),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 43,
                    height: 43,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: const Color(0xFFD946EF)
                          .withOpacity(0.12),
                    ),
                    child: Icon(
                      badge['icon'] as IconData,
                      color: const Color(0xFFE879F9),
                      size: 22,
                    ),
                  ),

                  const Spacer(),

                  Text(
                    badge['title'] as String,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      fontWeight: FontWeight.w800,
                    ),
                  ),

                  const SizedBox(height: 4),

                  Text(
                    badge['text'] as String,
                    style: const TextStyle(
                      color: Colors.white38,
                      fontSize: 9,
                      height: 1.3,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }

  // ------------------------------------------------------------
  // ACTIVITY
  // ------------------------------------------------------------

  Widget _activity() {
    final activities = [
      {
        'icon': Icons.quiz_rounded,
        'title': 'Completed a Quiz',
        'subtitle': 'Anime Challenge • 850 points',
        'time': '2h ago',
      },
      {
        'icon': Icons.favorite_rounded,
        'title': 'Joined Anime Fandom',
        'subtitle': 'You are now part of the community',
        'time': 'Yesterday',
      },
      {
        'icon': Icons.emoji_events_rounded,
        'title': 'Achievement Unlocked',
        'subtitle': 'Explorer badge earned',
        'time': '2 days ago',
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _contentTitle(
          'Recent Activity',
          'Your latest fandom moments',
        ),

        const SizedBox(height: 14),

        ...activities.map(
              (item) => Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.045),
              borderRadius: BorderRadius.circular(18),
              border: Border.all(
                color: Colors.white.withOpacity(0.07),
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: 45,
                  height: 45,
                  decoration: BoxDecoration(
                    color: const Color(0xFFD946EF)
                        .withOpacity(0.10),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Icon(
                    item['icon'] as IconData,
                    color: const Color(0xFFE879F9),
                    size: 21,
                  ),
                ),

                const SizedBox(width: 13),

                Expanded(
                  child: Column(
                    crossAxisAlignment:
                    CrossAxisAlignment.start,
                    children: [
                      Text(
                        item['title'] as String,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        item['subtitle'] as String,
                        style: const TextStyle(
                          color: Colors.white38,
                          fontSize: 10,
                        ),
                      ),
                    ],
                  ),
                ),

                Text(
                  item['time'] as String,
                  style: const TextStyle(
                    color: Colors.white24,
                    fontSize: 9,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // ------------------------------------------------------------
  // SNACKBAR
  // ------------------------------------------------------------

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: const Color(0xFF211333),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
      ),
    );
  }
}