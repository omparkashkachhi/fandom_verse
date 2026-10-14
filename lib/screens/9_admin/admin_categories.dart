import 'package:flutter/material.dart';

class AdminCategories extends StatefulWidget {
  const AdminCategories({super.key});

  @override
  State<AdminCategories> createState() => _AdminCategoriesState();
}

class _AdminCategoriesState extends State<AdminCategories> {
  final Color purple = const Color(0xFF8B5CF6);
  final Color purpleLight = const Color(0xFFA78BFA);
  final Color pink = const Color(0xFFEC4899);
  final Color cyan = const Color(0xFF22D3EE);

  final TextEditingController searchController = TextEditingController();

  String selectedFilter = 'All';

  final List<Map<String, dynamic>> categories = [
    {
      'name': 'Anime',
      'description': 'Japanese animation and anime fandoms',
      'icon': Icons.auto_awesome,
      'color': Color(0xFFEC4899),
      'fandoms': 24,
      'status': 'Active',
    },
    {
      'name': 'Gaming',
      'description': 'Games, gamers and gaming communities',
      'icon': Icons.sports_esports_rounded,
      'color': Color(0xFF8B5CF6),
      'fandoms': 32,
      'status': 'Active',
    },
    {
      'name': 'Comics',
      'description': 'Superheroes, comics and graphic stories',
      'icon': Icons.menu_book_rounded,
      'color': Color(0xFFF59E0B),
      'fandoms': 18,
      'status': 'Active',
    },
    {
      'name': 'Sci-Fi',
      'description': 'Science fiction worlds and characters',
      'icon': Icons.rocket_launch_rounded,
      'color': Color(0xFF22D3EE),
      'fandoms': 15,
      'status': 'Active',
    },
    {
      'name': 'Movies',
      'description': 'Films and cinematic fandoms',
      'icon': Icons.movie_creation_outlined,
      'color': Color(0xFF6366F1),
      'fandoms': 27,
      'status': 'Active',
    },
    {
      'name': 'TV Shows',
      'description': 'Television series and communities',
      'icon': Icons.tv_rounded,
      'color': Color(0xFF14B8A6),
      'fandoms': 21,
      'status': 'Active',
    },
    {
      'name': 'Music',
      'description': 'Artists, bands and music fandoms',
      'icon': Icons.music_note_rounded,
      'color': Color(0xFFE879F9),
      'fandoms': 29,
      'status': 'Active',
    },
    {
      'name': 'Sports',
      'description': 'Sports teams, players and communities',
      'icon': Icons.sports_soccer_rounded,
      'color': Color(0xFF10B981),
      'fandoms': 16,
      'status': 'Inactive',
    },
  ];

