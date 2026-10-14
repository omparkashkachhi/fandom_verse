import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import 'event_detail_screen.dart';
import 'event_map_screen.dart';

class EventsScreen extends StatefulWidget {
  final List<Map<String, String>>? events;

  const EventsScreen({
    super.key,
    this.events,
  });

  @override
  State<EventsScreen> createState() => _EventsScreenState();
}

class _EventsScreenState extends State<EventsScreen> {
  String selectedCity = 'All Cities';
  String searchText = '';
  bool isLoading = false;
  final TextEditingController _searchController = TextEditingController();

  late List<Map<String, dynamic>> events;

  final List<String> availableCities = [
    'All Cities',
    'Karachi',
    'Lahore',
    'Islamabad',
  ];

  final List<Map<String, dynamic>> defaultEvents = [
    {
      'title': 'Anime Fest 2026',
      'city': 'Karachi',
      'date': '15 Oct 2026',
      'location': 'Expo Centre Karachi',
      'image': 'assets/images/anime_event.png',
      'description':
      'A colorful anime festival featuring fan activities, anime displays, and entertainment.',
    },
    {
      'title': 'Fandom Gaming Expo',
      'city': 'Lahore',
      'date': '22 Oct 2026',
      'location': 'Expo Centre Lahore',
      'image': 'assets/images/gaming_event.png',
      'description':
      'A gaming-focused fandom event with gaming zones, competitions, and community activities.',
    },
    {
      'title': 'Cosplay Event',
      'city': 'Islamabad',
      'date': '05 Nov 2026',
      'location': 'Convention Centre Islamabad',
      'image': 'assets/images/cosplay_event.png',
      'description':
      'A cosplay gathering where fans can enjoy costumes, photography, and fandom activities.',
    },
  ];

  @override
  void initState() {
    super.initState();
    _loadEventsData();
  }

