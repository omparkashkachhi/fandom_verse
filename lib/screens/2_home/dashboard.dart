import 'package:flutter/material.dart';
import 'profile_screen.dart';

class FanDashboard extends StatefulWidget {
  const FanDashboard({super.key});

  @override
  State<FanDashboard> createState() => _FanDashboardState();
}

class _FanDashboardState extends State<FanDashboard> {
  int selectedIndex = 0;

  final TextEditingController searchController =
  TextEditingController();

  String searchQuery = '';
  String selectedCategory = 'All';

  // ============================================================
  // CATEGORIES
  // ============================================================

  final List<Map<String, dynamic>> categories = [
    {
      'name': 'Anime',
      'image': 'assets/images/mystic_warriors.png',
    },
    {
      'name': 'Gaming',
      'image': 'assets/images/pixel_quest.png',
    },
    {
      'name': 'Comics',
      'image': 'assets/images/nova_realms.png',
    },
    {
      'name': 'Sci-Fi',
      'image': 'assets/images/scifi_event.png',
    },
    {
      'name': 'K-Pop',
      'image': 'assets/images/kpop_event.png',
    },
  ];

  // ============================================================
  // TRENDING
  // ============================================================

  final List<Map<String, dynamic>> trending = [
    {
      'title': 'Mystic Warriors',
      'category': 'Anime',
      'image': 'assets/images/trending_image.png',
      'fans': '12.5K',
    },
    {
      'title': 'Pixel Quest',
      'category': 'Gaming',
      'image': 'assets/images/trending_image2.png',
      'fans': '9.8K',
    },
    {
      'title': 'Nova Realms',
      'category': 'Sci-Fi',
      'image': 'assets/images/nova_realms.png',
      'fans': '8.4K',
    },
  ];

  // ============================================================
  // EVENTS
  // ============================================================

  final List<Map<String, dynamic>> popularEvents = [
    {
      'title': 'Anime Universe',
      'category': 'Anime • Cosplay',
      'location': 'Expo Center Karachi',
      'date': '08',
      'month': 'NOV',
      'year': '2026',
      'image': 'assets/images/anime_event.png',
      'description':
      'Anime Universe is an exciting fandom event where anime lovers can meet, enjoy cosplay, explore fan activities and connect with other anime communities.',
    },
    {
      'title': 'Gaming Galaxy',
      'category': 'Gaming • Esports',
      'location': 'Pearl Continental Karachi',
      'date': '21',
      'month': 'NOV',
      'year': '2026',
      'image': 'assets/images/gaming_event.png',
      'description':
      'Gaming Galaxy brings gamers together for an amazing experience featuring esports, gaming challenges, competitions and exciting community activities.',
    },
    {
      'title': 'Comic World',
      'category': 'Comics • Heroes',
      'location': 'Karachi Arts Council',
      'date': '05',
      'month': 'DEC',
      'year': '2026',
      'image': 'assets/images/comics_event.png',
      'description':
      'Comic World is a celebration of superheroes, comics and creative fandoms. Explore characters, fan art, cosplay and exciting comic activities.',
    },
    {
      'title': 'Future Galaxy',
      'category': 'Sci-Fi • Technology',
      'location': 'Expo Center Karachi',
      'date': '12',
      'month': 'DEC',
      'year': '2026',
      'image': 'assets/images/scifi_event.png',
      'description':
      'Future Galaxy is a futuristic fandom event focused on science fiction, technology, digital worlds and innovative fan experiences.',
    },
    {
      'title': 'K-Pop Fest',
      'category': 'K-Pop • Music',
      'location': 'Arts Council Karachi',
      'date': '19',
      'month': 'DEC',
      'year': '2026',
      'image': 'assets/images/kpop_event.png',
      'description':
      'K-Pop Fest is a colorful celebration for K-Pop fans featuring music, performances, fan activities, dance and an exciting Korean pop culture experience.',
    },
  ];

  // ============================================================
  // DISPOSE
  // ============================================================

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  // ============================================================
  // SEARCH MATCH
  // ============================================================

