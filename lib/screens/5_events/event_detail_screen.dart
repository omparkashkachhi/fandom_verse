import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../../models/content_models.dart';

class EventDetailScreen extends StatefulWidget {
  final EventItem? eventItem;
  final Map<String, dynamic>? eventMap;
  final Map<String, dynamic>? event; // Added alias to support 'event:' call

  const EventDetailScreen({
    super.key,
    this.eventItem,
    this.eventMap,
    this.event,
  }) : assert(eventItem != null || eventMap != null || event != null,
  'Either eventItem, eventMap, or event must be provided.');

  @override
  State<EventDetailScreen> createState() => _EventDetailScreenState();
}

class _EventDetailScreenState extends State<EventDetailScreen> {
  bool isBookmarked = false;

  // Convenient getter to get active Map data safely
  Map<String, dynamic>? get _effectiveMap => widget.eventMap ?? widget.event;

  // Extract values safely regardless of Model, eventMap, or event usage
  String get title =>
      widget.eventItem?.title ??
          _effectiveMap?['title'] ??
          'Event Detail';

  String get date =>
      widget.eventItem?.date ??
          _effectiveMap?['date'] ??
          'TBA';

  String get location =>
      widget.eventItem?.location ??
          _effectiveMap?['location'] ??
          _effectiveMap?['city'] ??
          'Location unavailable';

  String get imageUrl =>
      widget.eventItem?.imageUrl ??
          _effectiveMap?['image'] ??
          _effectiveMap?['imageUrl'] ??
          '';

  String get category => widget.eventItem?.category ?? 'Event';

  String get description =>
      widget.eventItem?.description ??
          _effectiveMap?['description'] ??
          'No detailed description available for this event.';

  int get attendeesCount => widget.eventItem?.attendeesCount ?? 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final width = constraints.maxWidth;

            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // HERO IMAGE & HEADER BUTTONS
                  SizedBox(
                    width: double.infinity,
                    height: width < 600 ? 320 : 440,
                    child: Stack(
                      children: [
                        // IMAGE BACKGROUND
                        Positioned.fill(
                          child: _buildImage(imageUrl),
                        ),

                        // GRADIENT OVERLAY
                        Positioned.fill(
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Colors.black.withOpacity(0.3),
                                  AppColors.background.withOpacity(0.2),
                                  AppColors.background,
                                ],
                              ),
                            ),
                          ),
                        ),

                        // BACK BUTTON
                        Positioned(
                          top: 18,
                          left: 18,
                          child: _circleButton(
                            Icons.arrow_back_rounded,
                                () => Navigator.pop(context),
                          ),
                        ),

                        // BOOKMARK BUTTON
                        Positioned(
                          top: 18,
                          right: 18,
                          child: _circleButton(
                            isBookmarked
                                ? Icons.bookmark_rounded
                                : Icons.bookmark_border_rounded,
                                () {
                              setState(() {
                                isBookmarked = !isBookmarked;
                              });
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  duration: const Duration(seconds: 1),
                                  content: Text(
                                    isBookmarked
                                        ? 'Saved to Bookmarks!'
                                        : 'Removed from Bookmarks.',
                                  ),
                                ),
                              );
                            },
                            iconColor:
                            isBookmarked ? AppColors.cyan : Colors.white,
                          ),
                        ),

                        // TITLE & CATEGORY BADGE
                        Positioned(
                          left: 22,
                          right: 22,
                          bottom: 16,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: AppColors.primary,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  category,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                title,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: width < 600 ? 28 : 40,
                                  fontWeight: FontWeight.w800,
                                  height: 1.2,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  // MAIN CONTENT BODY
                  Padding(
                    padding: const EdgeInsets.all(22),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // DATE & LOCATION HIGHLIGHT BOXES
                        Row(
                          children: [
                            Expanded(
                              child: _infoBox(
                                Icons.calendar_month_rounded,
                                date,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: _infoBox(
                                Icons.location_on_outlined,
                                location,
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 24),

                        // ABOUT SECTION
                        const Text(
                          'About Event',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 10),

                        Text(
                          description,
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.8),
                            fontSize: 14,
                            height: 1.6,
                          ),
                        ),

                        const SizedBox(height: 24),

                        // DETAIL ROWS
                        _detailRow(
                          Icons.place_outlined,
                          'Location / Venue',
                          location,
                        ),

                        const SizedBox(height: 16),

                        _detailRow(
                          Icons.event_available_rounded,
                          'Event Date',
                          date,
                        ),

                        if (attendeesCount > 0) ...[
                          const SizedBox(height: 16),
                          _detailRow(
                            Icons.people_alt_outlined,
                            'Attending',
                            '$attendeesCount people joined',
                          ),
                        ],

                        const SizedBox(height: 32),

                        // TICKET ACTION BUTTON
                        SizedBox(
                          width: double.infinity,
                          height: 54,
                          child: ElevatedButton.icon(
                            onPressed: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    'Ticket booking portal will open soon!',
                                  ),
                                ),
                              );
                            },
                            icon: const Icon(
                              Icons.confirmation_num_outlined,
                              color: Colors.white,
                            ),
                            label: const Text(
                              'Get Tickets',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primary,
                              elevation: 4,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  // CIRCLE ICON BUTTON
  Widget _circleButton(
      IconData icon,
      VoidCallback onTap, {
        Color iconColor = Colors.white,
      }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(11),
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.5),
          shape: BoxShape.circle,
          border: Border.all(
            color: Colors.white24,
          ),
        ),
        child: Icon(
          icon,
          color: iconColor,
          size: 22,
        ),
      ),
    );
  }

  // TOP INFO BOX WIDGET
  Widget _infoBox(
      IconData icon,
      String text,
      ) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.cardBg,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.white.withOpacity(0.08),
        ),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: AppColors.cyan,
            size: 20,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // DETAIL ITEM ROW
  Widget _detailRow(
      IconData icon,
      String title,
      String value,
      ) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: AppColors.cardBg,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: Colors.white12,
            ),
          ),
          child: Icon(
            icon,
            color: AppColors.cyan,
            size: 22,
          ),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 12,
                ),
              ),
              const SizedBox(height: 3),
              Text(
                value,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // SAFE IMAGE RENDERER
  Widget _buildImage(String path) {
    if (path.isEmpty) {
      return _buildFallback();
    }
    if (path.startsWith('http')) {
      return Image.network(
        path,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) => _buildFallback(),
      );
    }
    return Image.asset(
      path,
      fit: BoxFit.cover,
      errorBuilder: (_, __, ___) => _buildFallback(),
    );
  }

  Widget _buildFallback() {
    return Container(
      color: const Color(0xFF1E1B4B),
      child: const Center(
        child: Icon(
          Icons.event_seat_rounded,
          size: 60,
          color: AppColors.cyan,
        ),
      ),
    );
  }
}