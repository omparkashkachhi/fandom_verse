import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import 'event_detail_screen.dart';

class EventMapScreen extends StatefulWidget {
  const EventMapScreen({super.key});

  @override
  State<EventMapScreen> createState() => _EventMapScreenState();
}

class _EventMapScreenState extends State<EventMapScreen> {
  String selectedEventTitle = 'Anime Fest 2026';
  String searchQuery = '';
  final TextEditingController _searchController = TextEditingController();
  final TransformationController _transformationController =
  TransformationController();

  final List<Map<String, dynamic>> allEvents = [
    {
      'title': 'Anime Fest 2026',
      'city': 'Karachi',
      'location': 'Expo Centre Karachi',
      'date': 'Oct 15, 2026',
      'image': 'assets/images/event1.jpg',
      'description':
      'Join the biggest Anime gathering in Karachi featuring cosplay competitions, gaming tournaments, and exclusive merchandise.',
      'x': 0.30,
      'y': 0.38,
    },
    {
      'title': 'Fandom Gaming Expo',
      'city': 'Lahore',
      'location': 'Expo Centre Lahore',
      'date': 'Nov 02, 2026',
      'image': 'assets/images/event2.jpg',
      'description':
      'Experience high-stakes esports, indie game showcases, and retro arcade arenas in Lahore.',
      'x': 0.62,
      'y': 0.27,
    },
    {
      'title': 'Cosplay Convention',
      'city': 'Islamabad',
      'location': 'Convention Centre Islamabad',
      'date': 'Dec 10, 2026',
      'image': 'assets/images/event3.jpg',
      'description':
      'Showcase your crafting skills and meet top cosplayers from around the country in Islamabad.',
      'x': 0.50,
      'y': 0.58,
    },
  ];

