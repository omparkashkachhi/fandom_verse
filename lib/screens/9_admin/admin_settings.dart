import 'package:flutter/material.dart';

class AdminSettings extends StatefulWidget {
  const AdminSettings({super.key});

  @override
  State<AdminSettings> createState() => _AdminSettingsState();
}

class _AdminSettingsState extends State<AdminSettings> {
  final Color background = const Color(0xFF05021A);
  final Color panel = const Color(0xFF0C1333);
  final Color panelLight = const Color(0xFF151542);
  final Color purple = const Color(0xFF754DFF);
  final Color purpleLight = const Color(0xFFB77AFF);

  bool notifications = true;
  bool emailAlerts = true;
  bool maintenanceMode = false;
  bool autoModeration = true;

  String selectedLanguage = 'English';
  String selectedTheme = 'Dark Neon';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      body: Stack(
        children: [
          // Background
          Positioned.fill(
            child: Image.asset(
              'assets/images/fandom_background.png',
              fit: BoxFit.cover,
              opacity: const AlwaysStoppedAnimation(0.20),
            ),
          ),

          // Dark overlay
          Positioned.fill(
            child: Container(
              color: background.withOpacity(0.78),
            ),
          ),

          SafeArea(
            child: Column(
              children: [
                _topBar(),

                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.fromLTRB(
                      20,
                      20,
                      20,
                      35,
                    ),
                    child: Center(
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(
                          maxWidth: 1000,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _pageHeader(),

                            const SizedBox(height: 25),

                            _accountSection(),

                            const SizedBox(height: 20),

                            _appearanceSection(),

                            const SizedBox(height: 20),

                            _notificationSection(),

                            const SizedBox(height: 20),

                            _securitySection(),

                            const SizedBox(height: 20),

                            _systemSection(),

                            const SizedBox(height: 25),

                            _saveButton(),
                          ],
                        ),
                      ),
                    ),
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
  // TOP BAR
  // ============================================================

  Widget _topBar() {
    return Container(
      height: 76,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: const Color(0xFF080625).withOpacity(0.96),
        border: Border(
          bottom: BorderSide(
            color: purple.withOpacity(0.20),
          ),
        ),
      ),
      child: Row(
        children: [
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_rounded,
              color: Colors.white,
            ),
          ),

          const SizedBox(width: 5),

          Image.asset(
            'assets/images/fandom_logo_clean.png',
            width: 105,
            height: 55,
            fit: BoxFit.contain,
            errorBuilder: (context, error, stackTrace) {
              return const Text(
                'FANDOM',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              );
            },
          ),

          const SizedBox(width: 15),

          Expanded(
            child: Text(
              'Admin Settings',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),

          Container(
            height: 42,
            width: 42,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: const LinearGradient(
                colors: [
                  Color(0xFFFF4FD8),
                  Color(0xFF754DFF),
                  Color(0xFF19DFFF),
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
  // PAGE HEADER
  // ============================================================

  Widget _pageHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF1A1648),
            Color(0xFF0C1535),
          ],
        ),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: purple.withOpacity(0.35),
        ),
        boxShadow: [
          BoxShadow(
            color: purple.withOpacity(0.12),
            blurRadius: 25,
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            height: 58,
            width: 58,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(17),
              gradient: const LinearGradient(
                colors: [
                  Color(0xFFFF4FD8),
                  Color(0xFF754DFF),
                  Color(0xFF19DFFF),
                ],
              ),
            ),
            child: const Icon(
              Icons.settings_rounded,
              color: Colors.white,
              size: 28,
            ),
          ),

          const SizedBox(width: 16),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Settings',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.w800,
                  ),
                ),

                const SizedBox(height: 6),

                Text(
                  'Manage your Fandom 9_admin preferences and system settings.',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.55),
                    fontSize: 12,
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
  // ACCOUNT
  // ============================================================

  Widget _accountSection() {
    return _settingsCard(
      title: 'Account Settings',
      icon: Icons.person_outline_rounded,
      children: [
        _profileRow(),

        const SizedBox(height: 18),

        _settingTile(
          icon: Icons.lock_outline_rounded,
          title: 'Change Password',
          subtitle: 'Update your administrator password',
          trailing: const Icon(
            Icons.arrow_forward_ios_rounded,
            color: Colors.white38,
            size: 15,
          ),
          onTap: () {
            _showMessage('Change password option selected');
          },
        ),

        const SizedBox(height: 10),

        _settingTile(
          icon: Icons.email_outlined,
          title: 'Admin Email',
          subtitle: '9_admin@fandom.com',
          trailing: const Icon(
            Icons.edit_outlined,
            color: Colors.white38,
            size: 18,
          ),
          onTap: () {
            _showMessage('Email editing option selected');
          },
        ),
      ],
    );
  }

  Widget _profileRow() {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: panelLight.withOpacity(0.45),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Container(
            height: 52,
            width: 52,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: const LinearGradient(
                colors: [
                  Color(0xFFFF4FD8),
                  Color(0xFF754DFF),
                  Color(0xFF19DFFF),
                ],
              ),
            ),
            child: const Icon(
              Icons.admin_panel_settings_rounded,
              color: Colors.white,
              size: 27,
            ),
          ),

          const SizedBox(width: 14),

          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Administrator',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Super Admin',
                  style: TextStyle(
                    color: Colors.white54,
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ),

          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 6,
            ),
            decoration: BoxDecoration(
              color: Colors.green.withOpacity(0.12),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: Colors.green.withOpacity(0.25),
              ),
            ),
            child: const Text(
              'Active',
              style: TextStyle(
                color: Colors.greenAccent,
                fontSize: 10,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // APPEARANCE
  // ============================================================

  Widget _appearanceSection() {
    return _settingsCard(
      title: 'Appearance',
      icon: Icons.palette_outlined,
      children: [
        _dropdownTile(
          icon: Icons.language_rounded,
          title: 'Language',
          subtitle: 'Choose application language',
          value: selectedLanguage,
          items: const [
            'English',
            'Urdu',
          ],
          onChanged: (value) {
            if (value != null) {
              setState(() {
                selectedLanguage = value;
              });
            }
          },
        ),

        const SizedBox(height: 12),

        _dropdownTile(
          icon: Icons.dark_mode_outlined,
          title: 'Theme',
          subtitle: 'Application appearance',
          value: selectedTheme,
          items: const [
            'Dark Neon',
            'Dark',
          ],
          onChanged: (value) {
            if (value != null) {
              setState(() {
                selectedTheme = value;
              });
            }
          },
        ),
      ],
    );
  }

  // ============================================================
  // NOTIFICATIONS
  // ============================================================

  Widget _notificationSection() {
    return _settingsCard(
      title: 'Notifications',
      icon: Icons.notifications_none_rounded,
      children: [
        _switchTile(
          icon: Icons.notifications_active_outlined,
          title: 'Push Notifications',
          subtitle: 'Receive important 9_admin notifications',
          value: notifications,
          onChanged: (value) {
            setState(() {
              notifications = value;
            });
          },
        ),

        const SizedBox(height: 10),

        _switchTile(
          icon: Icons.mark_email_unread_outlined,
          title: 'Email Alerts',
          subtitle: 'Receive system alerts through email',
          value: emailAlerts,
          onChanged: (value) {
            setState(() {
              emailAlerts = value;
            });
          },
        ),
      ],
    );
  }

  // ============================================================
  // SECURITY
  // ============================================================

  Widget _securitySection() {
    return _settingsCard(
      title: 'Security',
      icon: Icons.security_outlined,
      children: [
        _switchTile(
          icon: Icons.auto_awesome_motion_outlined,
          title: 'Auto Moderation',
          subtitle: 'Automatically review reported content',
          value: autoModeration,
          onChanged: (value) {
            setState(() {
              autoModeration = value;
            });
          },
        ),

        const SizedBox(height: 10),

        _settingTile(
          icon: Icons.history_rounded,
          title: 'Login Activity',
          subtitle: 'View recent administrator login activity',
          trailing: const Icon(
            Icons.arrow_forward_ios_rounded,
            color: Colors.white38,
            size: 15,
          ),
          onTap: () {
            _showMessage('Login activity selected');
          },
        ),
      ],
    );
  }

  // ============================================================
  // SYSTEM
  // ============================================================

  Widget _systemSection() {
    return _settingsCard(
      title: 'System',
      icon: Icons.tune_rounded,
      children: [
        _switchTile(
          icon: Icons.build_circle_outlined,
          title: 'Maintenance Mode',
          subtitle: 'Temporarily disable user access',
          value: maintenanceMode,
          onChanged: (value) {
            setState(() {
              maintenanceMode = value;
            });
          },
        ),

        const SizedBox(height: 10),

        _settingTile(
          icon: Icons.info_outline_rounded,
          title: 'App Information',
          subtitle: 'Fandom • Version 1.0.0',
          trailing: const Icon(
            Icons.arrow_forward_ios_rounded,
            color: Colors.white38,
            size: 15,
          ),
          onTap: () {
            _showMessage('Fandom Version 1.0.0');
          },
        ),
      ],
    );
  }

  // ============================================================
  // SETTINGS CARD
  // ============================================================

  Widget _settingsCard({
    required String title,
    required IconData icon,
    required List<Widget> children,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: panel,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: purple.withOpacity(0.20),
        ),
        boxShadow: [
          BoxShadow(
            color: purple.withOpacity(0.07),
            blurRadius: 18,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                height: 42,
                width: 42,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(13),
                  color: purple.withOpacity(0.14),
                  border: Border.all(
                    color: purple.withOpacity(0.25),
                  ),
                ),
                child: Icon(
                  icon,
                  color: purpleLight,
                  size: 21,
                ),
              ),

              const SizedBox(width: 12),

              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),

          const SizedBox(height: 18),

          ...children,
        ],
      ),
    );
  }

  // ============================================================
  // SETTING TILE
  // ============================================================

  Widget _settingTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required Widget trailing,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: panelLight.withOpacity(0.45),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            Container(
              height: 42,
              width: 42,
              decoration: BoxDecoration(
                color: purple.withOpacity(0.12),
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
                    subtitle,
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.42),
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
            ),

            trailing,
          ],
        ),
      ),
    );
  }

  // ============================================================
  // SWITCH TILE
  // ============================================================

  Widget _switchTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 14,
        vertical: 10,
      ),
      decoration: BoxDecoration(
        color: panelLight.withOpacity(0.45),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Container(
            height: 42,
            width: 42,
            decoration: BoxDecoration(
              color: purple.withOpacity(0.12),
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
                  subtitle,
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.42),
                    fontSize: 10,
                  ),
                ),
              ],
            ),
          ),

          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: purpleLight,
            activeTrackColor: purple.withOpacity(0.45),
            inactiveThumbColor: Colors.white54,
            inactiveTrackColor: Colors.white12,
          ),
        ],
      ),
    );
  }

  // ============================================================
  // DROPDOWN TILE
  // ============================================================

  Widget _dropdownTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required String value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: panelLight.withOpacity(0.45),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Container(
            height: 42,
            width: 42,
            decoration: BoxDecoration(
              color: purple.withOpacity(0.12),
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
                  subtitle,
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.42),
                    fontSize: 10,
                  ),
                ),
              ],
            ),
          ),

          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
              color: background,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: purple.withOpacity(0.25),
              ),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: value,
                dropdownColor: const Color(0xFF151542),
                icon: Icon(
                  Icons.keyboard_arrow_down_rounded,
                  color: purpleLight,
                  size: 18,
                ),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 11,
                ),
                items: items.map((item) {
                  return DropdownMenuItem<String>(
                    value: item,
                    child: Text(item),
                  );
                }).toList(),
                onChanged: onChanged,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // SAVE BUTTON
  // ============================================================

  Widget _saveButton() {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [
              Color(0xFFFF4FD8),
              Color(0xFF754DFF),
              Color(0xFF19DFFF),
            ],
          ),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: purple.withOpacity(0.25),
              blurRadius: 18,
            ),
          ],
        ),
        child: ElevatedButton(
          onPressed: () {
            _showMessage('Settings saved successfully');
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          child: const Text(
            'Save Settings',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
    );
  }

  // ============================================================
  // MESSAGE
  // ============================================================

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: const Color(0xFF151542),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}