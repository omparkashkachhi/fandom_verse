import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../core/constants/app_colors.dart';
import 'fandom_detail_page.dart';
import 'leaderboard_page.dart';
import 'quiz_page.dart';
import '../3_explore/explore_screen.dart';
import '../5_events/event_detail_screen.dart';
import '../7_ai_helper/ai_chat_screen.dart';
import 'dashboard.dart';


class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _currentIndex = 0;

  void _onTabSelected(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      FanDashboard(onNavigateToTab: _onTabSelected),
      const ExploreScreen(),
      const QuizPage(),
      const LeaderboardPage(),
    ];

    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: pages,
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF0D0D2B),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF8B5CF6).withOpacity(0.15),
              blurRadius: 15,
              offset: const Offset(0, -4),
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: _onTabSelected,
          backgroundColor: const Color(0xFF0D0D2B),
          type: BottomNavigationBarType.fixed,
          selectedItemColor: const Color(0xFFEC4899),
          unselectedItemColor: Colors.white38,
          selectedLabelStyle:
          const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
          unselectedLabelStyle: const TextStyle(fontSize: 11),
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_max_rounded),
              activeIcon:
              Icon(Icons.home_max_rounded, color: Color(0xFFEC4899)),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.explore_outlined),
              activeIcon:
              Icon(Icons.explore_rounded, color: Color(0xFFEC4899)),
              label: 'Explore',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.quiz_outlined),
              activeIcon: Icon(Icons.quiz_rounded, color: Color(0xFFEC4899)),
              label: 'Quiz',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.emoji_events_outlined),
              activeIcon:
              Icon(Icons.emoji_events_rounded, color: Color(0xFFEC4899)),
              label: 'Leaderboard',
            ),
          ],
        ),
      ),
    );
  }
}

class FanDashboard extends StatefulWidget {
  final Function(int)? onNavigateToTab;

  const FanDashboard({super.key, this.onNavigateToTab});

  @override
  State<FanDashboard> createState() => _FanDashboardState();
}

