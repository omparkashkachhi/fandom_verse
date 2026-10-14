import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../../models/fandom_model.dart';
import '../7_ai_helper/ai_chat_screen.dart';
import 'gallery_screen.dart';
import 'stories_screen.dart';
import 'trivia_screen.dart';
import 'videos_screen.dart';

// Sub-tabs Imports
import 'tabs/characters_tab.dart';
import 'tabs/overview_tab.dart';
import 'tabs/trivia_tab.dart';

class FandomDetailScreen extends StatefulWidget {
  final Fandom fandom;

  const FandomDetailScreen({
    super.key,
    required this.fandom,
  });

  @override
  State<FandomDetailScreen> createState() => _FandomDetailScreenState();
}

class _FandomDetailScreenState extends State<FandomDetailScreen> {
  int _selectedTabIndex = 0;
  bool isJoined = false;
  bool isBookmarked = false;

  final List<String> _tabs = ['Overview', 'Characters', 'Media', 'Trivia'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        slivers: [
          // ==========================================
          // COLLAPSIBLE APP BAR WITH IMAGE & CONTROLS
          // ==========================================
          SliverAppBar(
            expandedHeight: 280,
            pinned: true,
            backgroundColor: AppColors.background,
            elevation: 0,
            leading: Padding(
              padding: const EdgeInsets.all(8.0),
              child: _circleIconButton(
                icon: Icons.arrow_back,
                onTap: () => Navigator.pop(context),
              ),
            ),
            actions: [
              _circleIconButton(
                icon: isBookmarked ? Icons.favorite : Icons.favorite_border,
                iconColor: isBookmarked ? Colors.pinkAccent : Colors.white,
                onTap: () {
                  setState(() {
                    isBookmarked = !isBookmarked;
                  });
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        isBookmarked
                            ? 'Added to Favorites!'
                            : 'Removed from Favorites',
                      ),
                      duration: const Duration(milliseconds: 1000),
                      backgroundColor: AppColors.primary,
                    ),
                  );
                },
              ),
              const SizedBox(width: 8),
              _circleIconButton(
                icon: Icons.share,
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Sharing link copied!'),
                      duration: Duration(milliseconds: 1000),
                      backgroundColor: AppColors.cardBg,
                    ),
                  );
                },
              ),
              const SizedBox(width: 16),
            ],
            flexibleSpace: FlexibleSpaceBar(
              titlePadding: const EdgeInsets.only(left: 16, bottom: 16, right: 16),
              title: Text(
                widget.fandom.name,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  shadows: [
                    Shadow(
                      offset: const Offset(0, 1),
                      blurRadius: 6,
                      color: Colors.black.withValues(alpha: 0.8),
                    ),
                  ],
                ),
              ),
              background: Stack(
                fit: StackFit.expand,
                children: [
                  widget.fandom.imageUrl.startsWith('http')
                      ? Image.network(
                    widget.fandom.imageUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => _buildFallbackImage(),
                  )
                      : Image.asset(
                    widget.fandom.imageUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => _buildFallbackImage(),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.black.withValues(alpha: 0.4),
                          Colors.transparent,
                          AppColors.background.withValues(alpha: 0.8),
                          AppColors.background,
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        stops: const [0.0, 0.4, 0.85, 1.0],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // ==========================================
          // MAIN BODY CONTENT
          // ==========================================
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 8),

                  // Category Tags & Stats
                  Row(
                    children: [
                      _categoryTag(widget.fandom.category, isPrimary: true),
                      const SizedBox(width: 8),
                      _categoryTag('Action'),
                      const SizedBox(width: 8),
                      _categoryTag('Adventure'),
                    ],
                  ),

                  const SizedBox(height: 14),

                  // Fans Count & Rating
                  Row(
                    children: [
                      Text(
                        widget.fandom.fans,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Text(
                        '•',
                        style: TextStyle(color: AppColors.textSecondary, fontSize: 14),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        widget.fandom.rating.isNotEmpty ? widget.fandom.rating : '4.8',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 4),
                      const Icon(
                        Icons.star_rounded,
                        color: Colors.amber,
                        size: 18,
                      ),
                    ],
                  ),

                  const SizedBox(height: 24),

                  // Dynamic Tabs Navigation Header
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: List.generate(_tabs.length, (index) {
                      final isSelected = _selectedTabIndex == index;
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedTabIndex = index;
                          });
                        },
                        child: Column(
                          children: [
                            Text(
                              _tabs[index],
                              style: TextStyle(
                                color: isSelected
                                    ? Colors.white
                                    : AppColors.textSecondary,
                                fontWeight: isSelected
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(height: 6),
                            AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              height: 2,
                              width: isSelected ? 40 : 0,
                              color: isSelected
                                  ? AppColors.primary
                                  : Colors.transparent,
                            ),
                          ],
                        ),
                      );
                    }),
                  ),

                  const SizedBox(height: 12),

                  // Active Dynamic Tab Content Area
                  _buildTabContent(),

                  const SizedBox(height: 24),

                  // Primary Action Buttons (Join & AI Chat)
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          isJoined = !isJoined;
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: isJoined
                            ? AppColors.cardBg
                            : AppColors.primary,
                        side: isJoined
                            ? const BorderSide(color: AppColors.cyan)
                            : BorderSide.none,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 2,
                      ),
                      child: Text(
                        isJoined ? 'Joined ✓' : 'Join Community',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: isJoined
                              ? AppColors.cyan
                              : Colors.white,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 12),

                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: OutlinedButton.icon(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const AIChatScreen(),
                          ),
                        );
                      },
                      icon: const Icon(Icons.smart_toy, color: AppColors.cyan, size: 20),
                      label: const Text(
                        'Ask Fandom AI Assistant',
                        style: TextStyle(
                          color: AppColors.cyan,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: AppColors.cyan),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 28),

                  // Featured Navigation Section
                  const Text(
                    'Featured Modules',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),

                  const SizedBox(height: 14),

                  Row(
                    children: [
                      Expanded(
                        child: _featuredCard(
                          title: 'Fan Art',
                          icon: Icons.photo_library_outlined,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const GalleryScreen(),
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: _featuredCard(
                          title: 'Theories',
                          icon: Icons.auto_stories_outlined,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const StoriesScreen(),
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: _featuredCard(
                          title: 'Discussions',
                          icon: Icons.quiz_outlined,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const TriviaScreen(),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 36),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // --- TAB CONTENT BUILDER ---
  Widget _buildTabContent() {
    switch (_selectedTabIndex) {
      case 0: // Overview Tab
        return OverviewTab(
          description: widget.fandom.description.isNotEmpty
              ? widget.fandom.description
              : 'Explore the universe, characters, lore, and community discussions.',
        );
      case 1: // Characters Tab
        return const SizedBox(
          height: 420,
          child: CharactersTab(),
        );
      case 2: // Media Tab
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const VideosScreen()),
                    );
                  },
                  icon: const Icon(Icons.video_library, color: Colors.white, size: 18),
                  label: const Text('Videos', style: TextStyle(color: Colors.white)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.cardBg,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                      side: const BorderSide(color: Colors.white12),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const GalleryScreen()),
                    );
                  },
                  icon: const Icon(Icons.image, color: Colors.white, size: 18),
                  label: const Text('Gallery', style: TextStyle(color: Colors.white)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.cardBg,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                      side: const BorderSide(color: Colors.white12),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      case 3: // Trivia Tab
        return const SizedBox(
          height: 480,
          child: TriviaTab(),
        );
      default:
        return const SizedBox.shrink();
    }
  }

  // --- HELPER COMPONENTS ---
  Widget _circleIconButton({
    required IconData icon,
    required VoidCallback onTap,
    Color iconColor = Colors.white,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.black.withValues(alpha: 0.5),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: iconColor, size: 18),
      ),
    );
  }

  Widget _categoryTag(String label, {bool isPrimary = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
      decoration: BoxDecoration(
        color: isPrimary ? AppColors.primary : AppColors.cardBg,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isPrimary ? Colors.transparent : Colors.white12,
        ),
      ),
      child: Text(
        label,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _featuredCard({
    required String title,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 85,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppColors.cardBg,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.white10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(icon, color: AppColors.cyan, size: 22),
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFallbackImage() {
    return Container(
      color: AppColors.cardBg,
      child: const Center(
        child: Icon(Icons.image_not_supported_outlined, color: AppColors.textSecondary, size: 40),
      ),
    );
  }
}