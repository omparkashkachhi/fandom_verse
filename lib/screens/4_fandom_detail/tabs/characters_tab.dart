import 'package:flutter/material.dart';

class CharactersTab extends StatefulWidget {
  const CharactersTab({super.key});

  @override
  State<CharactersTab> createState() => _CharactersTabState();
}

class _CharactersTabState extends State<CharactersTab> {
  // Theme Color Palette
  static const Color darkCardBg = Color(0xFF0D0D2B);
  static const Color neonPink = Color(0xFFEC4899);
  static const Color neonCyan = Color(0xFF06B6D4);
  static const Color neonPurple = Color(0xFF8B5CF6);

  String selectedFilter = 'All';
  String searchQuery = '';
  final TextEditingController searchController = TextEditingController();

  final List<String> filters = const ['All', 'Heroes', 'Villains', 'Supporting'];

  final List<Map<String, dynamic>> characters = const [
    {
      'name': 'Aron Shadowhart',
      'role': 'Hero',
      'power': 'Dark Energy Manipulation',
      'fandom': 'Mystic Warriors',
      'image': 'assets/images/anime1.jpg',
      'bio': 'Leader of the Eclipse Order. Master of dark energy sword techniques and ancient spell casting.',
      'stats': {'Power': '95', 'Speed': '88', 'Defense': '82'},
    },
    {
      'name': 'Lord Malakor',
      'role': 'Villain',
      'power': 'Void Corruption',
      'fandom': 'Mystic Warriors',
      'image': 'assets/images/gaming.jpg',
      'bio': 'Ruler of the Void Realms seeking to engulf the multiverse in absolute darkness.',
      'stats': {'Power': '99', 'Speed': '75', 'Defense': '90'},
    },
    {
      'name': 'Lyra Vance',
      'role': 'Hero',
      'power': 'Cybernetic Hacking',
      'fandom': 'Nova Realms',
      'image': 'assets/images/sci_fic.jpg',
      'bio': 'Elite hacker from Sector 7 specializing in AI override and pulse weapon mastery.',
      'stats': {'Power': '80', 'Speed': '92', 'Defense': '70'},
    },
    {
      'name': 'Zephyr',
      'role': 'Supporting',
      'power': 'Wind Teleportation',
      'fandom': 'Mystic Warriors',
      'image': 'assets/images/fantasy.jpg',
      'bio': 'A mysterious wanderer who guides young heroes through treacherous elemental realms.',
      'stats': {'Power': '78', 'Speed': '98', 'Defense': '65'},
    },
  ];

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  void _showCharacterDetails(BuildContext context, Map<String, dynamic> character) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: darkCardBg,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            top: 24,
            left: 20,
            right: 20,
            bottom: MediaQuery.of(context).viewInsets.bottom + 24,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Character Header Block
              Row(
                children: [
                  Container(
                    width: 70,
                    height: 70,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: neonCyan, width: 1.5),
                      gradient: LinearGradient(
                        colors: [
                          neonPurple.withOpacity(0.4),
                          neonPink.withOpacity(0.4),
                        ],
                      ),
                    ),
                    child: const Icon(Icons.person_rounded, color: Colors.white, size: 36),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          character['name'],
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                              decoration: BoxDecoration(
                                color: character['role'] == 'Hero'
                                    ? neonCyan.withOpacity(0.2)
                                    : character['role'] == 'Villain'
                                    ? neonPink.withOpacity(0.2)
                                    : neonPurple.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  color: character['role'] == 'Hero'
                                      ? neonCyan
                                      : character['role'] == 'Villain'
                                      ? neonPink
                                      : neonPurple,
                                  width: 0.8,
                                ),
                              ),
                              child: Text(
                                character['role'],
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              character['power'],
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.6),
                                fontSize: 11,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 18),

              // Bio
              Text(
                character['bio'],
                style: TextStyle(
                  color: Colors.white.withOpacity(0.75),
                  fontSize: 13,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 20),

              // Stats Section
              const Text(
                'Power Stats',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: (character['stats'] as Map<String, String>).entries.map((stat) {
                  return Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.04),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.white10),
                    ),
                    child: Column(
                      children: [
                        Text(
                          stat.value,
                          style: const TextStyle(
                            color: neonCyan,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          stat.key,
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.5),
                            fontSize: 11,
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // Search + Filter Logic
    final filteredCharacters = characters.where((char) {
      final matchesFilter = selectedFilter == 'All' ||
          char['role'].toString().toLowerCase() == selectedFilter.toLowerCase();
      final matchesSearch = char['name']
          .toString()
          .toLowerCase()
          .contains(searchQuery.toLowerCase());
      return matchesFilter && matchesSearch;
    }).toList();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Search Field
          TextField(
            controller: searchController,
            style: const TextStyle(color: Colors.white, fontSize: 14),
            onChanged: (val) => setState(() => searchQuery = val),
            decoration: InputDecoration(
              hintText: 'Search characters...',
              hintStyle: TextStyle(color: Colors.white.withOpacity(0.35), fontSize: 13),
              prefixIcon: Icon(Icons.search_rounded, color: Colors.white.withOpacity(0.4)),
              filled: true,
              fillColor: darkCardBg,
              contentPadding: const EdgeInsets.symmetric(vertical: 10),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: const BorderSide(color: Colors.white12),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: const BorderSide(color: Colors.white12),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: const BorderSide(color: neonCyan),
              ),
            ),
          ),
          const SizedBox(height: 14),

          // Role Filter Pills
          SizedBox(
            height: 34,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: filters.length,
              separatorBuilder: (_, __) => const SizedBox(width: 8),
              itemBuilder: (context, index) {
                final filter = filters[index];
                final isSelected = selectedFilter == filter;

                return GestureDetector(
                  onTap: () => setState(() => selectedFilter = filter),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                    decoration: BoxDecoration(
                      color: isSelected ? neonPurple.withOpacity(0.3) : darkCardBg,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: isSelected ? neonCyan : Colors.white12,
                        width: 1.2,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        filter,
                        style: TextStyle(
                          color: isSelected ? Colors.white : Colors.white54,
                          fontSize: 12,
                          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 16),

          // Characters Grid
          filteredCharacters.isEmpty
              ? const Expanded(
            child: Center(
              child: Text(
                'No characters found',
                style: TextStyle(color: Colors.white38, fontSize: 13),
              ),
            ),
          )
              : Expanded(
            child: GridView.builder(
              physics: const BouncingScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 0.82,
              ),
              itemCount: filteredCharacters.length,
              itemBuilder: (context, index) {
                final item = filteredCharacters[index];
                final Color roleColor = item['role'] == 'Hero'
                    ? neonCyan
                    : item['role'] == 'Villain'
                    ? neonPink
                    : neonPurple;

                return GestureDetector(
                  onTap: () => _showCharacterDetails(context, item),
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: darkCardBg,
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(
                        color: roleColor.withOpacity(0.3),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 55,
                          height: 55,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: roleColor.withOpacity(0.15),
                            border: Border.all(color: roleColor, width: 1.2),
                          ),
                          child: Icon(
                            Icons.person_rounded,
                            color: roleColor,
                            size: 30,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          item['name'],
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          item['power'],
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.5),
                            fontSize: 11,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(
                            color: roleColor.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            item['role'],
                            style: TextStyle(
                              color: roleColor,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
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
      ),
    );
  }
}