class _FanDashboardState extends State<FanDashboard> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int _selectedCategoryIndex = -1;
  String _searchQuery = '';
  final TextEditingController _searchController = TextEditingController();

  final User? currentUser = FirebaseAuth.instance.currentUser;

  static const Color neonPink = Color(0xFFEC4899);
  static const Color neonCyan = Color(0xFF06B6D4);
  static const Color neonPurple = Color(0xFF8B5CF6);
  static const Color darkCardBg = Color(0xFF0D0D2B);

  final List<Map<String, dynamic>> categories = const [
    {'name': 'Anime', 'icon': Icons.sensor_door_rounded, 'color': Color(0xFFEC4899)},
    {'name': 'Gaming', 'icon': Icons.sports_esports_rounded, 'color': Color(0xFF3B82F6)},
    {'name': 'Comics', 'icon': Icons.menu_book_rounded, 'color': Color(0xFFF97316)},
    {'name': 'Sci-Fi', 'icon': Icons.public_rounded, 'color': Color(0xFF06B6D4)},
    {'name': 'K-Pop', 'icon': Icons.music_note_rounded, 'color': Color(0xFFA855F7)},
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _showNotificationSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: darkCardBg,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) => Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Notifications',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close, color: Colors.white54),
                )
              ],
            ),
            const SizedBox(height: 12),
            const ListTile(
              contentPadding: EdgeInsets.zero,
              leading: CircleAvatar(
                backgroundColor: Color(0xFF151542),
                child: Icon(Icons.event_available, color: neonCyan),
              ),
              title: Text('Fan Fest 2026 Tickets Live!',
                  style: TextStyle(color: Colors.white, fontSize: 14)),
              subtitle: Text('Get early bird discount tickets now.',
                  style: TextStyle(color: Colors.white54, fontSize: 12)),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );


  }
  // ==========================================

  // ==========================================
  Widget _eventFallback() {
    return Container(
      width: 105,
      height: 95,
      color: Colors.white10,
      child: const Icon(Icons.event, color: Colors.white38),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: AppColors.background,
      drawer: _buildDashboardDrawer(context),

      // ================= FLOATING ACTION BUTTON (AI HELPER) =================
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const AIChatScreen(),
            ),
          );
        },
        backgroundColor: neonCyan,
        elevation: 6,
        icon: const Icon(Icons.smart_toy_rounded, color: Colors.black),
        label: const Text(
          'Fandom AI',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 13,
          ),
        ),
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ================= HEADER SECTION =================
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      _circleIconButton(
                        icon: Icons.menu_rounded,
                        onTap: () {
                          _scaffoldKey.currentState?.openDrawer();
                        },
                      ),
                      const SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Hey, ${currentUser?.displayName ?? 'Fan'}!',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          ShaderMask(
                            shaderCallback: _buildGradientShader,
                            child: const Text(
                              'Explore Your Universe',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Stack(
                    children: [
                      _circleIconButton(
                        icon: Icons.notifications_none_rounded,
                        onTap: _showNotificationSheet,
                      ),
                      Positioned(
                        right: 8,
                        top: 8,
                        child: Container(
                          height: 9,
                          width: 9,
                          decoration: const BoxDecoration(
                            color: neonPink,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // ================= SEARCH BAR =================
              Container(
                height: 52,
                padding: const EdgeInsets.symmetric(horizontal: 14),
                decoration: BoxDecoration(
                  color: darkCardBg,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: neonCyan.withOpacity(0.2),
                  ),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.search_rounded,
                        color: AppColors.textSecondary, size: 22),
                    const SizedBox(width: 10),
                    Expanded(
                      child: TextField(
                        controller: _searchController,
                        onChanged: (val) =>
                            setState(() => _searchQuery = val),
                        style: const TextStyle(
                            color: Colors.white, fontSize: 14),
                        decoration: const InputDecoration(
                          hintText: 'Search fandoms, characters, events...',
                          hintStyle: TextStyle(
                            color: AppColors.textSecondary,
                            fontSize: 13,
                          ),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    if (_searchQuery.isNotEmpty)
                      GestureDetector(
                        onTap: () {
                          _searchController.clear();
                          setState(() => _searchQuery = '');
                        },
                        child: const Icon(Icons.clear_rounded,
                            color: AppColors.textSecondary, size: 18),
                      ),
                  ],
                ),
              ),

              const SizedBox(height: 22),

              // ================= CATEGORIES LIST =================
              SizedBox(
                height: 90,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  itemCount: categories.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 12),
                  itemBuilder: (context, index) {
                    final isSelected = _selectedCategoryIndex == index;
                    final category = categories[index];
                    final catColor = category['color'] as Color;

                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          if (_selectedCategoryIndex == index) {
                            _selectedCategoryIndex = -1;
                          } else {
                            _selectedCategoryIndex = index;
                          }
                        });
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        width: 72,
                        decoration: BoxDecoration(
                          color: isSelected
                              ? catColor.withOpacity(0.22)
                              : darkCardBg,
                          borderRadius: BorderRadius.circular(18),
                          border: Border.all(
                            color: isSelected
                                ? catColor
                                : Colors.white.withOpacity(0.08),
                            width: isSelected ? 1.5 : 1.0,
                          ),
                          boxShadow: isSelected
                              ? [
                            BoxShadow(
                              color: catColor.withOpacity(0.3),
                              blurRadius: 10,
                              spreadRadius: 1,
                            )
                          ]
                              : [],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              category['icon'] as IconData,
                              color: isSelected
                                  ? catColor
                                  : catColor.withOpacity(0.85),
                              size: 28,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              category['name'] as String,
                              style: TextStyle(
                                color: isSelected
                                    ? Colors.white
                                    : AppColors.textSecondary,
                                fontSize: 11,
                                fontWeight: isSelected
                                    ? FontWeight.bold
                                    : FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: 28),

              // ================= TRENDING NOW FIRESTORE STREAM =================
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Trending Now',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      if (widget.onNavigateToTab != null) {
                        widget.onNavigateToTab!(1);
                      } else {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const ExploreScreen(),
                          ),
                        );
                      }
                    },
                    child: const Row(
                      children: [
                        Text(
                          'See All',
                          style: TextStyle(
                            color: neonCyan,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Icon(
                          Icons.chevron_right_rounded,
                          color: neonCyan,
                          size: 16,
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance.collection('fandoms').snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    print("Total documents from Firestore: ${snapshot.data!.docs.length}");
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const SizedBox(
                      height: 185,
                      child: Center(child: CircularProgressIndicator(color: neonPink)),
                    );
                  }

                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return Container(
                      height: 120,
                      alignment: Alignment.center,
                      child: const Text(
                        'No fandoms available in Firestore.',
                        style: TextStyle(color: Colors.white54, fontSize: 13),
                      ),
                    );
                  }

                  final fandomDocs = snapshot.data!.docs.where((doc) {
                    final data = doc.data() as Map<String, dynamic>;
                    final title = (data['title'] ?? '').toString().toLowerCase();
                    final category = (data['category'] ?? '').toString();

                    final matchesSearch = title.contains(_searchQuery.toLowerCase());
                    final matchesCategory = _selectedCategoryIndex == -1 ||
                        category == categories[_selectedCategoryIndex]['name'];

                    return matchesSearch && matchesCategory;
                  }).toList();

                  if (fandomDocs.isEmpty) {
                    return Container(
                      height: 120,
                      alignment: Alignment.center,
                      child: const Text(
                        'No fandoms found matching your filter.',
                        style: TextStyle(color: Colors.white54, fontSize: 13),
                      ),
                    );
                  }

                  return SizedBox(
                    height: 185,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      physics: const BouncingScrollPhysics(),
                      itemCount: fandomDocs.length,
                      separatorBuilder: (_, __) => const SizedBox(width: 14),
                      itemBuilder: (context, index) {
                        final data = fandomDocs[index].data() as Map<String, dynamic>;
                        return _fandomTrendingCard(data);
                      },
                    ),
                  );
                },
              ),

              const SizedBox(height: 28),

              // ================= POPULAR EVENTS FIRESTORE STREAM =================
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Popular Events',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 14),

              StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance.collection('events').snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator(color: neonCyan));
                  }

                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(color: darkCardBg, borderRadius: BorderRadius.circular(16)),
                      child: const Text('No popular events live at the moment.', style: TextStyle(color: Colors.white54)),
                    );
                  }

                  final eventData = snapshot.data!.docs.first.data() as Map<String, dynamic>;

                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => EventDetailScreen(event: eventData),
                        ),
                      );
                    },
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: darkCardBg,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: neonPurple.withOpacity(0.2),
                        ),
                      ),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: (eventData['image'] ?? '').toString().startsWith('assets/')
                                ? Image.asset(
                              eventData['image'] ?? '',
                              width: 105,
                              height: 95,
                              fit: BoxFit.cover,
                              errorBuilder: (_, __, ___) => _eventFallback(),
                            )
                                : Image.network(
                              eventData['image'] ?? '',
                              width: 105,
                              height: 95,
                              fit: BoxFit.cover,
                              errorBuilder: (_, __, ___) => _eventFallback(),
                            ),
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  eventData['title'] ?? 'Event Title',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  eventData['category'] ?? 'General',
                                  style: const TextStyle(
                                    color: AppColors.textSecondary,
                                    fontSize: 11,
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  eventData['location'] ?? 'Location',
                                  style: const TextStyle(
                                    color: neonCyan,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  eventData['date'] ?? '',
                                  style: const TextStyle(
                                    color: AppColors.textSecondary,
                                    fontSize: 11,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Icon(
                            Icons.chevron_right_rounded,
                            color: AppColors.textSecondary,
                            size: 24,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),

              const SizedBox(height: 28),

              // ================= SHORTCUTS (QUIZ & LEADERBOARD) =================
              Row(
                children: [
                  Expanded(
                    child: _shortcutCard(
                      title: 'Fandom Quiz',
                      subtitle: 'Test Knowledge',
                      icon: Icons.quiz_outlined,
                      onTap: () {
                        if (widget.onNavigateToTab != null) {
                          widget.onNavigateToTab!(2);
                        } else {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const QuizPage(),
                            ),
                          );
                        }
                      },
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _shortcutCard(
                      title: 'Leaderboard',
                      subtitle: 'Top Performers',
                      icon: Icons.emoji_events_outlined,
                      onTap: () {
                        if (widget.onNavigateToTab != null) {
                          widget.onNavigateToTab!(3);
                        } else {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const LeaderboardPage(),
                            ),
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  // ================= SIDEBAR / DRAWER WITH NAVIGATION INTEGRATION =================
  Widget _buildDashboardDrawer(BuildContext context) {
    return Drawer(
      backgroundColor: darkCardBg,
      child: SafeArea(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: Colors.white.withOpacity(0.08)),
                ),
              ),
              child: Row(
                children: [
                  Container(
                    width: 52,
                    height: 52,
                    padding: const EdgeInsets.all(2),
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        colors: [neonPink, neonPurple, neonCyan],
                      ),
                    ),
                    child: CircleAvatar(
                      backgroundColor: darkCardBg,
                      backgroundImage: currentUser?.photoURL != null
                          ? NetworkImage(currentUser!.photoURL!)
                          : null,
                      child: currentUser?.photoURL == null
                          ? const Icon(Icons.person_rounded, color: Colors.white, size: 28)
                          : null,
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          currentUser?.displayName ?? 'Fandom User',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          currentUser?.email ?? 'user@fandom.com',
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.5),
                            fontSize: 12,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                children: [
                  _drawerTile(
                    title: 'Dashboard',
                    icon: Icons.dashboard_outlined,
                    onTap: () {
                      Navigator.pop(context);
                      if (widget.onNavigateToTab != null) {
                        widget.onNavigateToTab!(0);
                      }
                    },
                  ),
                  _drawerTile(
                    title: 'Fandom AI Assistant',
                    icon: Icons.smart_toy_outlined,
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const AIChatScreen(),
                        ),
                      );
                    },
                  ),
                  _drawerTile(
                    title: 'Explore Fandoms',
                    icon: Icons.explore_outlined,
                    onTap: () {
                      Navigator.pop(context);
                      if (widget.onNavigateToTab != null) {
                        widget.onNavigateToTab!(1);
                      } else {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const ExploreScreen(),
                          ),
                        );
                      }
                    },
                  ),
                  _drawerTile(
                    title: 'Fandom Quiz',
                    icon: Icons.quiz_outlined,
                    onTap: () {
                      Navigator.pop(context);
                      if (widget.onNavigateToTab != null) {
                        widget.onNavigateToTab!(2);
                      } else {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const QuizPage(),
                          ),
                        );
                      }
                    },
                  ),
                  _drawerTile(
                    title: 'Leaderboard',
                    icon: Icons.emoji_events_outlined,
                    onTap: () {
                      Navigator.pop(context);
                      if (widget.onNavigateToTab != null) {
                        widget.onNavigateToTab!(3);
                      } else {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const LeaderboardPage(),
                          ),
                        );
                      }
                    },
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    child: Divider(color: Colors.white12),
                  ),
                  _drawerTile(
                    title: 'Settings',
                    icon: Icons.settings_outlined,
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.redAccent.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: ListTile(
                  leading: const Icon(Icons.logout_rounded, color: Colors.redAccent),
                  title: const Text(
                    'Logout',
                    style: TextStyle(
                      color: Colors.redAccent,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    _showLogoutDialog(context);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _drawerTile({required String title, required IconData icon, required VoidCallback onTap}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: Icon(icon, color: neonCyan, size: 22),
        title: Text(
          title,
          style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w500),
        ),
        trailing: const Icon(Icons.arrow_forward_ios_rounded, color: Colors.white24, size: 14),
        onTap: onTap,
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: darkCardBg,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text('Logout', style: TextStyle(color: Colors.white)),
        content: const Text('Are you sure you want to log out?', style: TextStyle(color: Colors.white70)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel', style: TextStyle(color: Colors.white54)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: neonPink),
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              if (mounted) {
                Navigator.pop(context);
                Navigator.pushReplacementNamed(context, '/login');
              }
            },
            child: const Text('Logout', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  // ================= REUSABLE COMPONENTS =================
  Shader _buildGradientShader(Rect bounds) {
    return const LinearGradient(
      colors: [
        neonPink,
        neonPurple,
        neonCyan,
      ],
    ).createShader(bounds);
  }

  Widget _circleIconButton({
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 42,
        width: 42,
        decoration: BoxDecoration(
          color: darkCardBg,
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white12),
        ),
        child: Icon(icon, color: Colors.white, size: 20),
      ),
    );
  }

  Widget _fandomTrendingCard(Map<String, dynamic> item) {
    final imagePath = item['image'] ?? '';

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => FandomDetailPage(
              title: item['title'] ?? '',
              icon: Icons.star,
              fans: item['fans'] ?? '0 Fans',
            ),
          ),
        );
      },
      child: Container(
        width: 135,
        decoration: BoxDecoration(
          color: darkCardBg,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: neonPurple.withOpacity(0.18),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius:
                const BorderRadius.vertical(top: Radius.circular(20)),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    // Check karega ke asset path hai ya network link
                    imagePath.startsWith('assets/')
                        ? Image.asset(
                      imagePath,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Container(
                        color: Colors.white10,
                        child: const Icon(Icons.image, color: Colors.white38),
                      ),
                    )
                        : Image.network(
                      imagePath,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Container(
                        color: Colors.white10,
                        child: const Icon(Icons.image, color: Colors.white38),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.transparent,
                            darkCardBg.withOpacity(0.95),
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item['title'] ?? '',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    item['category'] ?? '',
                    style: const TextStyle(
                      color: AppColors.textSecondary,
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

  Widget _shortcutCard({
    required String title,
    required String subtitle,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: darkCardBg,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: Colors.white12),
        ),
        child: Row(
          children: [
            Icon(icon, color: neonCyan, size: 24),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      color: AppColors.textSecondary,
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