  void _loadEventsData() {
    if (widget.events != null && widget.events!.isNotEmpty) {
      events = widget.events!.map((e) {
        final loc = e['location'] ?? 'Expo Centre Karachi';
        final detectedCity = e['city'] ??
            (loc.contains('Lahore')
                ? 'Lahore'
                : loc.contains('Islamabad')
                ? 'Islamabad'
                : 'Karachi');

        return {
          'title': e['title'] ?? 'Fandom Event',
          'city': detectedCity,
          'date': e['date'] ?? 'Upcoming 2026',
          'location': loc,
          'image': e['image'] ?? 'assets/images/event_photo.jpg',
          'description': e['description'] ??
              'Enjoy an exciting experience with fellow pop-culture fans!',
        };
      }).toList();
    } else {
      events = List.from(defaultEvents);
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  // REFRESH SIMULATION
  Future<void> _handleRefresh() async {
    setState(() {
      isLoading = true;
    });
    await Future.delayed(const Duration(milliseconds: 800));
    if (mounted) {
      setState(() {
        _loadEventsData();
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Events updated successfully'),
          duration: Duration(seconds: 1),
          backgroundColor: AppColors.cardBg,
        ),
      );
    }
  }

  List<Map<String, dynamic>> get filteredEvents {
    return events.where((event) {
      final bool matchesCity =
          selectedCity == 'All Cities' || event['city'] == selectedCity;

      final String query = searchText.toLowerCase().trim();

      final bool matchesSearch = query.isEmpty ||
          event['title'].toString().toLowerCase().contains(query) ||
          event['city'].toString().toLowerCase().contains(query) ||
          event['location'].toString().toLowerCase().contains(query);

      return matchesCity && matchesSearch;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: _handleRefresh,
          color: AppColors.cyan,
          backgroundColor: AppColors.cardBg,
          child: LayoutBuilder(
            builder: (context, constraints) {
              final double width = constraints.maxWidth;
              final double horizontalPadding = width < 600 ? 18 : width * 0.08;
              final double headerHeight = width < 600 ? 240 : 290;
              final bool isWideScreen = width >= 700;

              return SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // HEADER SECTION
                    SizedBox(
                      height: headerHeight,
                      child: Stack(
                        children: [
                          Positioned.fill(
                            child: Image.asset(
                              'assets/images/event_photo.jpg',
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) =>
                                  Container(color: AppColors.cardBg),
                            ),
                          ),
                          Positioned.fill(
                            child: Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    Colors.black.withOpacity(0.3),
                                    AppColors.background.withOpacity(0.75),
                                    AppColors.background,
                                  ],
                                ),
                              ),
                            ),
                          ),
                          if (Navigator.canPop(context))
                            Positioned(
                              top: 18,
                              left: 18,
                              child: _roundButton(
                                Icons.arrow_back_rounded,
                                    () => Navigator.pop(context),
                              ),
                            ),
                          Positioned(
                            top: 18,
                            right: 18,
                            child: _roundButton(
                              Icons.notifications_none_rounded,
                                  () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('No new event notifications'),
                                    duration: Duration(seconds: 1),
                                    backgroundColor: AppColors.cardBg,
                                  ),
                                );
                              },
                            ),
                          ),
                          Positioned(
                            left: horizontalPadding,
                            right: horizontalPadding,
                            bottom: 16,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'FANDOM VERSE',
                                  style: TextStyle(
                                    color: AppColors.cyan,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 3,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'Events',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: width < 600 ? 34 : 44,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                const Text(
                                  'Discover your next fandom experience',
                                  style: TextStyle(
                                    color: AppColors.textSecondary,
                                    fontSize: 13,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    // MAIN CONTENT
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: horizontalPadding,
                        vertical: 12,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // SEARCH BAR
                          Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: AppColors.cardBg,
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(color: Colors.white12),
                            ),
                            child: TextField(
                              controller: _searchController,
                              onChanged: (value) {
                                setState(() {
                                  searchText = value;
                                });
                              },
                              style: const TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                hintText: 'Search events, locations, or cities...',
                                hintStyle: const TextStyle(
                                  color: AppColors.textSecondary,
                                  fontSize: 14,
                                ),
                                prefixIcon: const Icon(
                                  Icons.search_rounded,
                                  color: AppColors.primary,
                                ),
                                suffixIcon: searchText.isNotEmpty
                                    ? IconButton(
                                  icon: const Icon(
                                    Icons.clear_rounded,
                                    color: AppColors.textSecondary,
                                    size: 18,
                                  ),
                                  onPressed: () {
                                    _searchController.clear();
                                    setState(() {
                                      searchText = '';
                                    });
                                  },
                                )
                                    : null,
                                border: InputBorder.none,
                                contentPadding: const EdgeInsets.symmetric(
                                  vertical: 14,
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(height: 14),

                          // CITY QUICK FILTER CHIPS
                          SizedBox(
                            height: 38,
                            child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              itemCount: availableCities.length,
                              separatorBuilder: (_, __) =>
                              const SizedBox(width: 8),
                              itemBuilder: (context, index) {
                                final city = availableCities[index];
                                final isSelected = selectedCity == city;
                                return GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      selectedCity = city;
                                    });
                                  },
                                  child: AnimatedContainer(
                                    duration: const Duration(milliseconds: 200),
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 16,
                                      vertical: 8,
                                    ),
                                    decoration: BoxDecoration(
                                      color: isSelected
                                          ? AppColors.primary
                                          : AppColors.cardBg,
                                      borderRadius: BorderRadius.circular(20),
                                      border: Border.all(
                                        color: isSelected
                                            ? AppColors.cyan
                                            : Colors.white12,
                                      ),
                                    ),
                                    child: Text(
                                      city,
                                      style: TextStyle(
                                        color: isSelected
                                            ? Colors.white
                                            : AppColors.textSecondary,
                                        fontSize: 13,
                                        fontWeight: isSelected
                                            ? FontWeight.bold
                                            : FontWeight.normal,
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),

                          const SizedBox(height: 22),

                          // HEADING & EVENT COUNT
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Upcoming Events',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: AppColors.primary.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: AppColors.primary.withOpacity(0.4),
                                  ),
                                ),
                                child: Text(
                                  '${filteredEvents.length} Events',
                                  style: const TextStyle(
                                    color: AppColors.cyan,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 16),

                          // EMPTY STATE
                          if (filteredEvents.isEmpty)
                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.all(32),
                              decoration: BoxDecoration(
                                color: AppColors.cardBg,
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(color: Colors.white10),
                              ),
                              child: Column(
                                children: [
                                  const Icon(
                                    Icons.event_busy_rounded,
                                    color: AppColors.textSecondary,
                                    size: 44,
                                  ),
                                  const SizedBox(height: 10),
                                  const Text(
                                    'No matching events found',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  const Text(
                                    'Try searching with a different city or event name.',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: AppColors.textSecondary,
                                      fontSize: 12,
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                  OutlinedButton(
                                    onPressed: () {
                                      _searchController.clear();
                                      setState(() {
                                        searchText = '';
                                        selectedCity = 'All Cities';
                                      });
                                    },
                                    style: OutlinedButton.styleFrom(
                                      side: const BorderSide(
                                          color: AppColors.cyan),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                    ),
                                    child: const Text(
                                      'Reset Filters',
                                      style: TextStyle(color: AppColors.cyan),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                          // RESPONSIVE GRID / LIST BUILDER
                          if (isWideScreen && filteredEvents.isNotEmpty)
                            GridView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: 2.1,
                                crossAxisSpacing: 14,
                                mainAxisSpacing: 14,
                              ),
                              itemCount: filteredEvents.length,
                              itemBuilder: (context, index) {
                                return _eventCard(
                                  context,
                                  filteredEvents[index],
                                  width,
                                );
                              },
                            )
                          else
                            ...filteredEvents.map(
                                  (event) => Padding(
                                padding: const EdgeInsets.only(bottom: 14),
                                child: _eventCard(context, event, width),
                              ),
                            ),

                          const SizedBox(height: 14),

                          // MAP INTERACTIVE BANNER
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const EventMapScreen(),
                                ),
                              );
                            },
                            child: Container(
                              width: double.infinity,
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                gradient: const LinearGradient(
                                  colors: [
                                    AppColors.cardBg,
                                    Color(0xFF1E1B4B),
                                  ],
                                ),
                                border: Border.all(
                                  color: AppColors.primary.withOpacity(0.4),
                                ),
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(12),
                                    decoration: BoxDecoration(
                                      color:
                                      AppColors.primary.withOpacity(0.25),
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Icon(
                                      Icons.map_outlined,
                                      color: AppColors.cyan,
                                      size: 22,
                                    ),
                                  ),
                                  const SizedBox(width: 14),
                                  const Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Explore Events on Map',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15,
                                          ),
                                        ),
                                        SizedBox(height: 3),
                                        Text(
                                          'Find fandom events near you in real-time',
                                          style: TextStyle(
                                            color: AppColors.textSecondary,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const Icon(
                                    Icons.arrow_forward_ios_rounded,
                                    color: AppColors.textSecondary,
                                    size: 14,
                                  ),
                                ],
                              ),
                            ),
                          ),

                          const SizedBox(height: 24),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  // EVENT CARD WIDGET
  Widget _eventCard(
      BuildContext context,
      Map<String, dynamic> event,
      double width,
      ) {
    final double imageWidth = width < 600 ? 100 : 130;
    final double imageHeight = width < 600 ? 100 : 120;

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => EventDetailScreen(event: event),
          ),
        );
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: AppColors.cardBg,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: Colors.white10),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(14),
              child: Image.asset(
                event['image'] ?? 'assets/images/fandom_background.png',
                width: imageWidth,
                height: imageHeight,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  width: imageWidth,
                  height: imageHeight,
                  color: Colors.white10,
                  child: const Icon(Icons.event, color: Colors.white38),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    event['title'] ?? 'Fandom Event',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      const Icon(
                        Icons.calendar_month_outlined,
                        size: 13,
                        color: AppColors.cyan,
                      ),
                      const SizedBox(width: 5),
                      Expanded(
                        child: Text(
                          event['date'] ?? 'Upcoming',
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: AppColors.cyan,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(
                        Icons.location_on_outlined,
                        size: 13,
                        color: AppColors.textSecondary,
                      ),
                      const SizedBox(width: 5),
                      Expanded(
                        child: Text(
                          '${event['city']} • ${event['location']}',
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: AppColors.textSecondary,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    event['description'] ?? '',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 11,
                      height: 1.25,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 4),
            const Icon(
              Icons.arrow_forward_ios_rounded,
              color: Colors.white24,
              size: 14,
            ),
          ],
        ),
      ),
    );
  }

  // ROUND BUTTON WIDGET
  Widget _roundButton(IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: AppColors.cardBg.withOpacity(0.8),
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white24),
        ),
        child: Icon(
          icon,
          color: Colors.white,
          size: 18,
        ),
      ),
    );
  }
}