  bool _matchesSearch(Map<String, dynamic> item) {
    if (searchQuery.trim().isEmpty) {
      return true;
    }

    final query = searchQuery.toLowerCase().trim();

    final title = item['title']?.toString().toLowerCase() ?? '';

    final category = item['category']?.toString().toLowerCase() ?? '';

    final location = item['location']?.toString().toLowerCase() ?? '';

    final description = item['description']?.toString().toLowerCase() ?? '';

    final name = item['name']?.toString().toLowerCase() ?? '';

    return title.contains(query) ||
        category.contains(query) ||
        location.contains(query) ||
        description.contains(query) ||
        name.contains(query);
  }

  // ============================================================
  // CATEGORY MATCH
  // ============================================================

  bool _matchesCategory(Map<String, dynamic> item) {
    if (selectedCategory == 'All') {
      return true;
    }

    final selected = selectedCategory.toLowerCase();

    final category = item['category']?.toString().toLowerCase() ?? '';

    final name = item['name']?.toString().toLowerCase() ?? '';

    return category.contains(selected) || name.contains(selected);
  }

  // ============================================================
  // FILTERED EVENTS
  // ============================================================

  List<Map<String, dynamic>> get filteredEvents {
    return popularEvents.where((event) {
      return _matchesSearch(event) && _matchesCategory(event);
    }).toList();
  }

  // ============================================================
  // FILTERED TRENDING
  // ============================================================

  List<Map<String, dynamic>> get filteredTrending {
    return trending.where((item) {
      return _matchesSearch(item) && _matchesCategory(item);
    }).toList();
  }

  // ============================================================
  // FILTERED CATEGORIES
  // ============================================================

  List<Map<String, dynamic>> get filteredCategories {
    return categories.where((category) {
      return _matchesSearch(category) && _matchesCategory(category);
    }).toList();
  }

