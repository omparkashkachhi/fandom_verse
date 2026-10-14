import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../../models/fandom_model.dart';
import 'package:fandom_verse1/screens/3_explore/beginner_hub_screen.dart';
import 'package:fandom_verse1/screens/4_fandom_detail/fandom_detail_screen.dart';
import 'package:fandom_verse1/screens/4_fandom_detail/stories_screen.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  String selectedCategory = 'All';
  bool notificationsOn = false;
  bool showSearch = false;
  String searchQuery = '';

  final TextEditingController searchController = TextEditingController();

  final List<String> categories = const [
    'All',
    'Anime',
    'Gaming',
    'Comics',
    'Sci-Fi',
    'K-Pop',
    'Fantasy',
  ];

  final List<Map<String, String>> allGridItems = const [
    {
      'id': 'e1',
      'title': 'Anime',
      'fans': '1.2M Fans',
      'rating': '4.8',
      'imageUrl': 'assets/images/anime1.jpg',
    },
    {
      'id': 'e2',
      'title': 'Gaming',
      'fans': '980K Fans',
      'rating': '4.7',
      'imageUrl': 'assets/images/gaming.jpg',
    },
    {
      'id': 'e3',
      'title': 'Comics',
      'fans': '670K Fans',
      'rating': '4.5',
      'imageUrl': 'assets/images/comics.jpg',
    },
    {
      'id': 'e4',
      'title': 'Sci-Fi',
      'fans': '540K Fans',
      'rating': '4.9',
      'imageUrl': 'assets/images/sci_fic.jpg',
    },
    {
      'id': 'e5',
      'title': 'K-Pop',
      'fans': '620K Fans',
      'rating': '4.8',
      'imageUrl': 'assets/images/k_pop.jpg',
    },
    {
      'id': 'e6',
      'title': 'Fantasy',
      'fans': '430K Fans',
      'rating': '4.6',
      'imageUrl': 'assets/images/fantasy.jpg',
    },
  ];

  final List<Map<String, dynamic>> allStories = const [
    {
      'title': 'The Rise of Mystic Warriors',
      'category': 'Anime',
      'icon': Icons.auto_awesome,
    },
    {
      'title': 'Top 10 Gaming Worlds',
      'category': 'Gaming',
      'icon': Icons.sports_esports,
    },
    {
      'title': 'Hidden Secrets of Nova Realms',
      'category': 'Sci-Fi',
      'icon': Icons.public,
    },
  ];

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Dynamic search + category filter for Grid
    final filteredGridItems = allGridItems.where((item) {
      final matchesCategory = selectedCategory == 'All' ||
          item['title']!.toLowerCase() == selectedCategory.toLowerCase();
      final matchesSearch =
      item['title']!.toLowerCase().contains(searchQuery.toLowerCase());
      return matchesCategory && matchesSearch;
    }).toList();

    // Dynamic search filter for Stories
    final filteredStories = allStories.where((story) {
      final titleMatch = story['title']
          .toString()
          .toLowerCase()
          .contains(searchQuery.toLowerCase());
      final categoryMatch = story['category']
          .toString()
          .toLowerCase()
          .contains(searchQuery.toLowerCase());
      return titleMatch || categoryMatch;
    }).toList();

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        scrolledUnderElevation: 0,
        title: const Text(
          'Explore Fandoms 🪐',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: 20,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                showSearch = !showSearch;
                if (!showSearch) {
                  searchQuery = '';
                  searchController.clear();
                }
              });
            },
            icon: Icon(
              showSearch ? Icons.close_rounded : Icons.search_rounded,
              color: Colors.white,
            ),
          ),
          Stack(
            alignment: Alignment.center,
            children: [
              IconButton(
                onPressed: () {
                  setState(() {
                    notificationsOn = !notificationsOn;
                  });
                  ScaffoldMessenger.of(context).clearSnackBars();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        notificationsOn
                            ? 'Notifications Enabled!'
                            : 'Notifications Muted!',
                      ),
                      duration: const Duration(seconds: 1),
                      backgroundColor: AppColors.cardBg,
                    ),
                  );
                },
                icon: Icon(
                  notificationsOn
                      ? Icons.notifications_active_rounded
                      : Icons.notifications_outlined,
                  color: notificationsOn ? Colors.pinkAccent : Colors.white,
                ),
              ),
              if (notificationsOn)
                Positioned(
                  top: 12,
                  right: 12,
                  child: Container(
                    width: 8,
                    height: 8,
                    decoration: const BoxDecoration(
                      color: Colors.pinkAccent,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            // Responsive Column Count
            int crossAxisCount = 2;
            if (constraints.maxWidth > 900) {
              crossAxisCount = 4;
            } else if (constraints.maxWidth > 600) {
              crossAxisCount = 3;
            }

            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // --- SEARCH BAR ---
                  AnimatedCrossFade(
                    duration: const Duration(milliseconds: 250),
                    crossFadeState: showSearch
                        ? CrossFadeState.showSecond
                        : CrossFadeState.showFirst,
                    firstChild: const SizedBox.shrink(),
                    secondChild: Container(
                      margin: const EdgeInsets.only(bottom: 16),
                      child: TextField(
                        controller: searchController,
                        style:
                        const TextStyle(color: Colors.white, fontSize: 14),
                        onChanged: (value) {
                          setState(() {
                            searchQuery = value;
                          });
                        },
                        decoration: InputDecoration(
                          hintText: 'Search fandoms, categories...',
                          hintStyle: const TextStyle(
                            color: AppColors.textSecondary,
                            fontSize: 13,
                          ),
                          prefixIcon: const Icon(
                            Icons.search_rounded,
                            color: AppColors.textSecondary,
                          ),
                          filled: true,
                          fillColor: AppColors.cardBg,
                          contentPadding:
                          const EdgeInsets.symmetric(vertical: 12),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: const BorderSide(color: Colors.white12),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: const BorderSide(color: Colors.white12),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: const BorderSide(color: Colors.cyan),
                          ),
                          suffixIcon: searchQuery.isNotEmpty
                              ? IconButton(
                            onPressed: () {
                              searchController.clear();
                              setState(() {
                                searchQuery = '';
                              });
                            },
                            icon: const Icon(
                              Icons.clear_rounded,
                              color: AppColors.textSecondary,
                              size: 18,
                            ),
                          )
                              : null,
                        ),
                      ),
                    ),
                  ),

                  // --- CATEGORIES HORIZONTAL PILLS ---
                  SizedBox(
                    height: 40,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      physics: const BouncingScrollPhysics(),
                      itemCount: categories.length,
                      separatorBuilder: (_, __) => const SizedBox(width: 8),
                      itemBuilder: (context, index) {
                        final category = categories[index];
                        final isSelected = selectedCategory == category;

                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedCategory = category;
                            });
                          },
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 18,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? AppColors.primary.withOpacity(0.3)
                                  : AppColors.cardBg,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: isSelected
                                    ? Colors.cyan
                                    : Colors.white12,
                                width: 1.2,
                              ),
                            ),
                            child: Center(
                              child: Text(
                                category,
                                style: TextStyle(
                                  color: isSelected
                                      ? Colors.white
                                      : AppColors.textSecondary,
                                  fontSize: 12,
                                  fontWeight: isSelected
                                      ? FontWeight.bold
                                      : FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),

                  const SizedBox(height: 24),

                  // --- SECTION HEADER ---
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Fandom Categories',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        '${filteredGridItems.length} items',
                        style: const TextStyle(
                          color: AppColors.textSecondary,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 12),

                  // --- GRID VIEW CATEGORIES ---
                  filteredGridItems.isEmpty
                      ? Container(
                    height: 150,
                    alignment: Alignment.center,
                    child: const Text(
                      'No fandom categories found',
                      style: TextStyle(color: AppColors.textSecondary),
                    ),
                  )
                      : GridView.builder(
                    gridDelegate:
                    SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: crossAxisCount,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      childAspectRatio: 0.85,
                    ),
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: filteredGridItems.length,
                    itemBuilder: (context, index) {
                      final item = filteredGridItems[index];
                      return _exploreGridCard(
                        id: item['id']!,
                        title: item['title']!,
                        fans: item['fans']!,
                        rating: item['rating']!,
                        imageUrl: item['imageUrl']!,
                      );
                    },
                  ),

                  const SizedBox(height: 28),

                  // --- BEGINNER FAN HUB HEADER ---
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Beginner Fan Hub',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const BeginnerHubScreen(),
                            ),
                          );
                        },
                        child: const Row(
                          children: [
                            Text(
                              'Open Hub',
                              style: TextStyle(
                                color: Colors.cyan,
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            ),
                            Icon(
                              Icons.chevron_right_rounded,
                              color: Colors.cyan,
                              size: 16,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 12),

                  // --- BEGINNER HUB BANNER ---
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const BeginnerHubScreen(),
                        ),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(18),
                        color: AppColors.cardBg,
                        border: Border.all(color: Colors.white12),
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: AppColors.primary.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(14),
                            ),
                            child: const Icon(
                              Icons.explore_outlined,
                              size: 32,
                              color: Colors.cyan,
                            ),
                          ),
                          const SizedBox(width: 14),
                          const Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'New to fandoms?',
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  'Learn characters, stories, terms and universe history.',
                                  style: TextStyle(
                                    color: AppColors.textSecondary,
                                    fontSize: 11,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Icon(
                            Icons.chevron_right_rounded,
                            size: 22,
                            color: AppColors.textSecondary,
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 28),

                  // --- LATEST STORIES HEADER ---
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Latest Stories',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const StoriesScreen(),
                            ),
                          );
                        },
                        child: const Row(
                          children: [
                            Text(
                              'See All',
                              style: TextStyle(
                                color: Colors.cyan,
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            ),
                            Icon(
                              Icons.chevron_right_rounded,
                              color: Colors.cyan,
                              size: 16,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 12),

                  // --- STORIES LIST ---
                  filteredStories.isEmpty
                      ? Container(
                    padding: const EdgeInsets.all(20),
                    alignment: Alignment.center,
                    child: const Text(
                      'No matching stories found',
                      style: TextStyle(color: AppColors.textSecondary),
                    ),
                  )
                      : ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: filteredStories.length,
                    itemBuilder: (context, index) {
                      final story = filteredStories[index];
                      return _storyCard(
                        title: story['title'] as String,
                        category: story['category'] as String,
                        icon: story['icon'] as IconData,
                      );
                    },
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  // WIDGET BUILDER: GRID CARD
  Widget _exploreGridCard({
    required String id,
    required String title,
    required String fans,
    required String rating,
    required String imageUrl,
  }) {
    bool isSelectedCategory = selectedCategory == title;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedCategory = title;
        });

        final fandomData = Fandom(
          id: id,
          name: title == 'Anime' ? 'Mystic Warriors' : '$title Universe',
          category: title,
          fans: fans,
          rating: rating,
          imageUrl: imageUrl,
          description:
          'Welcome to the ultimate $title universe! Explore lore, character guides, trending theories, fan art and engage with a passionate global fanbase.',
        );

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => FandomDetailScreen(
              fandom: fandomData,
            ),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: isSelectedCategory ? Colors.cyan : Colors.white12,
            width: isSelectedCategory ? 1.5 : 1,
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(18),
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image.asset(
                imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                  color: AppColors.cardBg,
                  child: const Icon(
                    Icons.image_not_supported_outlined,
                    color: AppColors.textSecondary,
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.black.withOpacity(0.85),
                      Colors.transparent,
                    ],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    stops: const [0.0, 0.7],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      fans,
                      style: const TextStyle(
                        fontSize: 11,
                        color: AppColors.textSecondary,
                      ),
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

  // WIDGET BUILDER: STORY CARD
  Widget _storyCard({
    required String title,
    required String category,
    required IconData icon,
  }) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => const StoriesScreen(),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppColors.cardBg,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.white10),
        ),
        child: Row(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: AppColors.primary.withOpacity(0.2),
              ),
              child: Icon(
                icon,
                color: Colors.cyan,
                size: 22,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    category,
                    style: const TextStyle(
                      color: Colors.cyan,
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.chevron_right_rounded,
              size: 20,
              color: AppColors.textSecondary,
            ),
          ],
        ),
      ),
    );
  }
}