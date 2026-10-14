import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import '../../../models/content_models.dart';

class MapViewWidget extends StatefulWidget {
  final List<EventItem> events;
  final Function(EventItem)? onEventTap;

  const MapViewWidget({
    super.key,
    required this.events,
    this.onEventTap,
  });

  @override
  State<MapViewWidget> createState() => _MapViewWidgetState();
}

class _MapViewWidgetState extends State<MapViewWidget> {
  EventItem? selectedEvent;
  double zoomLevel = 1.0;

  @override
  void initState() {
    super.initState();
    if (widget.events.isNotEmpty) {
      selectedEvent = widget.events.first;
    }
  }

  void _zoomIn() {
    setState(() {
      if (zoomLevel < 1.8) zoomLevel += 0.2;
    });
  }

  void _zoomOut() {
    setState(() {
      if (zoomLevel > 0.8) zoomLevel -= 0.2;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (widget.events.isEmpty) {
      return Container(
        color: AppColors.background,
        child: const Center(
          child: Text(
            'No event locations available.',
            style: TextStyle(color: AppColors.textSecondary),
          ),
        ),
      );
    }

    return Stack(
      children: [
        // INTERACTIVE MAP BACKDROP AREA
        ClipRRect(
          child: AnimatedScale(
            scale: zoomLevel,
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeInOut,
            child: Container(
              width: double.infinity,
              height: double.infinity,
              decoration: const BoxDecoration(
                color: Color(0xFF0F172A),
              ),
              child: CustomPaint(
                painter: MapGridPainter(),
                child: Stack(
                  children: List.generate(widget.events.length, (index) {
                    final event = widget.events[index];
                    // Distribute pins across map area mock positions
                    final double topPos = 120.0 + (index * 90.0) % 350;
                    final double leftPos = 40.0 + (index * 130.0) % 280;
                    final isSelected = selectedEvent?.id == event.id;

                    return Positioned(
                      top: topPos,
                      left: leftPos,
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedEvent = event;
                          });
                        },
                        child: _buildMapPin(event, isSelected),
                      ),
                    );
                  }),
                ),
              ),
            ),
          ),
        ),

        // ZOOM CONTROLS (TOP RIGHT)
        Positioned(
          top: 16,
          right: 16,
          child: Column(
            children: [
              _buildControlButton(
                icon: Icons.add_rounded,
                onTap: _zoomIn,
                tooltip: 'Zoom In',
              ),
              const SizedBox(height: 8),
              _buildControlButton(
                icon: Icons.remove_rounded,
                onTap: _zoomOut,
                tooltip: 'Zoom Out',
              ),
            ],
          ),
        ),

        // SELECTED EVENT CARD OVERLAY (BOTTOM)
        if (selectedEvent != null)
          Positioned(
            left: 16,
            right: 16,
            bottom: 20,
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: _buildEventInfoCard(selectedEvent!),
            ),
          ),
      ],
    );
  }

  // MAP PIN WIDGET
  Widget _buildMapPin(EventItem event, bool isSelected) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.cyan : AppColors.cardBg,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isSelected ? Colors.white : AppColors.cyan,
              width: 1.5,
            ),
            boxShadow: [
              BoxShadow(
                color: (isSelected ? AppColors.cyan : Colors.black)
                    .withOpacity(0.4),
                blurRadius: 8,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Text(
            event.category,
            style: TextStyle(
              color: isSelected ? Colors.black : Colors.white,
              fontSize: 10,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Icon(
          Icons.location_on_rounded,
          size: isSelected ? 38 : 30,
          color: isSelected ? AppColors.cyan : AppColors.primary,
        ),
      ],
    );
  }

  // BOTTOM FLOATING CARD FOR SELECTED EVENT
  Widget _buildEventInfoCard(EventItem event) {
    return Container(
      key: ValueKey(event.id),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.cardBg,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: AppColors.cyan.withOpacity(0.4),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.5),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: SizedBox(
              width: 70,
              height: 70,
              child: _buildThumbnail(event.imageUrl),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  event.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(
                      Icons.location_on_rounded,
                      size: 13,
                      color: AppColors.cyan,
                    ),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        event.location,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: AppColors.textSecondary,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(
                      Icons.calendar_today_rounded,
                      size: 12,
                      color: Colors.white54,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      event.date,
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () {
              if (widget.onEventTap != null) {
                widget.onEventTap!(event);
              }
            },
            icon: const Icon(
              Icons.arrow_forward_ios_rounded,
              color: AppColors.cyan,
              size: 18,
            ),
          ),
        ],
      ),
    );
  }

  // CONTROL BUTTON WIDGET
  Widget _buildControlButton({
    required IconData icon,
    required VoidCallback onTap,
    required String tooltip,
  }) {
    return Material(
      color: AppColors.cardBg,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.white12),
          ),
          child: Icon(icon, color: Colors.white, size: 20),
        ),
      ),
    );
  }

  // IMAGE HELPER
  Widget _buildThumbnail(String path) {
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
        child: Icon(Icons.event_rounded, color: AppColors.cyan, size: 30),
      ),
    );
  }
}

// CUSTOM PAINTER FOR STYLISH VECTOR MAP GRID BACKGROUND
class MapGridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.04)
      ..strokeWidth = 1.0
      ..style = PaintingStyle.stroke;

    const double step = 40.0;

    for (double x = 0; x < size.width; x += step) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }

    for (double y = 0; y < size.height; y += step) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}