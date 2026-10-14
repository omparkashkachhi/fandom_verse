import 'package:flutter/material.dart';

class AdminFandom extends StatefulWidget {
  const AdminFandom({super.key});

  @override
  State<AdminFandom> createState() => _AdminFandomState();
}

class _AdminFandomState extends State<AdminFandom> {
  final Color background = const Color(0xFF05021A);
  final Color panel = const Color(0xFF0C1333);
  final Color panelLight = const Color(0xFF151542);
  final Color purple = const Color(0xFF754DFF);
  final Color purpleLight = const Color(0xFFB77AFF);

  String searchText = '';

  final List<Map<String, dynamic>> fandoms = [
    {
      'name': 'Movies',
      'category': 'Entertainment',
      'fans': '24.8K',
      'status': 'Active',
      'icon': Icons.movie_outlined,
    },
    {
      'name': 'Music',
      'category': 'Entertainment',
      'fans': '32.4K',
      'status': 'Active',
      'icon': Icons.music_note_outlined,
    },
    {
      'name': 'Anime',
      'category': 'Anime',
      'fans': '18.6K',
      'status': 'Active',
      'icon': Icons.auto_awesome_outlined,
    },
    {
      'name': 'Gaming',
      'category': 'Gaming',
      'fans': '21.9K',
      'status': 'Active',
      'icon': Icons.sports_esports_outlined,
    },
    {
      'name': 'Marvel',
      'category': 'Movies',
      'fans': '15.2K',
      'status': 'Active',
      'icon': Icons.flash_on_outlined,
    },
    {
      'name': 'K-Pop',
      'category': 'Music',
      'fans': '12.7K',
      'status': 'Inactive',
      'icon': Icons.mic_none_outlined,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      body: SafeArea(
        child: Column(
          children: [
            _topBar(),

            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _pageHeader(),

                    const SizedBox(height: 25),

                    _summaryCards(),

                    const SizedBox(height: 25),

                    _fandomSection(),
                  ],
                ),
              ),
            ),
          ],
        ),
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
        color: const Color(0xFF080625),
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

          const Expanded(
            child: Text(
              'Fandom Management',
              style: TextStyle(
                color: Colors.white,
                fontSize: 21,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),

          _topIcon(
            Icons.notifications_none_rounded,
          ),

          const SizedBox(width: 10),

          Container(
            height: 42,
            width: 42,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
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
  // TOP ICON
  // ============================================================

  Widget _topIcon(IconData icon) {
    return Container(
      height: 42,
      width: 42,
      decoration: BoxDecoration(
        color: panel,
        shape: BoxShape.circle,
        border: Border.all(
          color: purple.withOpacity(0.30),
        ),
      ),
      child: Icon(
        icon,
        color: Colors.white,
        size: 21,
      ),
    );
  }

  // ============================================================
  // PAGE HEADER
  // ============================================================

  Widget _pageHeader() {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 600) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _headerText(),

              const SizedBox(height: 18),

              _addButton(),
            ],
          );
        }

        return Row(
          children: [
            Expanded(
              child: _headerText(),
            ),

            _addButton(),
          ],
        );
      },
    );
  }

  // ============================================================
  // HEADER TEXT
  // ============================================================

  Widget _headerText() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Manage Fandoms ✨',
          style: TextStyle(
            color: Colors.white,
            fontSize: 26,
            fontWeight: FontWeight.w800,
          ),
        ),

        const SizedBox(height: 7),

        Text(
          'Create, manage and organize your fandom communities.',
          style: TextStyle(
            color: Colors.white.withOpacity(0.52),
            fontSize: 13,
          ),
        ),
      ],
    );
  }

  // ============================================================
  // ADD BUTTON
  // ============================================================

  Widget _addButton() {
    return ElevatedButton.icon(
      onPressed: () {
        _showAddFandomDialog();
      },
      icon: const Icon(
        Icons.add_rounded,
        size: 20,
      ),
      label: const Text(
        'Add New Fandom',
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: purple,
        foregroundColor: Colors.white,
        elevation: 8,
        shadowColor: purple.withOpacity(0.40),
        padding: const EdgeInsets.symmetric(
          horizontal: 18,
          vertical: 15,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );
  }

  // ============================================================
  // SUMMARY CARDS
  // ============================================================

  Widget _summaryCards() {
    return LayoutBuilder(
      builder: (context, constraints) {
        int columns = 1;

        if (constraints.maxWidth >= 1000) {
          columns = 3;
        } else if (constraints.maxWidth >= 600) {
          columns = 2;
        }

        final cards = [
          {
            'title': 'Total Fandoms',
            'value': '248',
            'icon': Icons.auto_awesome_outlined,
          },
          {
            'title': 'Active Fandoms',
            'value': '232',
            'icon': Icons.check_circle_outline_rounded,
          },
          {
            'title': 'Total Fans',
            'value': '12.8K',
            'icon': Icons.people_outline_rounded,
          },
        ];

        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: cards.length,
          gridDelegate:
          SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: columns,
            crossAxisSpacing: 15,
            mainAxisSpacing: 15,
            childAspectRatio: columns == 1 ? 3.0 : 2.3,
          ),
          itemBuilder: (context, index) {
            return _summaryCard(
              title: cards[index]['title'] as String,
              value: cards[index]['value'] as String,
              icon: cards[index]['icon'] as IconData,
            );
          },
        );
      },
    );
  }

  // ============================================================
  // SUMMARY CARD
  // ============================================================

  Widget _summaryCard({
    required String title,
    required String value,
    required IconData icon,
  }) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: panel,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: purple.withOpacity(0.22),
        ),
        boxShadow: [
          BoxShadow(
            color: purple.withOpacity(0.08),
            blurRadius: 18,
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            height: 52,
            width: 52,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              gradient: const LinearGradient(
                colors: [
                  Color(0xFFFF4FD8),
                  Color(0xFF754DFF),
                  Color(0xFF19DFFF),
                ],
              ),
            ),
            child: Icon(
              icon,
              color: Colors.white,
              size: 25,
            ),
          ),

          const SizedBox(width: 14),

          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: Colors.white.withOpacity(0.48),
                  fontSize: 11,
                ),
              ),

              const SizedBox(height: 4),

              Text(
                value,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ============================================================
  // FANDOM SECTION
  // ============================================================

  Widget _fandomSection() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: panel,
        borderRadius: BorderRadius.circular(23),
        border: Border.all(
          color: purple.withOpacity(0.20),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionHeader(),

          const SizedBox(height: 20),

          _searchBar(),

          const SizedBox(height: 20),

          _fandomGrid(),
        ],
      ),
    );
  }

  // ============================================================
  // SECTION HEADER
  // ============================================================

  Widget _sectionHeader() {
    return Row(
      children: [
        const Expanded(
          child: Text(
            'All Fandoms',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),

        Text(
          '${fandoms.length} fandoms',
          style: TextStyle(
            color: purpleLight,
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  // ============================================================
  // SEARCH BAR
  // ============================================================

  Widget _searchBar() {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: panelLight.withOpacity(0.60),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: purple.withOpacity(0.25),
        ),
      ),
      child: TextField(
        onChanged: (value) {
          setState(() {
            searchText = value.toLowerCase();
          });
        },
        style: const TextStyle(
          color: Colors.white,
          fontSize: 13,
        ),
        decoration: InputDecoration(
          hintText: 'Search fandoms...',
          hintStyle: TextStyle(
            color: Colors.white.withOpacity(0.35),
          ),
          prefixIcon: Icon(
            Icons.search_rounded,
            color: purpleLight,
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            vertical: 15,
          ),
        ),
      ),
    );
  }

  // ============================================================
  // FANDOM GRID
  // ============================================================

  Widget _fandomGrid() {
    final filteredFandoms = fandoms.where((fandom) {
      return fandom['name']
          .toString()
          .toLowerCase()
          .contains(searchText);
    }).toList();

    if (filteredFandoms.isEmpty) {
      return Padding(
        padding: const EdgeInsets.all(30),
        child: Center(
          child: Column(
            children: [
              Icon(
                Icons.search_off_rounded,
                color: purpleLight,
                size: 45,
              ),

              const SizedBox(height: 10),

              Text(
                'No fandom found',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.60),
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        int columns = 1;

        if (constraints.maxWidth >= 1100) {
          columns = 3;
        } else if (constraints.maxWidth >= 650) {
          columns = 2;
        }

        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: filteredFandoms.length,
          gridDelegate:
          SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: columns,
            crossAxisSpacing: 14,
            mainAxisSpacing: 14,
            childAspectRatio: columns == 1 ? 3.0 : 1.65,
          ),
          itemBuilder: (context, index) {
            final fandom = filteredFandoms[index];

            return _fandomCard(
              name: fandom['name'],
              category: fandom['category'],
              fans: fandom['fans'],
              status: fandom['status'],
              icon: fandom['icon'],
            );
          },
        );
      },
    );
  }

  // ============================================================
  // FANDOM CARD
  // ============================================================

  Widget _fandomCard({
    required String name,
    required String category,
    required String fans,
    required String status,
    required IconData icon,
  }) {
    final bool active = status == 'Active';

    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF191545),
            Color(0xFF0C1535),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: purple.withOpacity(0.25),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                height: 48,
                width: 48,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xFFFF4FD8),
                      Color(0xFF754DFF),
                      Color(0xFF19DFFF),
                    ],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: purple.withOpacity(0.30),
                      blurRadius: 13,
                    ),
                  ],
                ),
                child: Icon(
                  icon,
                  color: Colors.white,
                  size: 23,
                ),
              ),

              const SizedBox(width: 11),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                      ),
                    ),

                    const SizedBox(height: 3),

                    Text(
                      category,
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.43),
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
              ),

              _statusBadge(
                active,
              ),
            ],
          ),

          const Spacer(),

          Row(
            children: [
              Icon(
                Icons.people_outline_rounded,
                color: purpleLight,
                size: 16,
              ),

              const SizedBox(width: 5),

              Text(
                '$fans Fans',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.55),
                  fontSize: 11,
                ),
              ),

              const Spacer(),

              _actionButton(
                Icons.edit_outlined,
                    () {
                  _showMessage('Edit $name');
                },
              ),

              const SizedBox(width: 7),

              _actionButton(
                Icons.delete_outline_rounded,
                    () {
                  _showDeleteDialog(name);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ============================================================
  // STATUS BADGE
  // ============================================================

  Widget _statusBadge(bool active) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 5,
      ),
      decoration: BoxDecoration(
        color: active
            ? const Color(0xFF20D9A0).withOpacity(0.12)
            : Colors.red.withOpacity(0.12),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        active ? 'Active' : 'Inactive',
        style: TextStyle(
          color: active
              ? const Color(0xFF45E6B0)
              : const Color(0xFFFF6B81),
          fontSize: 9,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  // ============================================================
  // ACTION BUTTON
  // ============================================================

  Widget _actionButton(
      IconData icon,
      VoidCallback onTap,
      ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 32,
        width: 32,
        decoration: BoxDecoration(
          color: purple.withOpacity(0.12),
          borderRadius: BorderRadius.circular(9),
        ),
        child: Icon(
          icon,
          color: purpleLight,
          size: 16,
        ),
      ),
    );
  }

  // ============================================================
  // ADD FANDOM DIALOG
  // ============================================================

  void _showAddFandomDialog() {
    final TextEditingController nameController =
    TextEditingController();

    final TextEditingController categoryController =
    TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: const Color(0xFF0C1333),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(22),
          ),
          title: const Text(
            'Add New Fandom',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _dialogField(
                controller: nameController,
                hint: 'Fandom name',
                icon: Icons.auto_awesome_outlined,
              ),

              const SizedBox(height: 12),

              _dialogField(
                controller: categoryController,
                hint: 'Category',
                icon: Icons.category_outlined,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                'Cancel',
                style: TextStyle(
                  color: Colors.white54,
                ),
              ),
            ),

            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);

                _showMessage(
                  'Fandom added successfully',
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: purple,
                foregroundColor: Colors.white,
              ),
              child: const Text(
                'Add Fandom',
              ),
            ),
          ],
        );
      },
    );
  }

  // ============================================================
  // DIALOG FIELD
  // ============================================================

  Widget _dialogField({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
  }) {
    return TextField(
      controller: controller,
      style: const TextStyle(
        color: Colors.white,
      ),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(
          color: Colors.white38,
        ),
        prefixIcon: Icon(
          icon,
          color: purpleLight,
        ),
        filled: true,
        fillColor: panelLight,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(13),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  // ============================================================
  // DELETE DIALOG
  // ============================================================

  void _showDeleteDialog(String name) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: const Color(0xFF0C1333),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(22),
          ),
          title: const Text(
            'Delete Fandom?',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Text(
            'Are you sure you want to delete $name?',
            style: const TextStyle(
              color: Colors.white60,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                'Cancel',
                style: TextStyle(
                  color: Colors.white54,
                ),
              ),
            ),

            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);

                _showMessage(
                  '$name deleted',
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFE84A6A),
                foregroundColor: Colors.white,
              ),
              child: const Text(
                'Delete',
              ),
            ),
          ],
        );
      },
    );
  }

  // ============================================================
  // MESSAGE
  // ============================================================

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: purple,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}