import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../core/constants/app_colors.dart';
import 'edit_profile_screen.dart';
import 'saved_items_screen.dart';
import 'package:fandom_verse1/screens/5_events/event_screens.dart';
import 'package:fandom_verse1/screens/6_store/wishlist_screen.dart';
import 'my_fandoms_screen.dart';
import 'bookmarks_screen.dart';
import 'purchase_history_screen.dart';
import 'settings_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // FIREBASE AUTH INSTANCE
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Dynamic User Profile Data
  String userName = 'User';
  String userTagline = 'Fandom Explorer';
  String userBio = 'Passionate about gaming, anime, and pop-culture fandoms!';
  String userEmail = '';
  String userPhone = '+92 300 1234567';
  String userGender = 'Male';

  // Dynamic Lists for Stats
  List<Map<String, String>> savedItems = [
    {'title': 'Marvel Cinematic Universe', 'category': 'Movies', 'rating': '4.9'},
    {'title': 'Cyberpunk 2077 Lore', 'category': 'Gaming', 'rating': '4.8'},
    {'title': 'Attack on Titan Season 4', 'category': 'Anime', 'rating': '4.9'},
  ];

  List<Map<String, String>> eventsList = [
    {'title': 'Comic-Con International 2026', 'date': '12 Oct, 2026', 'status': 'Confirmed'},
    {'title': 'Anime Expo Live Stream', 'date': '25 Nov, 2026', 'status': 'Upcoming'},
  ];

  List<Map<String, String>> wishlistItems = [
    {'title': 'Limited Edition Metal Poster', 'price': '\$49.99', 'stock': 'In Stock'},
    {'title': 'Cyberpunk Collector Figure', 'price': '\$129.99', 'stock': 'Pre-Order'},
  ];

  static const Color purpleLight = Color(0xFFB77AFF);

  @override
  void initState() {
    super.initState();
    _loadFirebaseUserData();
  }

  // FIREBASE DATA LOAD
  void _loadFirebaseUserData() {
    User? currentUser = _auth.currentUser;
    if (currentUser != null) {
      setState(() {
        userName = currentUser.displayName ?? (currentUser.email?.split('@').first ?? 'Fandom User');
        userEmail = currentUser.email ?? '';
      });
    }
  }

  // FIREBASE LOGOUT FUNCTION
  Future<void> _handleLogout() async {
    try {
      await _auth.signOut();
      if (mounted) {
        Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Logout me masla aaya: ${e.toString()}'),
            backgroundColor: AppColors.cardBg,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'My Profile',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          children: [
            const SizedBox(height: 10),

            // Profile Header
            _buildProfileHeader(),

            const SizedBox(height: 25),

            // Stat Cards (Saved, Events, Wishlist)
            Row(
              children: [
                Expanded(
                  child: _buildStatCard(
                    count: savedItems.length.toString().padLeft(2, '0'),
                    label: 'Saved',
                    onTap: () async {
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SavedItemsScreen(items: savedItems),
                        ),
                      );
                      setState(() {});
                    },
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildStatCard(
                    count: eventsList.length.toString().padLeft(2, '0'),
                    label: 'Events',
                    onTap: () async {
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EventsScreen(events: eventsList),
                        ),
                      );
                      setState(() {});
                    },
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildStatCard(
                    count: wishlistItems.length.toString().padLeft(2, '0'),
                    label: 'Wishlist',
                    onTap: () async {
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => WishlistScreen(wishlist: wishlistItems),
                        ),
                      );
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),

            const SizedBox(height: 30),

            // Menu Options
            _buildMenuItem(
              icon: Icons.favorite_border_rounded,
              iconColor: AppColors.pink,
              title: 'My Fandoms',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const MyFandomsScreen()),
                );
              },
            ),
            _buildMenuItem(
              icon: Icons.bookmark_border_rounded,
              iconColor: AppColors.pink,
              title: 'Bookmarks',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const BookmarksScreen()),
                );
              },
            ),
            _buildMenuItem(
              icon: Icons.receipt_long_rounded,
              iconColor: AppColors.pink,
              title: 'Purchase History',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const PurchaseHistoryScreen()),
                );
              },
            ),
            _buildMenuItem(
              icon: Icons.settings_outlined,
              iconColor: purpleLight,
              title: 'Settings',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SettingsScreen()),
                );
              },
            ),
            _buildMenuItem(
              icon: Icons.info_outline_rounded,
              iconColor: purpleLight,
              title: 'About Us',
              onTap: () => _showAboutDialog(),
            ),
            _buildMenuItem(
              icon: Icons.logout_rounded,
              iconColor: AppColors.cyan,
              title: 'Logout',
              onTap: () => _showLogoutDialog(),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(3),
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
                color: AppColors.primary.withValues(alpha: 0.5),
                blurRadius: 15,
                spreadRadius: 2,
              ),
            ],
          ),
          child: const CircleAvatar(
            radius: 42,
            backgroundColor: AppColors.cardBg,
            child: Icon(
              Icons.person_rounded,
              size: 45,
              color: Colors.white,
            ),
          ),
        ),
        const SizedBox(width: 18),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                userName,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                userTagline,
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.55),
                  fontSize: 13,
                ),
              ),
              const SizedBox(height: 10),
              OutlinedButton(
                onPressed: () => _openEditProfile(),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 6),
                  side: BorderSide(
                    color: Colors.white.withValues(alpha: 0.25),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  backgroundColor: AppColors.cardBg.withValues(alpha: 0.6),
                ),
                child: const Text(
                  'Edit Profile',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildStatCard({
    required String count,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: AppColors.cardBg,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: AppColors.primary.withValues(alpha: 0.25),
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withValues(alpha: 0.08),
              blurRadius: 10,
            ),
          ],
        ),
        child: Column(
          children: [
            Text(
              count,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.55),
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required Color iconColor,
    required String title,
    required VoidCallback onTap,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        onTap: onTap,
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        tileColor: AppColors.cardBg.withValues(alpha: 0.4),
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: iconColor.withValues(alpha: 0.15),
            shape: BoxShape.circle,
          ),
          child: Icon(
            icon,
            color: iconColor,
            size: 20,
          ),
        ),
        title: Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
        trailing: Icon(
          Icons.arrow_forward_ios_rounded,
          color: Colors.white.withValues(alpha: 0.3),
          size: 14,
        ),
      ),
    );
  }

  void _openEditProfile() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditProfileScreen(
          initialName: userName,
          initialTagline: userTagline,
          initialBio: userBio,
          initialEmail: userEmail,
          initialPhone: userPhone,
          initialGender: userGender,
        ),
      ),
    );

    if (result != null && result is Map<String, dynamic>) {
      setState(() {
        userName = result['name'] ?? userName;
        userTagline = result['tagline'] ?? userTagline;
        userBio = result['bio'] ?? userBio;
        userEmail = result['email'] ?? userEmail;
        userPhone = result['phone'] ?? userPhone;
        userGender = result['gender'] ?? userGender;
      });

      // Firebase Profile Update (DisplayName)
      User? currentUser = _auth.currentUser;
      if (currentUser != null && result['name'] != null) {
        await currentUser.updateDisplayName(result['name']);
      }

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Profile updated successfully!'),
            backgroundColor: AppColors.primary,
            duration: Duration(seconds: 2),
          ),
        );
      }
    }
  }

  void _showLogoutDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: AppColors.cardBg,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: const Text('Logout', style: TextStyle(color: Colors.white)),
          content: const Text(
            'Are you sure you want to log out from your account?',
            style: TextStyle(color: Colors.white70),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel', style: TextStyle(color: Colors.white54)),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: AppColors.pink),
              onPressed: () {
                Navigator.pop(context);
                _handleLogout();
              },
              child: const Text('Logout', style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }

  void _showAboutDialog() {
    showAboutDialog(
      context: context,
      applicationName: 'Fandom Explorer',
      applicationVersion: '1.0.0',
      applicationIcon: const Icon(Icons.auto_awesome, color: AppColors.pink, size: 40),
      children: [
        const Text('Explore your favorite fandoms, track events, and manage merchandise all in one place.'),
      ],
    );
  }
}