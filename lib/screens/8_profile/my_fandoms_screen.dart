import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';

class MyFandomsScreen extends StatefulWidget {
  const MyFandomsScreen({super.key});

  @override
  State<MyFandomsScreen> createState() => _MyFandomsScreenState();
}

class _MyFandomsScreenState extends State<MyFandomsScreen> {
  // Fandom List with detailed data
  List<Map<String, String>> fandoms = [
    {'name': 'Marvel Universe', 'category': 'Comics & Movies', 'members': '124K'},
    {'name': 'Anime & Manga', 'category': 'Japanese Pop', 'members': '340K'},
    {'name': 'Gaming Lore', 'category': 'Esports & Gaming', 'members': '89K'},
    {'name': 'Star Wars', 'category': 'Sci-Fi', 'members': '210K'},
  ];

  // Available Fandoms to join in Add Dialog
  final List<Map<String, String>> availableFandoms = [
    {'name': 'DC Cinematic', 'category': 'Comics & Movies', 'members': '95K'},
    {'name': 'Cyberpunk 2077', 'category': 'Gaming', 'members': '64K'},
    {'name': 'Genshin Impact', 'category': 'Anime & Gaming', 'members': '180K'},
    {'name': 'K-Pop Universe', 'category': 'Music', 'members': '520K'},
  ];

  void _leaveFandom(int index) {
    final removedFandom = fandoms[index];
    setState(() {
      fandoms.removeAt(index);
    });

    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: AppColors.cardBg,
        content: Text('Left "${removedFandom['name']}" community'),
        action: SnackBarAction(
          label: 'UNDO',
          textColor: AppColors.cyan,
          onPressed: () {
            setState(() {
              fandoms.insert(index, removedFandom);
            });
          },
        ),
        duration: const Duration(seconds: 3),
      ),
    );
  }

  void _confirmLeave(int index) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: AppColors.cardBg,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: const Text('Leave Fandom?', style: TextStyle(color: Colors.white)),
          content: Text(
            'Are you sure you want to leave "${fandoms[index]['name']}"?',
            style: const TextStyle(color: Colors.white70),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel', style: TextStyle(color: Colors.white54)),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent),
              onPressed: () {
                Navigator.pop(context);
                _leaveFandom(index);
              },
              child: const Text('Leave', style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }

  void _showAddFandomDialog() {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.cardBg,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.white24,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 18),
              const Text(
                'Explore & Join Fandoms',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              Flexible(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: availableFandoms.length,
                  itemBuilder: (context, idx) {
                    final item = availableFandoms[idx];
                    final bool isJoined = fandoms.any((f) => f['name'] == item['name']);

                    return Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      decoration: BoxDecoration(
                        color: AppColors.background.withValues(alpha: 0.5),
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: Colors.white12),
                      ),
                      child: ListTile(
                        title: Text(item['name']!, style: const TextStyle(color: Colors.white, fontSize: 14)),
                        subtitle: Text('${item['category']} • ${item['members']} members',
                            style: const TextStyle(color: Colors.white54, fontSize: 12)),
                        trailing: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: isJoined ? Colors.grey : AppColors.primary,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                          ),
                          onPressed: isJoined
                              ? null
                              : () {
                            setState(() {
                              fandoms.add(item);
                            });
                            Navigator.pop(context);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Joined ${item['name']}!')),
                            );
                          },
                          child: Text(isJoined ? 'Joined' : 'Join', style: const TextStyle(color: Colors.white)),
                        ),
                      ),
                    );
                  },
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
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'My Fandoms',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add_circle_outline_rounded, color: AppColors.cyan, size: 24),
            onPressed: _showAddFandomDialog,
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: fandoms.isEmpty ? _buildEmptyState() : _buildFandomList(),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: AppColors.primary,
        icon: const Icon(Icons.explore_rounded, color: Colors.white),
        label: const Text('Discover More', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        onPressed: _showAddFandomDialog,
      ),
    );
  }

  Widget _buildFandomList() {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.all(16),
      itemCount: fandoms.length,
      itemBuilder: (context, index) {
        final item = fandoms[index];

        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          decoration: BoxDecoration(
            color: AppColors.cardBg.withValues(alpha: 0.6),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.white12),
          ),
          child: Material(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(16),
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              leading: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppColors.cyan.withValues(alpha: 0.15),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.groups_rounded, color: AppColors.cyan, size: 22),
              ),
              title: Text(
                item['name']!,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
              subtitle: Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: AppColors.pink.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        item['category'] ?? 'Community',
                        style: const TextStyle(
                          color: AppColors.pink,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    // Fix: Wrapped with Expanded and added text overflow handling
                    Expanded(
                      child: Text(
                        '${item['members'] ?? '10K'} members',
                        style: TextStyle(
                          color: Colors.white.withValues(alpha: 0.4),
                          fontSize: 11,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
              trailing: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: Colors.redAccent.withValues(alpha: 0.6)),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                ),
                onPressed: () => _confirmLeave(index),
                child: const Text(
                  'Leave',
                  style: TextStyle(
                    color: Colors.redAccent,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Opening ${item['name']} Feed...'),
                    duration: const Duration(seconds: 1),
                    backgroundColor: AppColors.cardBg,
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: AppColors.cardBg.withValues(alpha: 0.5),
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white12),
            ),
            child: const Icon(
              Icons.diversity_3_rounded,
              size: 64,
              color: AppColors.pink,
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'You Haven\'t Joined Any Fandoms',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Discover communities and connect with fellow fans!',
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.5),
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }
}