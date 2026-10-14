import 'package:flutter/material.dart';

class LeaderboardPage extends StatefulWidget {
  const LeaderboardPage({super.key});

  @override
  State<LeaderboardPage> createState() => _LeaderboardPageState();
}

class _LeaderboardPageState extends State<LeaderboardPage> {
  int selectedTimeframe = 0; // 0: Weekly, 1: Monthly, 2: All Time
  final List<String> timeframes = ['Weekly', 'Monthly', 'All Time'];

  // Search Controller & Query
  final TextEditingController searchController = TextEditingController();
  String searchQuery = '';

  // All Users List
  final List<Map<String, dynamic>> allUsers = const [
    {
      'rank': 4,
      'name': 'Ayesha Khan',
      'username': '@ayesha',
      'points': '8,420',
      'streak': '🔥 12d',
      'icon': Icons.person_rounded,
    },
    {
      'rank': 5,
      'name': 'Hamza Ali',
      'username': '@hamza',
      'points': '7,980',
      'streak': '🔥 8d',
      'icon': Icons.person_rounded,
    },
    {
      'rank': 6,
      'name': 'Sara Ahmed',
      'username': '@sara',
      'points': '7,650',
      'streak': '🔥 5d',
      'icon': Icons.person_rounded,
    },
    {
      'rank': 7,
      'name': 'Zain Malik',
      'username': '@zain',
      'points': '7,210',
      'streak': '🔥 3d',
      'icon': Icons.person_rounded,
    },
    {
      'rank': 8,
      'name': 'Bilal Hassan',
      'username': '@bilal',
      'points': '6,950',
      'streak': '🔥 2d',
      'icon': Icons.person_rounded,
    },
  ];

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  // Real-time Working Search Filter Logic
  List<Map<String, dynamic>> get filteredUsers {
    if (searchQuery.trim().isEmpty) {
      return allUsers;
    }
    final query = searchQuery.toLowerCase().trim();
    return allUsers.where((user) {
      final name = user['name'].toString().toLowerCase();
      final username = user['username'].toString().toLowerCase();
      return name.contains(query) || username.contains(query);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final isTablet = mediaQuery.size.width > 600;

    return Scaffold(
      backgroundColor: const Color(0xFF05021A),
      body: Stack(
        children: [
          // ==============================
          // BACKGROUND
          // ==============================
          Positioned.fill(
            child: Image.asset(
              'assets/images/fandom_background.png',
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) =>
                  Container(color: const Color(0xFF05021A)),
            ),
          ),
          Positioned.fill(
            child: Container(
              color: Colors.black.withOpacity(0.65),
            ),
          ),

          // ==============================
          // CONTENT
          // ==============================
          SafeArea(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.fromLTRB(
                isTablet ? 40 : 20,
                18,
                isTablet ? 40 : 20,
                35,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ==============================
                  // TOP BAR
                  // ==============================
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () => Navigator.pop(context),
                            child: Container(
                              height: 45,
                              width: 45,
                              decoration: BoxDecoration(
                                color: const Color(0xFF111637),
                                shape: BoxShape.circle,
                                border: Border.all(
                                    color: const Color(0xFF7054D7)),
                                boxShadow: [
                                  BoxShadow(
                                    color: const Color(0xFF754DFF)
                                        .withOpacity(0.25),
                                    blurRadius: 12,
                                  ),
                                ],
                              ),
                              child: const Icon(
                                Icons.arrow_back_rounded,
                                color: Colors.white,
                                size: 24,
                              ),
                            ),
                          ),
                          const SizedBox(width: 15),
                          const Text(
                            'Leaderboard',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.share_rounded,
                            color: Colors.white70),
                      ),
                    ],
                  ),

                  const SizedBox(height: 25),

                  // ==============================
                  // TROPHY HEADER
                  // ==============================
                  Center(
                    child: Container(
                      height: 90,
                      width: 90,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: const LinearGradient(
                          colors: [
                            Color(0xFFFF4FD8),
                            Color(0xFF814DFF),
                            Color(0xFF19DFFF),
                          ],
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF8B4DFF).withOpacity(0.45),
                            blurRadius: 30,
                            spreadRadius: 3,
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.emoji_events_rounded,
                        color: Colors.white,
                        size: 50,
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  const Center(
                    child: Text(
                      'Fandom Champions',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  const SizedBox(height: 6),

                  Center(
                    child: Text(
                      'Top fans from the Fandom universe',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.55),
                        fontSize: 14,
                      ),
                    ),
                  ),

                  const SizedBox(height: 22),

                  // ==============================
                  // TIMEFRAME SELECTOR
                  // ==============================
                  _buildTimeframeSelector(),

                  const SizedBox(height: 22),

                  // ==============================
                  // REAL WORKING SEARCH BAR
                  // ==============================
                  _buildSearchBar(),

                  const SizedBox(height: 28),

                  // Hide Top 3 podium when searching to avoid layout clutter
                  if (searchQuery.trim().isEmpty) ...[
                    // ==============================
                    // TOP 3 PODIUM
                    // ==============================
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _topUser(
                          rank: 2,
                          name: 'Ali',
                          points: '9,850',
                          height: 150,
                          cardWidth: isTablet ? 140 : 100,
                        ),
                        const SizedBox(width: 10),
                        _topUser(
                          rank: 1,
                          name: 'Zoya',
                          points: '12,450',
                          height: 185,
                          isWinner: true,
                          cardWidth: isTablet ? 150 : 110,
                        ),
                        const SizedBox(width: 10),
                        _topUser(
                          rank: 3,
                          name: 'Maya',
                          points: '9,420',
                          height: 150,
                          cardWidth: isTablet ? 140 : 100,
                        ),
                      ],
                    ),

                    const SizedBox(height: 30),

                    // ==============================
                    // YOUR RANK
                    // ==============================
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(18),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [
                            Color(0xFF2B185A),
                            Color(0xFF101A45),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: const Color(0xFF9B5CFF),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF754DFF).withOpacity(0.20),
                            blurRadius: 18,
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Container(
                            height: 48,
                            width: 48,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: const Color(0xFF754DFF).withOpacity(0.25),
                            ),
                            child: const Icon(
                              Icons.person_rounded,
                              color: Color(0xFFB77AFF),
                              size: 27,
                            ),
                          ),
                          const SizedBox(width: 14),
                          const Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Your Rank',
                                  style: TextStyle(
                                    color: Colors.white54,
                                    fontSize: 12,
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  '#12  Kanwal',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Text(
                            '5,840 pts',
                            style: TextStyle(
                              color: Color(0xFFB77AFF),
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 28),
                  ],

                  // ==============================
                  // OTHER PLAYERS TITLE
                  // ==============================
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        searchQuery.isEmpty ? '🏆 Top Fans' : '🔍 Search Results',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      if (searchQuery.isNotEmpty)
                        Text(
                          '${filteredUsers.length} found',
                          style: const TextStyle(
                            color: Color(0xFFB77AFF),
                            fontSize: 13,
                          ),
                        ),
                    ],
                  ),

                  const SizedBox(height: 14),

                  // ==============================
                  // FILTERED PLAYERS LIST
                  // ==============================
                  if (filteredUsers.isNotEmpty)
                    ...filteredUsers.map(
                          (user) => _playerCard(
                        rank: user['rank'],
                        name: user['name'],
                        username: user['username'],
                        points: user['points'],
                        streak: user['streak'],
                        icon: user['icon'],
                      ),
                    )
                  else
                    _buildNoResults(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ============================================
  // SEARCH BAR WIDGET
  // ============================================
  Widget _buildSearchBar() {
    return Container(
      height: 52,
      decoration: BoxDecoration(
        color: const Color(0xFF111637).withOpacity(0.85),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: searchQuery.isNotEmpty
              ? const Color(0xFF9B5CFF)
              : const Color(0xFF3E4172).withOpacity(0.6),
        ),
      ),
      child: Row(
        children: [
          const SizedBox(width: 15),
          const Icon(
            Icons.search_rounded,
            color: Color(0xFFB77AFF),
            size: 22,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: TextField(
              controller: searchController,
              onChanged: (value) {
                setState(() {
                  searchQuery = value;
                });
              },
              style: const TextStyle(color: Colors.white, fontSize: 14),
              decoration: const InputDecoration(
                hintText: 'Search fan by name or username...',
                hintStyle: TextStyle(color: Colors.white38, fontSize: 13.5),
                border: InputBorder.none,
              ),
            ),
          ),
          if (searchQuery.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.close_rounded, color: Colors.white54, size: 20),
              onPressed: () {
                searchController.clear();
                setState(() {
                  searchQuery = '';
                });
              },
            ),
        ],
      ),
    );
  }

  // ============================================
  // NO RESULTS WIDGET
  // ============================================
  Widget _buildNoResults() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 35),
      alignment: Alignment.center,
      child: Column(
        children: [
          Icon(Icons.search_off_rounded, color: Colors.white.withOpacity(0.3), size: 48),
          const SizedBox(height: 12),
          Text(
            'No fans found for "$searchQuery"',
            style: TextStyle(color: Colors.white.withOpacity(0.6), fontSize: 14),
          ),
        ],
      ),
    );
  }

  // ============================================
  // TIMEFRAME SELECTOR WIDGET
  // ============================================
  Widget _buildTimeframeSelector() {
    return Container(
      height: 46,
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: const Color(0xFF111637).withOpacity(0.8),
        borderRadius: BorderRadius.circular(25),
        border: Border.all(color: const Color(0xFF3E4172).withOpacity(0.5)),
      ),
      child: Row(
        children: List.generate(
          timeframes.length,
              (index) => Expanded(
            child: GestureDetector(
              onTap: () => setState(() => selectedTimeframe = index),
              child: Container(
                decoration: BoxDecoration(
                  color: selectedTimeframe == index
                      ? const Color(0xFF754DFF)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(20),
                ),
                alignment: Alignment.center,
                child: Text(
                  timeframes[index],
                  style: TextStyle(
                    color: selectedTimeframe == index
                        ? Colors.white
                        : Colors.white54,
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // ============================================
  // TOP USER
  // ============================================
  Widget _topUser({
    required int rank,
    required String name,
    required String points,
    required double height,
    required double cardWidth,
    bool isWinner = false,
  }) {
    return Container(
      width: cardWidth,
      height: height,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: isWinner
              ? const [Color(0xFF5B2B88), Color(0xFF17163E)]
              : const [Color(0xFF252052), Color(0xFF10152F)],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isWinner ? const Color(0xFFFF4FD8) : const Color(0xFF6355A7),
        ),
        boxShadow: [
          BoxShadow(
            color: isWinner
                ? const Color(0xFFFF4FD8).withOpacity(0.25)
                : const Color(0xFF754DFF).withOpacity(0.15),
            blurRadius: 18,
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (isWinner)
            const Icon(
              Icons.workspace_premium_rounded,
              color: Color(0xFFFFD54F),
              size: 25,
            ),
          const SizedBox(height: 4),
          Container(
            height: isWinner ? 50 : 42,
            width: isWinner ? 50 : 42,
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
              size: 26,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            '#$rank',
            style: TextStyle(
              color: isWinner ? const Color(0xFFFFD54F) : Colors.white70,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 13,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            points,
            style: const TextStyle(
              color: Color(0xFFB77AFF),
              fontSize: 11,
            ),
          ),
        ],
      ),
    );
  }

  // ============================================
  // PLAYER CARD
  // ============================================
  Widget _playerCard({
    required int rank,
    required String name,
    required String username,
    required String points,
    required String streak,
    required IconData icon,
  }) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFF0C1333).withOpacity(0.94),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: const Color(0xFF3E4172),
        ),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 32,
            child: Text(
              '#$rank',
              style: const TextStyle(
                color: Color(0xFFB77AFF),
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            height: 45,
            width: 45,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [
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
          const SizedBox(width: 13),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Flexible(
                      child: Text(
                        name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(width: 6),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.orange.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        streak,
                        style: const TextStyle(
                          color: Colors.orangeAccent,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 3),
                Text(
                  username,
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.45),
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                points,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 3),
              const Text(
                'points',
                style: TextStyle(
                  color: Colors.white38,
                  fontSize: 10,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}