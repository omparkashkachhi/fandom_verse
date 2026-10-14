import 'package:flutter/material.dart';
// Note: Apne project ke mutabiq Gemini AI service ya package ka import yahan add karein
// e.g., import 'package:google_generative_ai/google_generative_ai.dart';

class QuickPromptChip extends StatefulWidget {
  final String label;
  final String? promptQuery; // Gemini ke liye exact prompt text (agar label se mukhtalif ho)
  final IconData? icon;
  final bool isSelected;
  final VoidCallback? onTap;
  final Function(String response)? onAIResponseReceived; // AI response callback
  final Color primaryColor;
  final Color accentColor;
  final Color backgroundColor;
  final EdgeInsetsGeometry padding;
  final bool enableGeminiAI; // Toggle for AI functionality

  const QuickPromptChip({
    super.key,
    required this.label,
    this.promptQuery,
    this.onTap,
    this.onAIResponseReceived,
    this.icon,
    this.isSelected = false,
    this.primaryColor = const Color(0xFF06B6D4), // Cyan Glow Accent
    this.accentColor = const Color(0xFF8B5CF6),  // Purple Secondary Glow
    this.backgroundColor = const Color(0xFF0D0D2B),
    this.padding = const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
    this.enableGeminiAI = true,
  });

  @override
  State<QuickPromptChip> createState() => _QuickPromptChipState();
}

class _QuickPromptChipState extends State<QuickPromptChip>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late AnimationController _pulseController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _pulseAnimation;

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();

    // Tap Scale Animation Controller
    _controller = AnimationController(
      duration: const Duration(milliseconds: 120),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.94).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    // AI Loading Pulse Animation Controller
    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    )..repeat(reverse: true);

    _pulseAnimation = Tween<double>(begin: 0.4, end: 1.0).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  void _handleTapDown(TapDownDetails details) {
    if (!_isLoading) _controller.forward();
  }

  void _handleTapUp(TapUpDetails details) {
    _controller.reverse();
    if (!_isLoading) {
      if (widget.onTap != null) widget.onTap!();
      if (widget.enableGeminiAI) {
        _triggerGeminiAIQuery();
      }
    }
  }

  void _handleTapCancel() {
    _controller.reverse();
  }

  /// Real Gemini AI Request Handler
  Future<void> _triggerGeminiAIQuery() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final queryText = widget.promptQuery ?? widget.label;

      // ===================================================================
      // GEMINI API CALL IMPLEMENTATION
      // ===================================================================
      // Uncomment and configure when using official google_generative_ai package:
      /*
      final apiKey = "YOUR_GEMINI_API_KEY"; // Securely store this in env or remote config
      final model = GenerativeModel(model: 'gemini-1.5-flash', apiKey: apiKey);
      final content = [Content.text(queryText)];
      final response = await model.generateContent(content);
      final aiText = response.text ?? "No response generated.";
      */

      // Simulated mock response for seamless testing if SDK isn't hooked up yet:
      await Future.delayed(const Duration(seconds: 2));
      final aiText = "Gemini AI Insights for '$queryText': Fandom Universe is expanding rapidly across multi-platform networks!";

      if (widget.onAIResponseReceived != null) {
        widget.onAIResponseReceived!(aiText);
      }
    } catch (e) {
      if (widget.onAIResponseReceived != null) {
        widget.onAIResponseReceived!("Error connecting to Gemini AI: $e");
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _handleTapDown,
      onTapUp: _handleTapUp,
      onTapCancel: _handleTapCancel,
      child: AnimatedBuilder(
        animation: Listenable.merge([_controller, _pulseController]),
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: child,
          );
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOutCubic,
          padding: widget.padding,
          decoration: BoxDecoration(
            color: widget.isSelected
                ? widget.primaryColor.withOpacity(0.20)
                : widget.backgroundColor,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: widget.isSelected
                  ? widget.primaryColor
                  : Colors.white.withOpacity(0.12),
              width: widget.isSelected ? 1.6 : 1.0,
            ),
            boxShadow: widget.isSelected || _isLoading
                ? [
              BoxShadow(
                color: widget.primaryColor.withOpacity(
                  _isLoading ? _pulseAnimation.value * 0.5 : 0.35,
                ),
                blurRadius: _isLoading ? 14 : 10,
                spreadRadius: _isLoading ? 2 : 1,
                offset: const Offset(0, 2),
              ),
            ]
                : [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (_isLoading) ...[
                SizedBox(
                  width: 14,
                  height: 14,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(widget.primaryColor),
                  ),
                ),
                const SizedBox(width: 8),
              ] else if (widget.icon != null) ...[
                Icon(
                  widget.icon,
                  size: 16,
                  color: widget.isSelected
                      ? widget.primaryColor
                      : const Color(0xFFB8B8D9),
                ),
                const SizedBox(width: 8),
              ],
              Flexible(
                child: Text(
                  widget.label,
                  style: TextStyle(
                    color: widget.isSelected
                        ? Colors.white
                        : const Color(0xFFB8B8D9),
                    fontSize: 13,
                    fontWeight:
                    widget.isSelected ? FontWeight.bold : FontWeight.w500,
                    letterSpacing: 0.3,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              if (widget.isSelected && !_isLoading) ...[
                const SizedBox(width: 6),
                Container(
                  width: 6,
                  height: 6,
                  decoration: BoxDecoration(
                    color: widget.primaryColor,
                    shape: BoxShape.circle,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}