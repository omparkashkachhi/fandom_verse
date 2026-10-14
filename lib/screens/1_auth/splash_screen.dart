import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _progressController;
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  bool _showAuthButtons = false;

  @override
  void initState() {
    super.initState();

    // 1. Progress Bar Controller (3.5 Seconds smooth loading)
    _progressController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3500),
    );

    // 2. Hero Header Fade & Scale Controller
    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    _fadeAnimation = CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeIn,
    );

    _scaleAnimation = Tween<double>(begin: 0.85, end: 1.0).animate(
      CurvedAnimation(
        parent: _fadeController,
        curve: Curves.easeOutBack,
      ),
    );

    // Start Entrance Animations
    _fadeController.forward();
    _progressController.forward();

    _progressController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        if (mounted) {
          setState(() {
            _showAuthButtons = true;
          });
        }
      }
    });
  }

  @override
  void dispose() {
    _progressController.dispose();
    _fadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final double screenWidth = mediaQuery.size.width;
    final double screenHeight = mediaQuery.size.height;

    final bool isSmallScreen = screenHeight < 680;
    final double titleFontSize = isSmallScreen ? 28.0 : 34.0;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        fit: StackFit.expand, // Ensures stack fills the entire screen layout properly
        children: [
          // 1. Background Image with Fallback Linear Gradient (Fixed to cover full screen)
          Image.asset(
            'assets/images/fandom_splash.png',
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xFF0D0D2B),
                      AppColors.background,
                    ],
                  ),
                ),
              );
            },
          ),

          // 2. Dark Radial Overlay for High Text Contrast
          Container(
            color: Colors.black.withValues(alpha: 0.55),
          ),

          // 3. Main Responsive Content Body
          SafeArea(
            child: LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: constraints.maxHeight,
                    ),
                    child: IntrinsicHeight(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 16),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Spacer(),

                            // HERO HEADER / BRAND LOGO SECTION
                            ScaleTransition(
                              scale: _scaleAnimation,
                              child: FadeTransition(
                                opacity: _fadeAnimation,
                                child: _buildHeroHeader(titleFontSize),
                              ),
                            ),

                            const Spacer(),

                            // ANIMATED LOADING BAR & PERCENTAGE OR AUTH BUTTONS
                            if (!_showAuthButtons)
                              _buildLoadingSection(screenWidth)
                            else
                              _buildAuthButtonsSection(isSmallScreen),

                            const SizedBox(height: 12),
                          ],
                        ),
                      ),
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

  // Branding Logo & Title Component
  Widget _buildHeroHeader(double titleFontSize) {
    return const Column(
      children: [
        // Brand logo container aur tagline remove kar diye gaye hain.
      ],
    );
  }

  // Animated Loading Progress Bar
  Widget _buildLoadingSection(double screenWidth) {
    return Column(
      children: [
        const Text(
          'Loading your fandom universe...',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: AppColors.textSecondary,
            fontSize: 13,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 12),

        AnimatedBuilder(
          animation: _progressController,
          builder: (context, child) {
            return Container(
              height: 6,
              width: screenWidth * 0.75,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Align(
                alignment: Alignment.centerLeft,
                child: FractionallySizedBox(
                  widthFactor: _progressController.value,
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [
                          AppColors.pink,
                          AppColors.primary,
                          AppColors.cyan,
                        ],
                      ),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.primary.withValues(alpha: 0.6),
                          blurRadius: 10,
                          spreadRadius: 1,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),

        const SizedBox(height: 8),

        // Percentage Indicator
        AnimatedBuilder(
          animation: _progressController,
          builder: (context, child) {
            final percentage = (_progressController.value * 100).toInt();

            return Text(
              '$percentage%',
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            );
          },
        ),
      ],
    );
  }

  // Auth Action Buttons View
  Widget _buildAuthButtonsSection(bool isSmallScreen) {
    return AnimatedOpacity(
      duration: const Duration(milliseconds: 600),
      opacity: _showAuthButtons ? 1.0 : 0.0,
      child: Column(
        children: [
          // Sign In Button
          SizedBox(
            width: double.infinity,
            height: isSmallScreen ? 46 : 52,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/login');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(26),
                ),
                elevation: 8,
                shadowColor: AppColors.primary.withValues(alpha: 0.5),
              ),
              child: const Text(
                'Sign In',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),

          const SizedBox(height: 12),

          // Create Account Button
          SizedBox(
            width: double.infinity,
            height: isSmallScreen ? 46 : 52,
            child: OutlinedButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/signup');
              },
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: AppColors.primary, width: 1.5),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(26),
                ),
              ),
              child: const Text(
                'Create Account',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),

          const SizedBox(height: 20),

          // Divider Label
          Row(
            children: [
              Expanded(
                child: Container(height: 1, color: Colors.white12),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 12),
                child: Text(
                  'OR CONTINUE WITH',
                  style: TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1.2,
                  ),
                ),
              ),
              Expanded(
                child: Container(height: 1, color: Colors.white12),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // Social Icons Grid
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _socialButton(
                icon: Icons.g_mobiledata_rounded,
                iconSize: 32,
                color: Colors.redAccent,
                onTap: () => _handleSocialLogin('Google'),
              ),
              const SizedBox(width: 16),
              _socialButton(
                icon: Icons.apple,
                iconSize: 26,
                color: Colors.white,
                onTap: () => _handleSocialLogin('Apple'),
              ),
              const SizedBox(width: 16),
              _socialButton(
                icon: Icons.discord,
                iconSize: 24,
                color: const Color(0xFF5865F2),
                onTap: () => _handleSocialLogin('Discord'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Social Login Button Helper
  Widget _socialButton({
    required IconData icon,
    required double iconSize,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 64,
        height: 48,
        decoration: BoxDecoration(
          color: AppColors.cardBg.withValues(alpha: 0.9),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.white12),
        ),
        child: Center(
          child: Icon(
            icon,
            color: color,
            size: iconSize,
          ),
        ),
      ),
    );
  }

  void _handleSocialLoging(String provider) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$provider Login coming soon!'),
        backgroundColor: AppColors.cardBg,
        duration: const Duration(seconds: 1),
      ),
    );
  }

  void _handleSocialLogin(String provider) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$provider Login coming soon!'),
        backgroundColor: AppColors.cardBg,
        duration: const Duration(seconds: 1),
      ),
    );
  }
}