  List<Map<String, dynamic>> get filteredCategories {
    final query = searchController.text.toLowerCase();

    return categories.where((category) {
      final matchesSearch =
      category['name'].toString().toLowerCase().contains(query);

      final matchesFilter = selectedFilter == 'All' ||
          category['status'] == selectedFilter;

      return matchesSearch && matchesFilter;
    }).toList();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF070711),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/fandom_background.png',
              fit: BoxFit.cover,
            ),
          ),

          Positioned.fill(
            child: Container(
              color: const Color(0xFF070711).withOpacity(0.91),
            ),
          ),

          SafeArea(
            child: Column(
              children: [
                _topBar(),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(24, 10, 24, 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _header(),
                        const SizedBox(height: 22),
                        _stats(),
                        const SizedBox(height: 26),
                        _searchAndFilter(),
                        const SizedBox(height: 22),
                        _categoryGrid(),
                      ],
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

  // ================= TOP BAR =================

  Widget _topBar() {
    return Container(
      height: 76,
      padding: const EdgeInsets.symmetric(horizontal: 24),
      decoration: BoxDecoration(
        color: const Color(0xFF090914).withOpacity(0.88),
        border: Border(
          bottom: BorderSide(
            color: purple.withOpacity(0.18),
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
              Icons.arrow_back_ios_new_rounded,
              color: Colors.white70,
              size: 19,
            ),
          ),

          const SizedBox(width: 8),

          Image.asset(
            'assets/images/fandom_logo_clean.png',
            width: 110,
            height: 52,
            fit: BoxFit.contain,
          ),

          const Spacer(),

          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 13,
              vertical: 8,
            ),
            decoration: BoxDecoration(
              color: purple.withOpacity(0.10),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: purple.withOpacity(0.25),
              ),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.admin_panel_settings_outlined,
                  color: purpleLight,
                  size: 17,
                ),
                const SizedBox(width: 7),
                const Text(
                  'Admin',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ================= HEADER =================

  Widget _header() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Categories Management',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 26,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 0.2,
                ),
              ),
              const SizedBox(height: 7),
              Text(
                'Manage fandom categories and organize communities.',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.50),
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ),

        ElevatedButton.icon(
          onPressed: _showAddCategoryDialog,
          icon: const Icon(
            Icons.add_rounded,
            size: 19,
          ),
          label: const Text(
            'Add Category',
            style: TextStyle(
              fontWeight: FontWeight.w700,
            ),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: purple,
            foregroundColor: Colors.white,
            elevation: 8,
            shadowColor: purple.withOpacity(0.35),
            padding: const EdgeInsets.symmetric(
              horizontal: 18,
              vertical: 14,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(13),
            ),
          ),
        ),
      ],
    );
  }

  // ================= STATS =================

  Widget _stats() {
    return Row(
      children: [
        Expanded(
          child: _statCard(
            'Total Categories',
            '${categories.length}',
            Icons.category_outlined,
            purple,
          ),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: _statCard(
            'Active',
            '${categories.where((e) => e['status'] == 'Active').length}',
            Icons.check_circle_outline_rounded,
            cyan,
          ),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: _statCard(
            'Total Fandoms',
            '182',
            Icons.groups_outlined,
            pink,
          ),
        ),
      ],
    );
  }

  Widget _statCard(
      String title,
      String value,
      IconData icon,
      Color color,
      ) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFF10101D).withOpacity(0.90),
        borderRadius: BorderRadius.circular(17),
        border: Border.all(
          color: color.withOpacity(0.18),
        ),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.06),
            blurRadius: 20,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            height: 44,
            width: 44,
            decoration: BoxDecoration(
              color: color.withOpacity(0.12),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              icon,
              color: color,
              size: 22,
            ),
          ),
          const SizedBox(width: 13),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: Colors.white.withOpacity(0.45),
                  fontSize: 11,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ================= SEARCH =================

  Widget _searchAndFilter() {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 48,
            decoration: BoxDecoration(
              color: const Color(0xFF10101D),
              borderRadius: BorderRadius.circular(13),
              border: Border.all(
                color: Colors.white.withOpacity(0.08),
              ),
            ),
            child: TextField(
              controller: searchController,
              onChanged: (_) {
                setState(() {});
              },
              style: const TextStyle(
                color: Colors.white,
                fontSize: 13,
              ),
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Search categories...',
                hintStyle: TextStyle(
                  color: Colors.white.withOpacity(0.32),
                ),
                prefixIcon: Icon(
                  Icons.search_rounded,
                  color: Colors.white.withOpacity(0.40),
                  size: 20,
                ),
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 14,
                ),
              ),
            ),
          ),
        ),

        const SizedBox(width: 12),

        Container(
          height: 48,
          padding: const EdgeInsets.symmetric(horizontal: 14),
          decoration: BoxDecoration(
            color: const Color(0xFF10101D),
            borderRadius: BorderRadius.circular(13),
            border: Border.all(
              color: Colors.white.withOpacity(0.08),
            ),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: selectedFilter,
              dropdownColor: const Color(0xFF171725),
              icon: const Icon(
                Icons.keyboard_arrow_down_rounded,
                color: Colors.white54,
              ),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
              ),
              items: ['All', 'Active', 'Inactive']
                  .map(
                    (item) => DropdownMenuItem(
                  value: item,
                  child: Text(item),
                ),
              )
                  .toList(),
              onChanged: (value) {
                if (value != null) {
                  setState(() {
                    selectedFilter = value;
                  });
                }
              },
            ),
          ),
        ),
      ],
    );
  }

  // ================= CATEGORY GRID =================

  Widget _categoryGrid() {
    final items = filteredCategories;

    if (items.isEmpty) {
      return Container(
        width: double.infinity,
        padding: const EdgeInsets.all(40),
        decoration: BoxDecoration(
          color: const Color(0xFF10101D),
          borderRadius: BorderRadius.circular(18),
        ),
        child: Column(
          children: [
            Icon(
              Icons.search_off_rounded,
              color: Colors.white.withOpacity(0.35),
              size: 42,
            ),
            const SizedBox(height: 12),
            const Text(
              'No categories found',
              style: TextStyle(
                color: Colors.white70,
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      );
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;

        int columns = 4;

        if (width < 900) {
          columns = 3;
        }

        if (width < 650) {
          columns = 2;
        }

        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: items.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: columns,
            crossAxisSpacing: 15,
            mainAxisSpacing: 15,
            childAspectRatio: 1.38,
          ),
          itemBuilder: (context, index) {
            return _categoryCard(items[index]);
          },
        );
      },
    );
  }

  Widget _categoryCard(Map<String, dynamic> category) {
    final Color color = category['color'];

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFF10101D).withOpacity(0.94),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: color.withOpacity(0.18),
        ),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.05),
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
                height: 46,
                width: 46,
                decoration: BoxDecoration(
                  color: color.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(13),
                ),
                child: Icon(
                  category['icon'],
                  color: color,
                  size: 23,
                ),
              ),

              const Spacer(),

              PopupMenuButton<String>(
                color: const Color(0xFF191925),
                icon: Icon(
                  Icons.more_vert_rounded,
                  color: Colors.white.withOpacity(0.45),
                  size: 20,
                ),
                onSelected: (value) {
                  if (value == 'edit') {
                    _showEditCategoryDialog(category);
                  }

                  if (value == 'delete') {
                    _showDeleteDialog(category);
                  }
                },
                itemBuilder: (context) => const [
                  PopupMenuItem(
                    value: 'edit',
                    child: Row(
                      children: [
                        Icon(
                          Icons.edit_outlined,
                          color: Colors.white70,
                          size: 18,
                        ),
                        SizedBox(width: 10),
                        Text(
                          'Edit',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  PopupMenuItem(
                    value: 'delete',
                    child: Row(
                      children: [
                        Icon(
                          Icons.delete_outline_rounded,
                          color: Colors.redAccent,
                          size: 18,
                        ),
                        SizedBox(width: 10),
                        Text(
                          'Delete',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),

          const Spacer(),

          Text(
            category['name'],
            style: const TextStyle(
              color: Colors.white,
              fontSize: 17,
              fontWeight: FontWeight.w800,
            ),
          ),

          const SizedBox(height: 5),

          Text(
            category['description'],
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: Colors.white.withOpacity(0.42),
              fontSize: 11,
              height: 1.4,
            ),
          ),

          const SizedBox(height: 13),

          Row(
            children: [
              Icon(
                Icons.groups_outlined,
                color: color,
                size: 16,
              ),
              const SizedBox(width: 6),
              Text(
                '${category['fandoms']} Fandoms',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.60),
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                ),
              ),

              const Spacer(),

              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: category['status'] == 'Active'
                      ? Colors.green.withOpacity(0.10)
                      : Colors.red.withOpacity(0.10),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  category['status'],
                  style: TextStyle(
                    color: category['status'] == 'Active'
                        ? Colors.greenAccent
                        : Colors.redAccent,
                    fontSize: 9,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ================= ADD CATEGORY =================

  void _showAddCategoryDialog() {
    final nameController = TextEditingController();
    final descriptionController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return _categoryDialog(
          title: 'Add New Category',
          buttonText: 'Add Category',
          nameController: nameController,
          descriptionController: descriptionController,
          onSave: () {
            if (nameController.text.trim().isEmpty) return;

            setState(() {
              categories.add({
                'name': nameController.text.trim(),
                'description': descriptionController.text.trim().isEmpty
                    ? 'New fandom category'
                    : descriptionController.text.trim(),
                'icon': Icons.category_outlined,
                'color': purple,
                'fandoms': 0,
                'status': 'Active',
              });
            });

            Navigator.pop(context);
          },
        );
      },
    );
  }

  // ================= EDIT CATEGORY =================

  void _showEditCategoryDialog(Map<String, dynamic> category) {
    final nameController =
    TextEditingController(text: category['name']);

    final descriptionController =
    TextEditingController(text: category['description']);

    showDialog(
      context: context,
      builder: (context) {
        return _categoryDialog(
          title: 'Edit Category',
          buttonText: 'Save Changes',
          nameController: nameController,
          descriptionController: descriptionController,
          onSave: () {
            if (nameController.text.trim().isEmpty) return;

            setState(() {
              category['name'] = nameController.text.trim();
              category['description'] =
                  descriptionController.text.trim();
            });

            Navigator.pop(context);
          },
        );
      },
    );
  }

  // ================= CATEGORY DIALOG =================

  Widget _categoryDialog({
    required String title,
    required String buttonText,
    required TextEditingController nameController,
    required TextEditingController descriptionController,
    required VoidCallback onSave,
  }) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        width: 430,
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: const Color(0xFF11111D),
          borderRadius: BorderRadius.circular(22),
          border: Border.all(
            color: purple.withOpacity(0.25),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  height: 42,
                  width: 42,
                  decoration: BoxDecoration(
                    color: purple.withOpacity(0.12),
                    borderRadius: BorderRadius.circular(11),
                  ),
                  child: Icon(
                    Icons.category_outlined,
                    color: purpleLight,
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 22),

            _dialogField(
              controller: nameController,
              label: 'Category Name',
              hint: 'e.g. Anime',
            ),

            const SizedBox(height: 15),

            _dialogField(
              controller: descriptionController,
              label: 'Description',
              hint: 'Enter category description',
              maxLines: 3,
            ),

            const SizedBox(height: 24),

            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
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

                const SizedBox(width: 10),

                ElevatedButton(
                  onPressed: onSave,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: purple,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 18,
                      vertical: 12,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(11),
                    ),
                  ),
                  child: Text(
                    buttonText,
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _dialogField({
    required TextEditingController controller,
    required String label,
    required String hint,
    int maxLines = 1,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Colors.white70,
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),

        const SizedBox(height: 7),

        TextField(
          controller: controller,
          maxLines: maxLines,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 13,
          ),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(
              color: Colors.white.withOpacity(0.25),
            ),
            filled: true,
            fillColor: const Color(0xFF191925),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(11),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(11),
              borderSide: BorderSide(
                color: purple.withOpacity(0.55),
              ),
            ),
          ),
        ),
      ],
    );
  }

  // ================= DELETE =================

  void _showDeleteDialog(Map<String, dynamic> category) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: const Color(0xFF151521),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          title: const Text(
            'Delete Category?',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w800,
            ),
          ),
          content: Text(
            'Are you sure you want to delete "${category['name']}"?',
            style: TextStyle(
              color: Colors.white.withOpacity(0.55),
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
                setState(() {
                  categories.remove(category);
                });

                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent,
                foregroundColor: Colors.white,
              ),
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }
}