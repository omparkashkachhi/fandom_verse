import 'package:flutter/material.dart';

class NewsGalleryScreen extends StatefulWidget {
  const NewsGalleryScreen({super.key});

  @override
  State<NewsGalleryScreen> createState() => _NewsGalleryScreenState();
}

class _NewsGalleryScreenState extends State<NewsGalleryScreen> {
  int selectedTab = 0;

  // Search logic state
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  // Track liked items
  final Set<int> _likedNewsIndices = {};

  final List<Map<String, dynamic>> stories = [
    {
      'title': 'Anime',
      'icon': Icons.auto_awesome_rounded,
      'color': const Color(0xFFE040FB),
    },
    {
      'title': 'Gaming',
      'icon': Icons.sports_esports_rounded,
      'color': const Color(0xFF7C4DFF),
    },
    {
      'title': 'Movies',
      'icon': Icons.movie_creation_rounded,
      'color': const Color(0xFFFF4081),
    },
    {
      'title': 'Music',
      'icon': Icons.music_note_rounded,
      'color': const Color(0xFF00BCD4),
    },
    {
      'title': 'Comics',
      'icon': Icons.menu_book_rounded,
      'color': const Color(0xFFFF9800),
    },
  ];

  final List<Map<String, dynamic>> news = [
    {
      'id': 0,
      'category': 'ANIME',
      'title': 'The latest fandom updates everyone is talking about',
      'time': '2 hours ago',
      'icon': Icons.auto_awesome_rounded,
      'color': const Color(0xFFE040FB),
    },
    {
      'id': 1,
      'category': 'GAMING',
      'title': 'New gaming community trends are taking over',
      'time': '5 hours ago',
      'icon': Icons.sports_esports_rounded,
      'color': const Color(0xFF7C4DFF),
    },
    {
      'id': 2,
      'category': 'MOVIES',
      'title': 'What fans are watching and discussing today',
      'time': 'Yesterday',
      'icon': Icons.movie_rounded,
      'color': const Color(0xFFFF4081),
    },
  ];

