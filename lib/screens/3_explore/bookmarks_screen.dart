import 'package:flutter/material.dart';

class BookmarksScreen extends StatefulWidget {
  const BookmarksScreen({super.key});

  @override
  State<BookmarksScreen> createState() => _BookmarksScreenState();
}

class _BookmarksScreenState extends State<BookmarksScreen> {
  // Theme Color Palette
  static const Color darkBackground = Color(0xFF05021A);
  static const Color darkCardBg = Color(0xFF0D0D2B);
  static const Color neonPink = Color(0xFFEC4899);
  static const Color neonCyan = Color(0xFF06B6D4);
  static const Color neonPurple = Color(0xFF8B5CF6);

  final List<Map<String, String>> bookmarkedItems = [
    {
      'title': 'The Rise of Mystic Warriors',
      'category': 'Anime',
      'type': 'Story',
      'image': 'assets/images/anime.jpg',
    },
    {
      'title': 'Top 10 Gaming Worlds You Must Visit',
      'category': 'Gaming',
      'type': 'Video',
      'image': 'assets/images/gaming.jpg',
    },
    {
      'title': 'Cyberpunk 2077 Lore Explained',
      'category': 'Sci-Fi',
      'type': 'Article',
      'image': 'assets/images/scifi.jpg',
    },
  ];

  void _removeBookmark(int index) {
    final removedItem = bookmarkedItems[index];

    setState(() {
      bookmarkedItems.removeAt(index);
    });

    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: const Color(0xFF161B33),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: const BorderSide(color: neonPink, width: 0.8),
        ),
        content: Text(
          'Removed "${removedItem['title']}"',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(color: Colors.white, fontSize: 13),
        ),
        action: SnackBarAction(
          label: 'UNDO',
          textColor: neonCyan,
          onPressed: () {
            setState(() {
              bookmarkedItems.insert(index, removedItem);
            });
          },
        ),
        duration: const Duration(seconds: 3),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkBackground,
      appBar: AppBar(
        backgroundColor: darkBackground,
        elevation: 0,
        centerTitle: false,
        title: const Text(
          'My Bookmarks 🔖',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: Colors.white,
          ),
        ),
      ),
      body: Stack(
        children: [
          // Background Glow Accents
          Positioned(
            top: -40,
            right: -40,
            child: Container(
              height: 180,
              width: 180,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: neonPurple.withOpacity(0.15),
                boxShadow: [
                  BoxShadow(
                    color: neonPurple.withOpacity(0.15),
                    blurRadius: 80,
                    spreadRadius: 20,
                  ),
                ],
              ),
            ),
          ),

          Positioned(
            bottom: 50,
            left: -50,
            child: Container(
              height: 200,
              width: 200,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: neonCyan.withOpacity(0.12),
                boxShadow: [
                  BoxShadow(
                    color: neonCyan.withOpacity(0.12),
                    blurRadius: 90,
                    spreadRadius: 20,
                  ),
                ],
              ),
            ),
          ),

          // Main Content
          bookmarkedItems.isEmpty
              ? _buildEmptyState()
              : ListView.builder(
            padding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            itemCount: bookmarkedItems.length,
            itemBuilder: (context, index) {
              final item = bookmarkedItems[index];

              return Container(
                margin: const EdgeInsets.only(bottom: 14),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: darkCardBg,
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(
                    color: Colors.white.withOpacity(0.08),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    // Icon / Image Box
                    Container(
                      width: 65,
                      height: 65,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14),
                        gradient: LinearGradient(
                          colors: [
                            neonPurple.withOpacity(0.3),
                            neonPink.withOpacity(0.3),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        border: Border.all(
                          color: neonPurple.withOpacity(0.4),
                        ),
                      ),
                      child: const Icon(
                        Icons.bookmark_added_rounded,
                        color: neonCyan,
                        size: 28,
                      ),
                    ),
                    const SizedBox(width: 14),

                    // Text Information
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                item['category']!,
                                style: const TextStyle(
                                  color: neonCyan,
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 0.5,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 3,
                                ),
                                decoration: BoxDecoration(
                                  color: neonPurple.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    color: neonPurple.withOpacity(0.5),
                                  ),
                                ),
                                child: Text(
                                  item['type']!,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 9,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 6),
                          Text(
                            item['title']!,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 14,
                              height: 1.3,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Remove Button
                    IconButton(
                      onPressed: () => _removeBookmark(index),
                      icon: const Icon(
                        Icons.bookmark_remove_rounded,
                        color: neonPink,
                        size: 22,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  // Empty State Widget
  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(22),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: darkCardBg,
                border: Border.all(color: Colors.white10),
              ),
              child: Icon(
                Icons.bookmark_outline_rounded,
                size: 60,
                color: Colors.white.withOpacity(0.35),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'No bookmarks saved yet!',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Explore fandoms and bookmark your favorite stories, videos, or articles to view them later.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white.withOpacity(0.5),
                fontSize: 13,
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}