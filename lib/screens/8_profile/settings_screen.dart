import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../core/constants/app_colors.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // App Toggles
  bool pushNotifications = true;
  bool emailNotifications = false;
  bool darkMode = true;
  bool autoPlayVideos = true;

  // PASSWORD RESET FUNCTION
  Future<void> _sendPasswordResetEmail() async {
    User? user = _auth.currentUser;
    if (user != null && user.email != null) {
      try {
        await _auth.sendPasswordResetEmail(email: user.email!);
        if (mounted) {
          _showSnackBar('Password reset link sent to ${user.email}');
        }
      } catch (e) {
        if (mounted) {
          _showSnackBar('Error sending reset email: ${e.toString()}');
        }
      }
    } else {
      _showSnackBar('No logged-in user email found.');
    }
  }

  // LOGOUT FUNCTION
  Future<void> _handleLogout() async {
    try {
      await _auth.signOut();
      if (mounted) {
        Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
      }
    } catch (e) {
      if (mounted) {
        _showSnackBar('Error logging out: ${e.toString()}');
      }
    }
  }

  void _showSnackBar(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg),
        backgroundColor: AppColors.cardBg,
        duration: const Duration(seconds: 3),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    User? currentUser = _auth.currentUser;

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
          'Settings',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // SECTION: ACCOUNT
            _buildSectionHeader('Account Settings'),
            const SizedBox(height: 8),

            _buildTileContainer(
              children: [
                ListTile(
                  leading: const Icon(Icons.email_outlined, color: AppColors.pink),
                  title: const Text('Email Address', style: TextStyle(color: Colors.white, fontSize: 14)),
                  subtitle: Text(
                    currentUser?.email ?? 'Not available',
                    style: TextStyle(color: Colors.white.withValues(alpha: 0.5), fontSize: 12),
                  ),
                ),
                const Divider(color: Colors.white12, height: 1),
                ListTile(
                  leading: const Icon(Icons.lock_reset_rounded, color: AppColors.cyan),
                  title: const Text('Change Password', style: TextStyle(color: Colors.white, fontSize: 14)),
                  subtitle: const Text('Send password reset link to your email', style: TextStyle(color: Colors.white54, fontSize: 12)),
                  trailing: const Icon(Icons.arrow_forward_ios_rounded, color: Colors.white30, size: 14),
                  onTap: _showResetPasswordDialog,
                ),
              ],
            ),

            const SizedBox(height: 24),

            // SECTION: NOTIFICATIONS
            _buildSectionHeader('Preferences & Notifications'),
            const SizedBox(height: 8),

            _buildTileContainer(
              children: [
                SwitchListTile(
                  activeColor: AppColors.pink,
                  title: const Text('Push Notifications', style: TextStyle(color: Colors.white, fontSize: 14)),
                  subtitle: const Text('Get real-time updates for fandoms', style: TextStyle(color: Colors.white54, fontSize: 12)),
                  value: pushNotifications,
                  onChanged: (val) => setState(() => pushNotifications = val),
                ),
                const Divider(color: Colors.white12, height: 1),
                SwitchListTile(
                  activeColor: AppColors.pink,
                  title: const Text('Email Updates', style: TextStyle(color: Colors.white, fontSize: 14)),
                  subtitle: const Text('Receive event newsletters', style: TextStyle(color: Colors.white54, fontSize: 12)),
                  value: emailNotifications,
                  onChanged: (val) => setState(() => emailNotifications = val),
                ),
                const Divider(color: Colors.white12, height: 1),
                SwitchListTile(
                  activeColor: AppColors.pink,
                  title: const Text('Dark Theme', style: TextStyle(color: Colors.white, fontSize: 14)),
                  subtitle: const Text('Always keep dark mode on', style: TextStyle(color: Colors.white54, fontSize: 12)),
                  value: darkMode,
                  onChanged: (val) => setState(() => darkMode = val),
                ),
              ],
            ),

            const SizedBox(height: 24),

            // SECTION: APP DATA & CACHE
            _buildSectionHeader('Data & Privacy'),
            const SizedBox(height: 8),

            _buildTileContainer(
              children: [
                ListTile(
                  leading: const Icon(Icons.cleaning_services_rounded, color: AppColors.pink),
                  title: const Text('Clear Local Cache', style: TextStyle(color: Colors.white, fontSize: 14)),
                  subtitle: const Text('Free up storage space', style: TextStyle(color: Colors.white54, fontSize: 12)),
                  onTap: () {
                    _showSnackBar('Cache cleared successfully!');
                  },
                ),
                const Divider(color: Colors.white12, height: 1),
                ListTile(
                  leading: const Icon(Icons.privacy_tip_outlined, color: AppColors.cyan),
                  title: const Text('Privacy Policy', style: TextStyle(color: Colors.white, fontSize: 14)),
                  trailing: const Icon(Icons.arrow_forward_ios_rounded, color: Colors.white30, size: 14),
                  onTap: () {
                    _showSnackBar('Privacy Policy page coming soon');
                  },
                ),
              ],
            ),

            const SizedBox(height: 32),

            // LOGOUT BUTTON
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.cardBg,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                    side: BorderSide(color: Colors.redAccent.withValues(alpha: 0.5)),
                  ),
                ),
                icon: const Icon(Icons.logout_rounded, color: Colors.redAccent, size: 20),
                label: const Text(
                  'Log Out',
                  style: TextStyle(
                    color: Colors.redAccent,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onPressed: _showLogoutConfirmDialog,
              ),
            ),

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 4),
      child: Text(
        title.toUpperCase(),
        style: TextStyle(
          color: Colors.white.withValues(alpha: 0.5),
          fontSize: 11,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.2,
        ),
      ),
    );
  }

  Widget _buildTileContainer({required List<Widget> children}) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.cardBg.withValues(alpha: 0.6),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.white12),
      ),
      child: Column(children: children),
    );
  }

  void _showResetPasswordDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: AppColors.cardBg,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: const Text('Reset Password', style: TextStyle(color: Colors.white)),
          content: const Text(
            'We will send a password reset link to your registered email address.',
            style: TextStyle(color: Colors.white70),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel', style: TextStyle(color: Colors.white54)),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary),
              onPressed: () {
                Navigator.pop(context);
                _sendPasswordResetEmail();
              },
              child: const Text('Send Email', style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }

  void _showLogoutConfirmDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: AppColors.cardBg,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: const Text('Log Out', style: TextStyle(color: Colors.white)),
          content: const Text(
            'Are you sure you want to log out?',
            style: TextStyle(color: Colors.white70),
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
                _handleLogout();
              },
              child: const Text('Log Out', style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }
}