  final List<Map<String, dynamic>> galleryItems = [
    {'title': 'Anime Showcase', 'color': const Color(0xFF7C3AED), 'icon': Icons.auto_awesome_rounded},
    {'title': 'Gaming Moments', 'color': const Color(0xFFE040FB), 'icon': Icons.sports_esports_rounded},
    {'title': 'Movie Posters', 'color': const Color(0xFF00BCD4), 'icon': Icons.movie_creation_rounded},
    {'title': 'Music Hits', 'color': const Color(0xFFFF4081), 'icon': Icons.music_note_rounded},
    {'title': 'Comic Artwork', 'color': const Color(0xFFFF9800), 'icon': Icons.menu_book_rounded},
    {'title': 'Fan Photography', 'color': const Color(0xFF3F51B5), 'icon': Icons.camera_alt_rounded},
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  // Filter Getters
  List<Map<String, dynamic>> get _filteredStories {
    if (_searchQuery.trim().isEmpty) return stories;
    final query = _searchQuery.toLowerCase().trim();
    return stories
        .where((s) => (s['title'] as String).toLowerCase().contains(query))
        .toList();
  }

  List<Map<String, dynamic>> get _filteredNews {
    if (_searchQuery.trim().isEmpty) return news;
    final query = _searchQuery.toLowerCase().trim();
    return news.where((n) {
      final title = (n['title'] as String).toLowerCase();
      final category = (n['category'] as String).toLowerCase();
      return title.contains(query) || category.contains(query);
    }).toList();
  }

  List<Map<String, dynamic>> get _filteredGallery {
    if (_searchQuery.trim().isEmpty) return galleryItems;
    final query = _searchQuery.toLowerCase().trim();
    return galleryItems
        .where((g) => (g['title'] as String).toLowerCase().contains(query))
        .toList();
  }

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
                    padding: const EdgeInsets.fromLTRB(20, 8, 20, 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _header(),
                        const SizedBox(height: 22),
                        _searchBar(),
                        const SizedBox(height: 25),
                        _storiesSection(),
                        const SizedBox(height: 28),
                        _tabs(),
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
      bottomNavigationBar: _bottomNavigation(),
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
          left: -100,
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
          top: 500,
          right: -140,
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
              'FANDOM MEDIA',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w800,
                letterSpacing: 1.3,
              ),
            ),
          ),
          _topIcon(
            Icons.notifications_none_rounded,
                () => _showMessage('Notifications coming soon'),
          ),
        ],
      ),
    );
  }

  Widget _topIcon(IconData icon, VoidCallback onTap) {
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
  // HEADER
  // ------------------------------------------------------------

  Widget _header() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'STAY IN THE LOOP',
          style: TextStyle(
            color: const Color(0xFFE879F9).withOpacity(0.9),
            fontSize: 11,
            fontWeight: FontWeight.w800,
            letterSpacing: 2,
          ),
        ),
        const SizedBox(height: 7),
        const Text(
          'Fandom Stories & News',
          style: TextStyle(
            color: Colors.white,
            fontSize: 28,
            fontWeight: FontWeight.w900,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Discover the latest stories, updates and moments\nfrom the communities you love.',
          style: TextStyle(
            color: Colors.white.withOpacity(0.48),
            fontSize: 13,
            height: 1.5,
          ),
        ),
      ],
    );
  }

  // ------------------------------------------------------------
  // SEARCH BAR
  // ------------------------------------------------------------

  Widget _searchBar() {
    return Container(
      height: 55,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(17),
        border: Border.all(
          color: _searchQuery.isNotEmpty
              ? const Color(0xFFE879F9)
              : Colors.white.withOpacity(0.08),
        ),
      ),
      child: Row(
        children: [
          const SizedBox(width: 17),
          const Icon(
            Icons.search_rounded,
            color: Color(0xFFE879F9),
            size: 23,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: TextField(
              controller: _searchController,
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
              style: const TextStyle(color: Colors.white, fontSize: 13.5),
              decoration: InputDecoration(
                hintText: 'Search stories, news or fandoms...',
                hintStyle: TextStyle(
                  color: Colors.white.withOpacity(0.38),
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
                setState(() {
                  _searchQuery = '';
                });
              },
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: Icon(
                  Icons.close_rounded,
                  color: Colors.white54,
                  size: 20,
                ),
              ),
            ),
          Container(
            margin: const EdgeInsets.only(right: 7),
            padding: const EdgeInsets.all(9),
            decoration: BoxDecoration(
              color: const Color(0xFFD946EF).withOpacity(0.10),
              borderRadius: BorderRadius.circular(11),
            ),
            child: const Icon(
              Icons.tune_rounded,
              color: Color(0xFFE879F9),
              size: 19,
            ),
          ),
        ],
      ),
    );
  }

  // ------------------------------------------------------------
  // STORIES
  // ------------------------------------------------------------

  Widget _storiesSection() {
    final filtered = _filteredStories;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Fandom Stories',
          style: TextStyle(
            color: Colors.white,
            fontSize: 19,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 4),
        const Text(
          'What communities are sharing',
          style: TextStyle(
            color: Colors.white38,
            fontSize: 11,
          ),
        ),
        const SizedBox(height: 15),
        if (filtered.isEmpty)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Text(
              'No stories match your search',
              style: TextStyle(
                color: Colors.white.withOpacity(0.35),
                fontSize: 12,
              ),
            ),
          )
        else
          SizedBox(
            height: 100,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              itemCount: filtered.length,
              separatorBuilder: (_, __) => const SizedBox(width: 16),
              itemBuilder: (context, index) {
                final story = filtered[index];

                return GestureDetector(
                  onTap: () {
                    _showMessage('${story['title']} stories selected');
                  },
                  child: SizedBox(
                    width: 65,
                    child: Column(
                      children: [
                        Container(
                          width: 64,
                          height: 64,
                          padding: const EdgeInsets.all(3),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: LinearGradient(
                              colors: [
                                story['color'] as Color,
                                const Color(0xFF7C3AED),
                              ],
                            ),
                          ),
                          child: Container(
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color(0xFF100A22),
                            ),
                            child: Icon(
                              story['icon'] as IconData,
                              color: story['color'] as Color,
                              size: 27,
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          story['title'] as String,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: Colors.white60,
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
      ],
    );
  }

  // ------------------------------------------------------------
  // TABS
  // ------------------------------------------------------------

  Widget _tabs() {
    final tabs = ['Latest News', 'Gallery'];

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
                  alignment: Alignment.center,
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
                  child: Text(
                    tabs[index],
                    style: TextStyle(
                      color: selected ? Colors.white : Colors.white38,
                      fontSize: 12,
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
      return _gallery();
    }

    return _news();
  }

  // ------------------------------------------------------------
  // NEWS
  // ------------------------------------------------------------

  Widget _news() {
    final filtered = _filteredNews;

    if (filtered.isEmpty) {
      return _noResultsWidget('news');
    }

    return Column(
      children: filtered.map((item) {
        return _newsCard(item);
      }).toList(),
    );
  }

  Widget _newsCard(Map<String, dynamic> item) {
    final id = item['id'] as int;
    final isLiked = _likedNewsIndices.contains(id);

    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.045),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: Colors.white.withOpacity(0.07),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 150,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(22),
              ),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  item['color'] as Color,
                  const Color(0xFF160B2C),
                ],
              ),
            ),
            child: Stack(
              children: [
                Positioned(
                  right: -20,
                  top: -25,
                  child: Icon(
                    item['icon'] as IconData,
                    size: 150,
                    color: Colors.white.withOpacity(0.08),
                  ),
                ),
                Center(
                  child: Icon(
                    item['icon'] as IconData,
                    color: Colors.white.withOpacity(0.85),
                    size: 52,
                  ),
                ),
                Positioned(
                  left: 15,
                  top: 15,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.30),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      item['category'] as String,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 9,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 1,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 15, 16, 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item['title'] as String,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    height: 1.35,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 9),
                Row(
                  children: [
                    const Icon(
                      Icons.access_time_rounded,
                      color: Colors.white30,
                      size: 14,
                    ),
                    const SizedBox(width: 5),
                    Text(
                      item['time'] as String,
                      style: const TextStyle(
                        color: Colors.white38,
                        fontSize: 10,
                      ),
                    ),
                    const Spacer(),
                    _smallAction(
                      isLiked ? Icons.favorite_rounded : Icons.favorite_border_rounded,
                      iconColor: isLiked ? const Color(0xFFFF4081) : Colors.white54,
                      onTap: () {
                        setState(() {
                          if (isLiked) {
                            _likedNewsIndices.remove(id);
                          } else {
                            _likedNewsIndices.add(id);
                          }
                        });
                      },
                    ),
                    const SizedBox(width: 8),
                    _smallAction(
                      Icons.share_outlined,
                      onTap: () => _showMessage('Sharing "${item['title']}"'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _smallAction(IconData icon, {Color iconColor = Colors.white54, VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 32,
        height: 32,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.05),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(
          icon,
          color: iconColor,
          size: 16,
        ),
      ),
    );
  }

  // ------------------------------------------------------------
  // GALLERY
  // ------------------------------------------------------------

  Widget _gallery() {
    final filtered = _filteredGallery;

    if (filtered.isEmpty) {
      return _noResultsWidget('gallery items');
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Community Gallery',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 5),
        const Text(
          'Moments shared by fandom communities',
          style: TextStyle(
            color: Colors.white38,
            fontSize: 11,
          ),
        ),
        const SizedBox(height: 15),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: filtered.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 0.95,
          ),
          itemBuilder: (context, index) {
            final item = filtered[index];
            return _galleryCard(
              item['title'] as String,
              item['color'] as Color,
              item['icon'] as IconData,
            );
          },
        ),
      ],
    );
  }

  Widget _galleryCard(String title, Color color, IconData icon) {
    return GestureDetector(
      onTap: () {
        _showMessage('$title selected');
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              color,
              const Color(0xFF100A22),
            ],
          ),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.12),
              blurRadius: 15,
            ),
          ],
        ),
        child: Stack(
          children: [
            Positioned(
              right: -20,
              bottom: -25,
              child: Icon(
                icon,
                size: 130,
                color: Colors.white.withOpacity(0.08),
              ),
            ),
            Center(
              child: Icon(
                icon,
                color: Colors.white.withOpacity(0.9),
                size: 42,
              ),
            ),
            Positioned(
              left: 12,
              bottom: 12,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 9,
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.28),
                  borderRadius: BorderRadius.circular(9),
                ),
                child: Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 9,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _noResultsWidget(String type) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30),
      child: Center(
        child: Column(
          children: [
            Icon(Icons.search_off_rounded, color: Colors.white.withOpacity(0.3), size: 40),
            const SizedBox(height: 8),
            Text(
              'No $type found for "$_searchQuery"',
              style: TextStyle(
                color: Colors.white.withOpacity(0.4),
                fontSize: 13,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ------------------------------------------------------------
  // BOTTOM NAVIGATION
  // ------------------------------------------------------------

  Widget _bottomNavigation() {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF08051A),
        border: Border(
          top: BorderSide(
            color: Colors.white.withOpacity(0.07),
          ),
        ),
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(14, 10, 14, 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _navItem(
                Icons.home_rounded,
                'Home',
                false,
              ),
              _navItem(
                Icons.explore_rounded,
                'Explore',
                false,
              ),
              _navItem(
                Icons.article_rounded,
                'Media',
                true,
              ),
              _navItem(
                Icons.person_rounded,
                'Profile',
                false,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _navItem(
      IconData icon,
      String label,
      bool selected,
      ) {
    return GestureDetector(
      onTap: () {
        if (!selected) {
          _showMessage('$label page coming soon');
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 8,
        ),
        decoration: BoxDecoration(
          color: selected
              ? const Color(0xFFD946EF).withOpacity(0.12)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: selected
                  ? const Color(0xFFE879F9)
                  : Colors.white38,
              size: 22,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                color: selected
                    ? const Color(0xFFE879F9)
                    : Colors.white38,
                fontSize: 10,
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

  // ------------------------------------------------------------
  // MESSAGE
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