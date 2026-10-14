import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import 'admin_categories.dart';
import 'admin_reports.dart';
import 'admin_settings.dart';
import 'admin_users.dart';

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({super.key});

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  int selectedIndex = 0;

  // Custom purple light color accent
  static const Color purpleLight = Color(0xFFB77AFF);

  final List<Map<String, dynamic>> menuItems = [
    {
      'title': 'Dashboard',
      'icon': Icons.dashboard_outlined,
    },
    {
      'title': 'Users',
      'icon': Icons.people_outline_rounded,
    },
    {
      'title': 'Fandoms',
      'icon': Icons.auto_awesome_outlined,
    },
    {
      'title': 'Events',
      'icon': Icons.event_outlined,
    },
    {
      'title': 'Merchandise',
      'icon': Icons.shopping_bag_outlined,
    },
    {
      'title': 'Categories',
      'icon': Icons.category_outlined,
    },
    {
      'title': 'Settings',
      'icon': Icons.settings_outlined,
    },
    {
      'title': 'Reports',
      'icon': Icons.analytics_outlined,
    },
  ];

  final List<Map<String, String>> recentActivities = [
    {
      'name': 'New user registered',
      'time': '2 minutes ago',
      'icon': 'person',
    },
    {
      'name': 'New fandom created',
      'time': '15 minutes ago',
      'icon': 'fandom',
    },
    {
      'name': 'New event added',
      'time': '32 minutes ago',
      'icon': 'event',
    },
    {
      'name': 'Merchandise updated',
      'time': '1 hour ago',
      'icon': 'shop',
    },
  ];

  final List<Map<String, String>> popularFandoms = [
    {
      'title': 'Movies',
      'fans': '24.8K Fans',
    },
    {
      'title': 'Music',
      'fans': '32.4K Fans',
    },
    {
      'title': 'Anime',
      'fans': '18.6K Fans',
    },
    {
      'title': 'Gaming',
      'fans': '21.9K Fans',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      drawer: _mobileDrawer(),
      body: Row(
        children: [
          if (MediaQuery.of(context).size.width >= 900)
            _desktopSidebar(),

          Expanded(
            child: SafeArea(
              child: Column(
                children: [
                  _topBar(),

                  Expanded(
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.fromLTRB(
                        20,
                        10,
                        20,
                        30,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _welcomeSection(),

                          const SizedBox(height: 25),

                          _statistics(),

                          const SizedBox(height: 28),

                          _mainDashboardContent(),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // DESKTOP SIDEBAR
  // ============================================================

  Widget _desktopSidebar() {
    return Container(
      width: 245,
      decoration: BoxDecoration(
        color: AppColors.cardBg,
        border: Border(
          right: BorderSide(
            color: AppColors.primary.withValues(alpha: 0.25),
          ),
        ),
      ),
      child: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 20),

            Image.asset(
              'assets/images/fandom_logo_clean.png',
              width: 145,
              height: 75,
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) {
                return const Text(
                  'FANDOM',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                );
              },
            ),

            const SizedBox(height: 15),

            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              height: 1,
              color: AppColors.primary.withValues(alpha: 0.20),
            ),

            const SizedBox(height: 20),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'ADMIN PANEL',
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.40),
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.5,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 12),

            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                itemCount: menuItems.length,
                itemBuilder: (context, index) {
                  return _sidebarItem(
                    icon: menuItems[index]['icon'] as IconData,
                    title: menuItems[index]['title'] as String,
                    index: index,
                  );
                },
              ),
            ),

            Container(
              margin: const EdgeInsets.all(15),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.cardBg,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(
                  color: AppColors.primary.withValues(alpha: 0.25),
                ),
              ),
              child: Row(
                children: [
                  Container(
                    height: 42,
                    width: 42,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        colors: [
                          AppColors.pink,
                          AppColors.primary,
                          AppColors.cyan,
                        ],
                      ),
                    ),
                    child: const Icon(
                      Icons.person_rounded,
                      color: Colors.white,
                    ),
                  ),

                  const SizedBox(width: 10),

                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Admin',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                          ),
                        ),
                        Text(
                          'Administrator',
                          style: TextStyle(
                            color: Colors.white.withValues(alpha: 0.45),
                            fontSize: 10,
                          ),
                        ),
                      ],
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

  // ============================================================
  // SIDEBAR ITEM
  // ============================================================

  Widget _sidebarItem({
    required IconData icon,
    required String title,
    required int index,
  }) {
    final bool selected = selectedIndex == index;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedIndex = index;
        });

        if (title == 'Settings') {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AdminSettings(),
            ),
          );
        }

        if (title == 'Reports') {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AdminReports(),
            ),
          );
        }

        if (title == 'Users') {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AdminUsers(),
            ),
          );
        }

        if (title == 'Categories') {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AdminCategories(),
            ),
          );
        }
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        margin: const EdgeInsets.only(bottom: 7),
        padding: const EdgeInsets.symmetric(
          horizontal: 14,
          vertical: 13,
        ),
        decoration: BoxDecoration(
          color: selected
              ? AppColors.primary.withValues(alpha: 0.18)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: selected
                ? AppColors.primary.withValues(alpha: 0.40)
                : Colors.transparent,
          ),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: selected
                  ? purpleLight
                  : Colors.white.withValues(alpha: 0.55),
              size: 21,
            ),

            const SizedBox(width: 13),

            Text(
              title,
              style: TextStyle(
                color: selected
                    ? Colors.white
                    : Colors.white.withValues(alpha: 0.60),
                fontSize: 13,
                fontWeight: selected
                    ? FontWeight.w700
                    : FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // MOBILE DRAWER
  // ============================================================

  Widget _mobileDrawer() {
    return Drawer(
      backgroundColor: AppColors.cardBg,
      child: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 20),

            Image.asset(
              'assets/images/fandom_logo_clean.png',
              width: 145,
              height: 75,
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) {
                return const Text(
                  'FANDOM',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                );
              },
            ),

            const SizedBox(height: 20),

            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                itemCount: menuItems.length,
                itemBuilder: (context, index) {
                  return _sidebarItem(
                    icon: menuItems[index]['icon'] as IconData,
                    title: menuItems[index]['title'] as String,
                    index: index,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // TOP BAR
  // ============================================================

  Widget _topBar() {
    return Container(
      height: 76,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: AppColors.cardBg.withValues(alpha: 0.95),
        border: Border(
          bottom: BorderSide(
            color: AppColors.primary.withValues(alpha: 0.18),
          ),
        ),
      ),
      child: Row(
        children: [
          IconButton(
            onPressed: () {
              Navigator.pushReplacementNamed(
                context,
                '/login',
              );
            },
            tooltip: 'Back to Login',
            icon: const Icon(
              Icons.arrow_back_rounded,
              color: Colors.white,
              size: 24,
            ),
          ),

          const SizedBox(width: 5),

          if (MediaQuery.of(context).size.width < 900)
            Builder(
              builder: (context) {
                return IconButton(
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                  icon: const Icon(
                    Icons.menu_rounded,
                    color: Colors.white,
                  ),
                );
              },
            ),

          if (MediaQuery.of(context).size.width < 900)
            const SizedBox(width: 5),

          const Expanded(
            child: Text(
              'Admin Dashboard',
              style: TextStyle(
                color: Colors.white,
                fontSize: 21,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),

          if (MediaQuery.of(context).size.width >= 700)
            Container(
              width: 230,
              height: 42,
              decoration: BoxDecoration(
                color: AppColors.cardBg,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  color: AppColors.primary.withValues(alpha: 0.25),
                ),
              ),
              child: TextField(
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 13,
                ),
                decoration: InputDecoration(
                  hintText: 'Search...',
                  hintStyle: TextStyle(
                    color: Colors.white.withValues(alpha: 0.35),
                  ),
                  prefixIcon: const Icon(
                    Icons.search_rounded,
                    color: purpleLight,
                    size: 20,
                  ),
                  border: InputBorder.none,
                ),
              ),
            ),

          const SizedBox(width: 12),

          _headerIcon(
            Icons.notifications_none_rounded,
          ),

          const SizedBox(width: 10),

          Container(
            height: 42,
            width: 42,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [
                  AppColors.pink,
                  AppColors.primary,
                  AppColors.cyan,
                ],
              ),
            ),
            child: const Icon(
              Icons.person_rounded,
              color: Colors.white,
              size: 21,
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // HEADER ICON
  // ============================================================

  Widget _headerIcon(IconData icon) {
    return Container(
      height: 42,
      width: 42,
      decoration: BoxDecoration(
        color: AppColors.cardBg,
        shape: BoxShape.circle,
        border: Border.all(
          color: AppColors.primary.withValues(alpha: 0.30),
        ),
      ),
      child: Icon(
        icon,
        color: Colors.white,
        size: 21,
      ),
    );
  }

  // ============================================================
  // WELCOME
  // ============================================================

  Widget _welcomeSection() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.cardBg,
            AppColors.primary.withValues(alpha: 0.3),
          ],
        ),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: AppColors.primary.withValues(alpha: 0.35),
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.14),
            blurRadius: 25,
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Welcome back, Admin 👋',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.w800,
                  ),
                ),

                const SizedBox(height: 7),

                Text(
                  'Manage your Fandom universe from one place.',
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.58),
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),

          if (MediaQuery.of(context).size.width >= 600)
            Container(
              height: 62,
              width: 62,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: const LinearGradient(
                  colors: [
                    AppColors.pink,
                    AppColors.primary,
                    AppColors.cyan,
                  ],
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withValues(alpha: 0.35),
                    blurRadius: 20,
                  ),
                ],
              ),
              child: const Icon(
                Icons.auto_awesome_rounded,
                color: Colors.white,
                size: 29,
              ),
            ),
        ],
      ),
    );
  }

  // ============================================================
  // STATISTICS
  // ============================================================

  Widget _statistics() {
    final stats = [
      {
        'title': 'Total Users',
        'value': '12.8K',
        'icon': Icons.people_outline_rounded,
      },
      {
        'title': 'Fandoms',
        'value': '248',
        'icon': Icons.auto_awesome_outlined,
      },
      {
        'title': 'Events',
        'value': '86',
        'icon': Icons.event_outlined,
      },
      {
        'title': 'Merchandise',
        'value': '164',
        'icon': Icons.shopping_bag_outlined,
      },
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        int columns = 1;

        if (constraints.maxWidth >= 1000) {
          columns = 4;
        } else if (constraints.maxWidth >= 600) {
          columns = 2;
        }

        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: stats.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: columns,
            crossAxisSpacing: 14,
            mainAxisSpacing: 14,
            childAspectRatio: columns == 1 ? 3.1 : 1.7,
          ),
          itemBuilder: (context, index) {
            return _statCard(
              title: stats[index]['title'] as String,
              value: stats[index]['value'] as String,
              icon: stats[index]['icon'] as IconData,
            );
          },
        );
      },
    );
  }

  // ============================================================
  // STAT CARD
  // ============================================================

  Widget _statCard({
    required String title,
    required String value,
    required IconData icon,
  }) {
    return Container(
      padding: const EdgeInsets.all(17),
      decoration: BoxDecoration(
        color: AppColors.cardBg,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppColors.primary.withValues(alpha: 0.22),
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.09),
            blurRadius: 18,
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            height: 50,
            width: 50,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(15),
              ),
              gradient: LinearGradient(
                colors: [
                  AppColors.pink,
                  AppColors.primary,
                  AppColors.cyan,
                ],
              ),
            ),
            child: Icon(
              icon,
              color: Colors.white,
              size: 24,
            ),
          ),

          const SizedBox(width: 13),

          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.50),
                    fontSize: 11,
                  ),
                ),

                const SizedBox(height: 4),

                Text(
                  value,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 21,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // MAIN DASHBOARD CONTENT
  // ============================================================

  Widget _mainDashboardContent() {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth >= 900) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 3,
                child: _recentActivity(),
              ),

              const SizedBox(width: 18),

              Expanded(
                flex: 2,
                child: _popularFandoms(),
              ),
            ],
          );
        }

        return Column(
          children: [
            _recentActivity(),

            const SizedBox(height: 18),

            _popularFandoms(),
          ],
        );
      },
    );
  }

  // ============================================================
  // RECENT ACTIVITY
  // ============================================================

  Widget _recentActivity() {
    return Container(
      padding: const EdgeInsets.all(19),
      decoration: BoxDecoration(
        color: AppColors.cardBg,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: AppColors.primary.withValues(alpha: 0.20),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Recent Activity',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),

              Text(
                'View all',
                style: TextStyle(
                  color: purpleLight,
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),

          const SizedBox(height: 18),

          ...recentActivities.map(
                (activity) {
              return _activityItem(
                activity['name']!,
                activity['time']!,
                activity['icon']!,
              );
            },
          ),
        ],
      ),
    );
  }

  // ============================================================
  // ACTIVITY ITEM
  // ============================================================

  Widget _activityItem(
      String title,
      String time,
      String type,
      ) {
    IconData icon = Icons.notifications_none_rounded;

    if (type == 'person') {
      icon = Icons.person_add_alt_1_outlined;
    } else if (type == 'fandom') {
      icon = Icons.auto_awesome_outlined;
    } else if (type == 'event') {
      icon = Icons.event_outlined;
    } else if (type == 'shop') {
      icon = Icons.shopping_bag_outlined;
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.cardBg.withValues(alpha: 0.55),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          Container(
            height: 42,
            width: 42,
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              icon,
              color: purpleLight,
              size: 20,
            ),
          ),

          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                const SizedBox(height: 4),

                Text(
                  time,
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.40),
                    fontSize: 10,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // POPULAR FANDOMS
  // ============================================================

  Widget _popularFandoms() {
    return Container(
      padding: const EdgeInsets.all(19),
      decoration: BoxDecoration(
        color: AppColors.cardBg,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: AppColors.primary.withValues(alpha: 0.20),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Popular Fandoms',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),

          const SizedBox(height: 18),

          ...popularFandoms.asMap().entries.map(
                (entry) {
              final index = entry.key;
              final fandom = entry.value;

              return _popularFandomItem(
                index + 1,
                fandom['title']!,
                fandom['fans']!,
              );
            },
          ),
        ],
      ),
    );
  }