  List<Map<String, dynamic>> get filteredEvents {
    if (searchQuery.trim().isEmpty) return allEvents;
    return allEvents.where((e) {
      final title = e['title'].toString().toLowerCase();
      final city = e['city'].toString().toLowerCase();
      final loc = e['location'].toString().toLowerCase();
      final q = searchQuery.toLowerCase();
      return title.contains(q) || city.contains(q) || loc.contains(q);
    }).toList();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _transformationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final selectedEvent = allEvents.firstWhere(
          (e) => e['title'] == selectedEventTitle,
      orElse: () => filteredEvents.isNotEmpty ? filteredEvents.first : allEvents.first,
    );

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final width = constraints.maxWidth;
            final height = constraints.maxHeight;

            return Stack(
              children: [
                // MAP CANVAS WITH INTERACTIVE ZOOM & PAN
                Positioned.fill(
                  child: InteractiveViewer(
                    transformationController: _transformationController,
                    minScale: 1.0,
                    maxScale: 3.5,
                    child: Stack(
                      children: [
                        Positioned.fill(
                          child: CustomPaint(
                            painter: DarkMapPainter(),
                          ),
                        ),

                        // DYNAMIC MAP MARKERS
                        ...filteredEvents.map((event) {
                          final isSelected = event['title'] == selectedEventTitle;
                          return Positioned(
                            left: width * (event['x'] as double) - (isSelected ? 26 : 21),
                            top: height * (event['y'] as double) - (isSelected ? 26 : 21),
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedEventTitle = event['title'];
                                });
                              },
                              child: _mapMarker(isSelected),
                            ),
                          );
                        }),
                      ],
                    ),
                  ),
                ),

                // TOP APP BAR CONTROLS
                Positioned(
                  top: 16,
                  left: 18,
                  right: 18,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _circleButton(
                        Icons.arrow_back_rounded,
                            () => Navigator.pop(context),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 10,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.cardBg.withOpacity(0.92),
                          borderRadius: BorderRadius.circular(22),
                          border: Border.all(
                            color: AppColors.primary.withOpacity(0.4),
                          ),
                        ),
                        child: const Text(
                          'Event Map',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      _circleButton(
                        Icons.my_location_rounded,
                            () {
                          _transformationController.value = Matrix4.identity();
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              duration: Duration(seconds: 1),
                              content: Text('Map view reset to default.'),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),

                // SEARCH BAR
                Positioned(
                  top: 76,
                  left: 18,
                  right: 18,
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                      color: AppColors.cardBg.withOpacity(0.94),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: AppColors.primary.withOpacity(0.3),
                      ),
                    ),
                    child: TextField(
                      controller: _searchController,
                      onChanged: (val) {
                        setState(() {
                          searchQuery = val;
                        });
                      },
                      style: const TextStyle(color: Colors.white, fontSize: 14),
                      decoration: InputDecoration(
                        hintText: 'Search city or event name...',
                        hintStyle: const TextStyle(color: Colors.white54, fontSize: 14),
                        prefixIcon: const Icon(
                          Icons.search_rounded,
                          color: AppColors.cyan,
                        ),
                        suffixIcon: searchQuery.isNotEmpty
                            ? IconButton(
                          icon: const Icon(Icons.clear_rounded,
                              color: Colors.white54, size: 18),
                          onPressed: () {
                            _searchController.clear();
                            setState(() {
                              searchQuery = '';
                            });
                          },
                        )
                            : null,
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                    ),
                  ),
                ),

                // CATEGORY BADGE
                Positioned(
                  left: 18,
                  bottom: 185,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 13,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.cardBg.withOpacity(0.9),
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: Colors.white12),
                    ),
                    child: const Row(
                      children: [
                        Icon(
                          Icons.location_on_rounded,
                          color: AppColors.cyan,
                          size: 16,
                        ),
                        SizedBox(width: 6),
                        Text(
                          'Interactive Map View',
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // EVENT CARD OVERLAY
                Positioned(
                  left: 18,
                  right: 18,
                  bottom: 20,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EventDetailScreen(
                            eventMap: selectedEvent,
                          ),
                        ),
                      );
                    },
                    child: _eventCard(selectedEvent),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  // BOTTOM EVENT PREVIEW CARD
  Widget _eventCard(Map<String, dynamic> event) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.cardBg.withOpacity(0.96),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: AppColors.primary,
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.3),
            blurRadius: 20,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [
                  AppColors.primary,
                  Color(0xff3B75FF),
                ],
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Icon(
              Icons.event_seat_rounded,
              color: Colors.white,
              size: 26,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  event['title'] ?? 'Event',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(
                      Icons.location_on_outlined,
                      color: AppColors.cyan,
                      size: 14,
                    ),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        event['location'] ?? '',
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Colors.white60,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 3),
                Text(
                  event['city'] ?? '',
                  style: const TextStyle(
                    color: AppColors.cyan,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          const Icon(
            Icons.arrow_forward_ios_rounded,
            color: Colors.white54,
            size: 16,
          ),
        ],
      ),
    );
  }

  // MAP MARKER WIDGET
  Widget _mapMarker(bool selected) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      width: selected ? 52 : 42,
      height: selected ? 52 : 42,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          colors: selected
              ? const [AppColors.primary, AppColors.cyan]
              : const [Color(0xff273B76), Color(0xff172754)],
        ),
        border: Border.all(
          color: selected ? Colors.white : AppColors.cyan.withOpacity(0.6),
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: selected
                ? AppColors.primary.withOpacity(0.6)
                : Colors.black26,
            blurRadius: selected ? 18 : 8,
          ),
        ],
      ),
      child: Icon(
        Icons.location_on_rounded,
        color: Colors.white,
        size: selected ? 28 : 22,
      ),
    );
  }

  // ACTION BUTTON WIDGET
  Widget _circleButton(IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          color: AppColors.cardBg.withOpacity(0.92),
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white24),
        ),
        child: Icon(
          icon,
          color: Colors.white,
          size: 20,
        ),
      ),
    );
  }
}

class DarkMapPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final backgroundPaint = Paint()..color = AppColors.background;
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), backgroundPaint);

    final areaPaint = Paint()
      ..color = const Color(0xff0C1835)
      ..style = PaintingStyle.fill;

    canvas.drawCircle(Offset(size.width * 0.25, size.height * 0.30), 130, areaPaint);
    canvas.drawCircle(Offset(size.width * 0.72, size.height * 0.35), 170, areaPaint);
    canvas.drawCircle(Offset(size.width * 0.50, size.height * 0.70), 190, areaPaint);

    final mainRoad = Paint()
      ..color = const Color(0xff1C2B50)
      ..strokeWidth = 16
      ..style = PaintingStyle.stroke;

    for (double y = 130; y < size.height; y += 145) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y + 40), mainRoad);
    }

    canvas.drawLine(
      Offset(0, size.height * 0.35),
      Offset(size.width, size.height * 0.72),
      mainRoad,
    );

    final smallRoad = Paint()
      ..color = const Color(0xff26375F)
      ..strokeWidth = 2;

    for (double x = 40; x < size.width; x += 75) {
      canvas.drawLine(Offset(x, 0), Offset(x - 100, size.height), smallRoad);
    }

    final waterPaint = Paint()..color = const Color(0xff091E3B);
    final waterPath = Path()
      ..moveTo(0, size.height * 0.78)
      ..quadraticBezierTo(
        size.width * 0.25,
        size.height * 0.65,
        size.width * 0.48,
        size.height * 0.82,
      )
      ..quadraticBezierTo(
        size.width * 0.72,
        size.height * 0.96,
        size.width,
        size.height * 0.80,
      )
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();

    canvas.drawPath(waterPath, waterPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}