  // ============================================================
  // BUILD
  // ============================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF050816),
      body: Stack(
        children: [
          _buildBackground(),
          SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.fromLTRB(
                      18,
                      15,
                      18,
                      110,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildHeader(),
                        const SizedBox(height: 22),
                        _buildSearchBar(),
                        const SizedBox(height: 28),
                        if (filteredCategories.isNotEmpty) ...[
                          _buildSectionTitle(
                            'Explore Categories',
                            'Discover your fandom',
                          ),
                          const SizedBox(height: 14),
                          _buildFilteredCategories(),
                          const SizedBox(height: 28),
                        ],
                        if (filteredTrending.isNotEmpty) ...[
                          _buildSectionTitle(
                            'Trending Now',
                            'What fans are loving',
                            showArrow: true,
                          ),
                          const SizedBox(height: 14),
                          _buildFilteredTrending(),
                          const SizedBox(height: 30),
                        ],
                        if (filteredEvents.isNotEmpty) ...[
                          _buildSectionTitle(
                            'Popular Events',
                            'Meet your fandom',
                            showArrow: true,
                          ),
                          const SizedBox(height: 14),
                          ...filteredEvents.map(
                                (event) => Padding(
                              padding: const EdgeInsets.only(
                                bottom: 14,
                              ),
                              child: _buildEventCard(
                                event: event,
                              ),
                            ),
                          ),
                        ],
                        if (filteredCategories.isEmpty &&
                            filteredTrending.isEmpty &&
                            filteredEvents.isEmpty)
                          _buildNoResults(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            left: 15,
            right: 15,
            bottom: 15,
            child: _buildBottomNavigation(),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // BACKGROUND
  // ============================================================

  Widget _buildBackground() {
    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFF050816),
                Color(0xFF090D22),
                Color(0xFF050816),
              ],
            ),
          ),
        ),
        Positioned(
          top: -100,
          right: -100,
          child: Container(
            width: 260,
            height: 260,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: const Color(0xFF7C3AED).withOpacity(0.12),
            ),
          ),
        ),
        Positioned(
          top: 350,
          left: -130,
          child: Container(
            width: 280,
            height: 280,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: const Color(0xFFC026D3).withOpacity(0.07),
            ),
          ),
        ),
        Positioned(
          bottom: 100,
          right: -120,
          child: Container(
            width: 280,
            height: 280,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: const Color(0xFF2563EB).withOpacity(0.06),
            ),
          ),
        ),
      ],
    );
  }

  // ============================================================
  // HEADER
  // ============================================================

  Widget _buildHeader() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Hey, Fan! 👋',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 5),
              ShaderMask(
                shaderCallback: (bounds) {
                  return const LinearGradient(
                    colors: [
                      Color(0xFFA78BFA),
                      Color(0xFFE879F9),
                      Color(0xFF60A5FA),
                    ],
                  ).createShader(bounds);
                },
                child: const Text(
                  'Explore Your Universe',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
        GestureDetector(
          onTap: () {
            _showNotificationMessage();
          },
          child: Container(
            width: 45,
            height: 45,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.06),
              borderRadius: BorderRadius.circular(15),
              border: Border.all(
                color: Colors.white.withOpacity(0.08),
              ),
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                const Icon(
                  Icons.notifications_none_rounded,
                  color: Colors.white,
                  size: 23,
                ),
                Positioned(
                  top: 10,
                  right: 10,
                  child: Container(
                    width: 7,
                    height: 7,
                    decoration: const BoxDecoration(
                      color: Color(0xFFC026D3),
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // ============================================================
  // NOTIFICATION MESSAGE
  // ============================================================

  void _showNotificationMessage() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: const Color(0xFF171D3A),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
        content: const Row(
          children: [
            Icon(
              Icons.notifications_active_rounded,
              color: Color(0xFFC084FC),
            ),
            SizedBox(width: 10),
            Expanded(
              child: Text(
                'You are all caught up!',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // SEARCH BAR
  // ============================================================

  Widget _buildSearchBar() {
    return Container(
      height: 56,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.055),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: searchQuery.isNotEmpty
              ? const Color(0xFF7C3AED).withOpacity(0.55)
              : Colors.white.withOpacity(0.10),
        ),
      ),
      child: Row(
        children: [
          const SizedBox(width: 17),
          const Icon(
            Icons.search_rounded,
            color: Color(0xFF9CA3AF),
            size: 23,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: TextField(
              controller: searchController,
              onChanged: (value) {
                setState(() {
                  searchQuery = value;
                });
              },
              style: const TextStyle(
                color: Colors.white,
                fontSize: 13.5,
              ),
              cursorColor: const Color(0xFFC084FC),
              textInputAction: TextInputAction.search,
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: 'Search fandoms, characters, events...',
                hintStyle: TextStyle(
                  color: Color(0xFF8B93A7),
                  fontSize: 13.5,
                ),
              ),
            ),
          ),
          if (searchQuery.isNotEmpty)
            GestureDetector(
              onTap: () {
                searchController.clear();
                setState(() {
                  searchQuery = '';
                });
              },
              child: const Padding(
                padding: EdgeInsets.all(8),
                child: Icon(
                  Icons.close_rounded,
                  color: Color(0xFF9CA3AF),
                  size: 19,
                ),
              ),
            ),
          GestureDetector(
            onTap: _showFilterBottomSheet,
            child: Container(
              margin: const EdgeInsets.only(
                right: 7,
              ),
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    Color(0xFF7C3AED),
                    Color(0xFFC026D3),
                  ],
                ),
                borderRadius: BorderRadius.circular(
                  13,
                ),
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  const Icon(
                    Icons.tune_rounded,
                    color: Colors.white,
                    size: 19,
                  ),
                  if (selectedCategory != 'All')
                    Positioned(
                      top: 7,
                      right: 7,
                      child: Container(
                        width: 7,
                        height: 7,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
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
  // FILTER BOTTOM SHEET
  // ============================================================

  void _showFilterBottomSheet() {
    final List<String> filterCategories = [
      'All',
      'Anime',
      'Gaming',
      'Comics',
      'Sci-Fi',
      'K-Pop',
    ];

    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF0B1028),
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(28),
        ),
      ),
      builder: (sheetContext) {
        return StatefulBuilder(
          builder: (context, setSheetState) {
            return Padding(
              padding: const EdgeInsets.fromLTRB(
                22,
                15,
                22,
                25,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      width: 45,
                      height: 5,
                      decoration: BoxDecoration(
                        color: Colors.white24,
                        borderRadius: BorderRadius.circular(
                          20,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  const Text(
                    'Filter Fandoms',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  const Text(
                    'Choose a category to explore',
                    style: TextStyle(
                      color: Color(0xFF8B93A7),
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(
                    height: 22,
                  ),
                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: filterCategories.map(
                          (category) {
                        final bool isSelected = selectedCategory == category;

                        return GestureDetector(
                          onTap: () {
                            setSheetState(() {
                              selectedCategory = category;
                            });
                            setState(() {});
                            Navigator.pop(
                              sheetContext,
                            );
                          },
                          child: AnimatedContainer(
                            duration: const Duration(
                              milliseconds: 200,
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 11,
                            ),
                            decoration: BoxDecoration(
                              gradient: isSelected
                                  ? const LinearGradient(
                                colors: [
                                  Color(0xFF7C3AED),
                                  Color(0xFFC026D3),
                                ],
                              )
                                  : null,
                              color: isSelected
                                  ? null
                                  : Colors.white.withOpacity(
                                0.05,
                              ),
                              borderRadius: BorderRadius.circular(
                                13,
                              ),
                              border: Border.all(
                                color: isSelected
                                    ? Colors.transparent
                                    : Colors.white.withOpacity(
                                  0.10,
                                ),
                              ),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  _getCategoryIcon(category),
                                  color: isSelected
                                      ? Colors.white
                                      : const Color(0xFFA78BFA),
                                  size: 17,
                                ),
                                const SizedBox(
                                  width: 7,
                                ),
                                Text(
                                  category,
                                  style: TextStyle(
                                    color: isSelected
                                        ? Colors.white
                                        : const Color(0xFFC7CDDA),
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ).toList(),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  if (selectedCategory != 'All')
                    SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: OutlinedButton(
                        onPressed: () {
                          setState(() {
                            selectedCategory = 'All';
                          });
                          Navigator.pop(
                            sheetContext,
                          );
                        },
                        style: OutlinedButton.styleFrom(
                          foregroundColor: const Color(
                            0xFFC084FC,
                          ),
                          side: BorderSide(
                            color: const Color(
                              0xFF7C3AED,
                            ).withOpacity(
                              0.5,
                            ),
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              14,
                            ),
                          ),
                        ),
                        child: const Text(
                          'Clear Filter',
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  // ============================================================
  // CATEGORY ICON
  // ============================================================

  IconData _getCategoryIcon(String category) {
    switch (category) {
      case 'Anime':
        return Icons.auto_awesome_rounded;
      case 'Gaming':
        return Icons.sports_esports_rounded;
      case 'Comics':
        return Icons.menu_book_rounded;
      case 'Sci-Fi':
        return Icons.rocket_launch_rounded;
      case 'K-Pop':
        return Icons.music_note_rounded;
      default:
        return Icons.apps_rounded;
    }
  }

  // ============================================================
  // SECTION TITLE
  // ============================================================

  Widget _buildSectionTitle(
      String title,
      String subtitle, {
        bool showArrow = false,
      }) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(
                height: 4,
              ),
              Text(
                subtitle,
                style: const TextStyle(
                  color: Color(0xFF7F879B),
                  fontSize: 11.5,
                ),
              ),
            ],
          ),
        ),
        if (showArrow)
          Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.05),
              borderRadius: BorderRadius.circular(
                11,
              ),
            ),
            child: const Icon(
              Icons.arrow_forward_rounded,
              color: Color(0xFFA78BFA),
              size: 18,
            ),
          ),
      ],
    );
  }

  // ============================================================
  // FILTERED CATEGORIES
  // ============================================================

  Widget _buildFilteredCategories() {
    return SizedBox(
      height: 108,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: filteredCategories.length,
        separatorBuilder: (_, __) => const SizedBox(
          width: 12,
        ),
        itemBuilder: (context, index) {
          final category = filteredCategories[index];

          final bool isSelected = selectedCategory == category['name'];

          return GestureDetector(
            onTap: () {
              setState(() {
                selectedCategory = category['name'];
              });
            },
            child: AnimatedContainer(
              duration: const Duration(
                milliseconds: 200,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  18,
                ),
                border: Border.all(
                  color: isSelected
                      ? const Color(0xFFC084FC)
                      : Colors.white.withOpacity(
                    0.08,
                  ),
                  width: isSelected ? 1.5 : 1,
                ),
              ),
              child: _buildCategoryCard(
                name: category['name'],
                image: category['image'],
              ),
            ),
          );
        },
      ),
    );
  }

  // ============================================================
  // CATEGORY CARD
  // ============================================================

  Widget _buildCategoryCard({
    required String name,
    required String image,
  }) {
    return Container(
      width: 145,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          18,
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(
          18,
        ),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(
              image,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  color: const Color(
                    0xFF151A35,
                  ),
                  child: const Icon(
                    Icons.image_not_supported,
                    color: Colors.white54,
                  ),
                );
              },
            ),
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Color(0xDD050816),
                  ],
                ),
              ),
            ),
            Positioned(
              left: 12,
              bottom: 11,
              child: Text(
                name,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 13,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            if (selectedCategory == name)
              Positioned(
                top: 9,
                right: 9,
                child: Container(
                  width: 25,
                  height: 25,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color(0xFF7C3AED),
                        Color(0xFFC026D3),
                      ],
                    ),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.check_rounded,
                    color: Colors.white,
                    size: 16,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // FILTERED TRENDING
  // ============================================================

  Widget _buildFilteredTrending() {
    return SizedBox(
      height: 205,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: filteredTrending.length,
        separatorBuilder: (_, __) => const SizedBox(
          width: 14,
        ),
        itemBuilder: (context, index) {
          final item = filteredTrending[index];

          return _buildTrendingCard(
            title: item['title'],
            category: item['category'],
            image: item['image'],
            fans: item['fans'],
          );
        },
      ),
    );
  }

  // ============================================================
  // TRENDING CARD
  // ============================================================

  Widget _buildTrendingCard({
    required String title,
    required String category,
    required String image,
    required String fans,
  }) {
    return Container(
      width: 175,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          20,
        ),
        border: Border.all(
          color: Colors.white.withOpacity(0.08),
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(
          20,
        ),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(
              image,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  color: const Color(
                    0xFF151A35,
                  ),
                  child: const Icon(
                    Icons.image_not_supported,
                    color: Colors.white54,
                  ),
                );
              },
            ),
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Color(0xF5050816),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 12,
              left: 12,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 9,
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                  color: const Color(
                    0xFF7C3AED,
                  ).withOpacity(
                    0.85,
                  ),
                  borderRadius: BorderRadius.circular(
                    9,
                  ),
                ),
                child: Text(
                  category,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 9,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
            Positioned(
              left: 13,
              right: 10,
              bottom: 13,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.people_alt_rounded,
                        color: Color(
                          0xFFC084FC,
                        ),
                        size: 13,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        '$fans fans',
                        style: const TextStyle(
                          color: Color(
                            0xFFB3B9C9,
                          ),
                          fontSize: 10,
                        ),
                      ),
                    ],
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
  // EVENT CARD
  // ============================================================

  Widget _buildEventCard({
    required Map<String, dynamic> event,
  }) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => EventDetailPage(
              event: event,
            ),
          ),
        );
      },
      child: Container(
        height: 205,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            22,
          ),
          border: Border.all(
            color: Colors.white.withOpacity(0.08),
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(
            22,
          ),
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image.asset(
                event['image'],
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: const Color(
                      0xFF151A35,
                    ),
                    child: const Icon(
                      Icons.image_not_supported,
                      color: Colors.white54,
                    ),
                  );
                },
              ),
              Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Color(0xF8050816),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: 13,
                left: 13,
                child: Container(
                  width: 53,
                  padding: const EdgeInsets.symmetric(
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(
                      0xFF080C1F,
                    ).withOpacity(
                      0.88,
                    ),
                    borderRadius: BorderRadius.circular(
                      13,
                    ),
                    border: Border.all(
                      color: Colors.white.withOpacity(
                        0.10,
                      ),
                    ),
                  ),
                  child: Column(
                    children: [
                      Text(
                        event['date'],
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      Text(
                        event['month'],
                        style: const TextStyle(
                          color: Color(
                            0xFFC084FC,
                          ),
                          fontSize: 9,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 16,
                right: 15,
                bottom: 15,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      event['title'],
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 19,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      event['category'],
                      style: const TextStyle(
                        color: Color(
                          0xFFC084FC,
                        ),
                        fontSize: 10.5,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(
                      height: 7,
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.location_on_rounded,
                          color: Color(
                            0xFF9CA3AF,
                          ),
                          size: 13,
                        ),
                        const SizedBox(
                          width: 4,
                        ),
                        Expanded(
                          child: Text(
                            event['location'],
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: Color(
                                0xFFB3B9C9,
                              ),
                              fontSize: 10,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        const Icon(
                          Icons.arrow_forward_rounded,
                          color: Colors.white,
                          size: 17,
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
    );
  }

  // ============================================================
  // NO RESULTS
  // ============================================================

  Widget _buildNoResults() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: 25,
        vertical: 45,
      ),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.04),
        borderRadius: BorderRadius.circular(
          22,
        ),
        border: Border.all(
          color: Colors.white.withOpacity(0.08),
        ),
      ),
      child: Column(
        children: [
          Container(
            width: 70,
            height: 70,
            decoration:  BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFF7C3AED),
                  Color(0xFFC026D3),
                ],
              ),
              borderRadius: BorderRadius.circular(
                22,
              ),
            ),
            child: const Icon(
              Icons.search_off_rounded,
              color: Colors.white,
              size: 34,
            ),
          ),
          const SizedBox(
            height: 18,
          ),
          const Text(
            'No Results Found',
            style: TextStyle(
              color: Colors.white,
              fontSize: 19,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            searchQuery.isNotEmpty
                ? 'No fandoms or events found for "$searchQuery".'
                : 'No items found in "$selectedCategory".',
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Color(0xFF8B93A7),
              fontSize: 12,
              height: 1.5,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
            onPressed: () {
              searchController.clear();
              setState(() {
                searchQuery = '';
                selectedCategory = 'All';
              });
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(
                0xFF7C3AED,
              ),
              foregroundColor: Colors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                  13,
                ),
              ),
            ),
            child: const Text(
              'Clear Search & Filter',
              style: TextStyle(
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // BOTTOM NAVIGATION
  // ============================================================

  Widget _buildBottomNavigation() {
    final items = [
      {
        'icon': Icons.home_rounded,
        'label': 'Home',
      },
      {
        'icon': Icons.explore_rounded,
        'label': 'Explore',
      },
      {
        'icon': Icons.event_rounded,
        'label': 'Events',
      },
      {
        'icon': Icons.shopping_bag_rounded,
        'label': 'Store',
      },
      {
        'icon': Icons.person_rounded,
        'label': 'Profile',
      },
    ];

    return Container(
      height: 68,
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFF0B1028).withOpacity(0.97),
        borderRadius: BorderRadius.circular(
          22,
        ),
        border: Border.all(
          color: Colors.white.withOpacity(0.09),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.35),
            blurRadius: 25,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(
          items.length,
              (index) {
            final bool active = selectedIndex == index;

            return GestureDetector(
              onTap: () {
                // Profile screen navigation integration
                if (index == 4) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ProfileScreen(),
                    ),
                  );
                  return;
                }

                setState(() {
                  selectedIndex = index;
                });
              },
              child: AnimatedContainer(
                duration: const Duration(
                  milliseconds: 200,
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 11,
                  vertical: 7,
                ),
                decoration: BoxDecoration(
                  gradient: active
                      ? const LinearGradient(
                    colors: [
                      Color(0xFF7C3AED),
                      Color(0xFFC026D3),
                    ],
                  )
                      : null,
                  borderRadius: BorderRadius.circular(
                    14,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      items[index]['icon'] as IconData,
                      color: active ? Colors.white : const Color(0xFF737B91),
                      size: 20,
                    ),
                    const SizedBox(
                      height: 3,
                    ),
                    Text(
                      items[index]['label'] as String,
                      style: TextStyle(
                        color: active ? Colors.white : const Color(0xFF737B91),
                        fontSize: 8.5,
                        fontWeight:
                        active ? FontWeight.w700 : FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

// ============================================================================
// EVENT DETAIL PAGE
// ============================================================================

class EventDetailPage extends StatelessWidget {
  final Map<String, dynamic> event;

  const EventDetailPage({
    super.key,
    required this.event,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF050816),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 310,
            pinned: true,
            backgroundColor: const Color(0xFF080C1F),
            leading: Padding(
              padding: const EdgeInsets.all(
                8,
              ),
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(
                      0.45,
                    ),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.arrow_back_rounded,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset(
                    event['image'],
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: const Color(
                          0xFF151A35,
                        ),
                      );
                    },
                  ),
                  const DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Color(0xF5050816),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(
                20,
                10,
                20,
                30,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    event['title'],
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const SizedBox(
                    height: 9,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 11,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [
                          Color(0xFF7C3AED),
                          Color(0xFFC026D3),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(
                        10,
                      ),
                    ),
                    child: Text(
                      event['category'],
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 22,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _detailInfo(
                        Icons.calendar_month_rounded,
                        '${event['date']} ${event['month']} ${event['year']}',
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      Expanded(
                        child: _detailInfo(
                          Icons.location_on_rounded,
                          event['location'],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  const Text(
                    'About Event',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 19,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    event['description'],
                    style: const TextStyle(
                      color: Color(
                        0xFFAAB1C1,
                      ),
                      fontSize: 13,
                      height: 1.7,
                    ),
                  ),
                  const SizedBox(
                    height: 28,
                  ),
                  const Text(
                    'What to Expect',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 19,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  _featureTile(
                    Icons.groups_rounded,
                    'Meet fellow fans',
                  ),
                  _featureTile(
                    Icons.auto_awesome_rounded,
                    'Amazing fan activities',
                  ),
                  _featureTile(
                    Icons.camera_alt_rounded,
                    'Cosplay & photography',
                  ),
                  _featureTile(
                    Icons.emoji_events_rounded,
                    'Competitions & challenges',
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 54,
                    child: ElevatedButton(
                      onPressed: () {
                        _showEventPass(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(
                          0xFF7C3AED,
                        ),
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            16,
                          ),
                        ),
                      ),
                      child: const Text(
                        'Get Event Pass',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w800,
                        ),
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

  void _showEventPass(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF0B1028),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25),
        ),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(25),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.confirmation_number_rounded,
                color: Color(0xFFC084FC),
                size: 45,
              ),
              const SizedBox(
                height: 15,
              ),
              const Text(
                'Event Pass',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 21,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                'Your pass for ${event['title']} will be available here.',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Color(0xFF8B93A7),
                  fontSize: 12,
                  height: 1.5,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(
                      0xFF7C3AED,
                    ),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        14,
                      ),
                    ),
                  ),
                  child: const Text(
                    'Continue',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
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

  Widget _detailInfo(
      IconData icon,
      String text,
      ) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 38,
          height: 38,
          decoration: BoxDecoration(
            color: const Color(
              0xFF7C3AED,
            ).withOpacity(0.12),
            borderRadius: BorderRadius.circular(
              12,
            ),
          ),
          child: Icon(
            icon,
            color: const Color(
              0xFFC084FC,
            ),
            size: 18,
          ),
        ),
        const SizedBox(
          width: 8,
        ),
        Flexible(
          child: Text(
            text,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: Color(0xFFC5CBD8),
              fontSize: 10.5,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  Widget _featureTile(
      IconData icon,
      String title,
      ) {
    return Container(
      margin: const EdgeInsets.only(
        bottom: 10,
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 14,
        vertical: 13,
      ),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.035),
        borderRadius: BorderRadius.circular(
          14,
        ),
        border: Border.all(
          color: Colors.white.withOpacity(0.06),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 35,
            height: 35,
            decoration: BoxDecoration(
              color: const Color(
                0xFF7C3AED,
              ).withOpacity(0.12),
              borderRadius: BorderRadius.circular(
                10,
              ),
            ),
            child: Icon(
              icon,
              color: const Color(
                0xFFC084FC,
              ),
              size: 18,
            ),
          ),
          const SizedBox(
            width: 12,
          ),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                color: Color(0xFFD5D9E3),
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}