// ============================================================
  // POPULAR FANDOM ITEM
  // ============================================================

  Widget _popularFandomItem(
      int number,
      String title,
      String fans,
      ) {
    IconData icon = Icons.movie_outlined;

    if (title == 'Music') {
      icon = Icons.music_note_outlined;
    } else if (title == 'Anime') {
      icon = Icons.auto_awesome_outlined;
    } else if (title == 'Gaming') {
      icon = Icons.sports_esports_outlined;
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(
        horizontal: 11,
        vertical: 12,
      ),
      decoration: BoxDecoration(
        color: AppColors.cardBg.withValues(alpha: 0.45),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          Text(
            '$number',
            style: TextStyle( // ✅ 'const' remove kar diya
              color: purpleLight,
              fontWeight: FontWeight.bold,
              fontSize: 13,
            ),
          ),

          const SizedBox(width: 11),

          Container(
            height: 40,
            width: 40,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [
                  AppColors.pink,
                  AppColors.primary,
                  AppColors.cyan,
                ],
              ),
            ),
            child: Icon(
              icon,
              color: Colors.white,
              size: 19,
            ),
          ),

          const SizedBox(width: 11),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                  ),
                ),

                const SizedBox(height: 3),

                Text(
                  fans,
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.42),
                    fontSize: 10,
                  ),
                ),
              ],
            ),
          ),

          Icon( // ✅ 'const' remove kar diya
            Icons.arrow_forward_ios_rounded,
            color: purpleLight,
            size: 13,
          ),
        ],
      ),
    );
  }
}