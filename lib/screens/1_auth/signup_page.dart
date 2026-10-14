import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../core/constants/app_colors.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
  TextEditingController();

  bool _hidePassword = true;
  bool _hideConfirmPassword = true;
  bool _isLoading = false;

  // FIREBASE AUTH INSTANCE
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  // FIREBASE SIGN UP FUNCTION
  Future<void> _handleSignUp() async {
    final name = _nameController.text.trim();
    final email = _emailController.text.trim();
    final password = _passwordController.text;
    final confirmPassword = _confirmPasswordController.text;

    if (name.isEmpty || email.isEmpty || password.isEmpty) {
      _showSnackBar('Tamam fields ko fill karein!');
      return;
    }

    if (password != confirmPassword) {
      _showSnackBar('Passwords match nahi ho rahe!');
      return;
    }

    if (password.length < 6) {
      _showSnackBar('Password kam se kam 6 characters ka hona chahiye!');
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      // 1. Create User with Email and Password
      UserCredential userCredential =
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // 2. Update Display Name in Firebase Profile
      if (userCredential.user != null) {
        await userCredential.user!.updateDisplayName(name);
      }

      if (mounted) {
        // Success -> Navigate to Home
        Navigator.pushNamedAndRemoveUntil(
          context,
          '/home',
              (route) => false,
        );
      }
    } on FirebaseAuthException catch (e) {
      String errorMessage = 'Sign Up me masla aaya hai. Dubara koshish karein.';
      if (e.code == 'email-already-in-use') {
        errorMessage = 'Yeh email pehle se registered hai!';
      } else if (e.code == 'invalid-email') {
        errorMessage = 'Email address ka format sahi nahi hai.';
      } else if (e.code == 'weak-password') {
        errorMessage = 'Password zyada kamzor hai.';
      } else if (e.message != null) {
        errorMessage = e.message!;
      }
      _showSnackBar(errorMessage);
    } catch (e) {
      _showSnackBar('Ek unexpected error aaya: ${e.toString()}');
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  void _showSnackBar(String text) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(text),
        backgroundColor: AppColors.cardBg,
        duration: const Duration(seconds: 3),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          // Background Glow Image
          Positioned.fill(
            child: Image.asset(
              'assets/images/fandom_background.png',
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xFF0D0628), Color(0xFF05021A)],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                );
              },
            ),
          ),

          // Dark Overlay
          Positioned.fill(
            child: Container(
              color: Colors.black.withValues(alpha: 0.35),
            ),
          ),

          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding:
                const EdgeInsets.symmetric(horizontal: 28, vertical: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // TOP BAR WITH BACK BUTTON
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            if (Navigator.canPop(context)) {
                              Navigator.pop(context);
                            } else {
                              Navigator.pushReplacementNamed(
                                  context, '/login');
                            }
                          },
                          child: Container(
                            height: 42,
                            width: 42,
                            decoration: BoxDecoration(
                              color: AppColors.cardBg.withValues(alpha: 0.8),
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white12),
                            ),
                            child: const Icon(
                              Icons.arrow_back_rounded,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 10),

                    // FANDOM LOGO
                    Image.asset(
                      'assets/images/fandom_logo_clean.png',
                      width: 200,
                      height: 120,
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.cardBg.withValues(alpha: 0.5),
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.primary
                                    .withValues(alpha: 0.4),
                                blurRadius: 25,
                                spreadRadius: 3,
                              ),
                            ],
                          ),
                          child: const Icon(
                            Icons.public_rounded,
                            size: 55,
                            color: AppColors.cyan,
                          ),
                        );
                      },
                    ),

                    const SizedBox(height: 12),

                    // TITLE
                    const Text(
                      'Create Your Account',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 6),

                    const Text(
                      'Join FandomVerse and be part of something amazing',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 13,
                      ),
                    ),

                    const SizedBox(height: 28),

                    // FULL NAME INPUT
                    _inputField(
                      controller: _nameController,
                      icon: Icons.person_outline_rounded,
                      hint: 'Full Name',
                    ),

                    const SizedBox(height: 14),

                    // EMAIL INPUT
                    _inputField(
                      controller: _emailController,
                      icon: Icons.mail_outline_rounded,
                      hint: 'Email Address',
                      type: TextInputType.emailAddress,
                    ),

                    const SizedBox(height: 14),

                    // PASSWORD INPUT
                    _passwordField(
                      controller: _passwordController,
                      hint: 'Password',
                      hide: _hidePassword,
                      onToggle: () {
                        setState(() {
                          _hidePassword = !_hidePassword;
                        });
                      },
                    ),

                    const SizedBox(height: 14),

                    // CONFIRM PASSWORD INPUT
                    _passwordField(
                      controller: _confirmPasswordController,
                      hint: 'Confirm Password',
                      hide: _hideConfirmPassword,
                      onToggle: () {
                        setState(() {
                          _hideConfirmPassword = !_hideConfirmPassword;
                        });
                      },
                    ),

                    const SizedBox(height: 28),

                    // SIGN UP GRADIENT BUTTON (WITH LOADING)
                    _gradientButton(
                      text: 'Sign Up',
                      isLoading: _isLoading,
                      onPressed: _isLoading ? () {} : _handleSignUp,
                    ),

                    const SizedBox(height: 28),

                    // LOGIN NAVIGATION LINK
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Already have an account? ',
                          style: TextStyle(
                            color: AppColors.textSecondary,
                            fontSize: 14,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushReplacementNamed(context, '/login');
                          },
                          child: const Text(
                            'Login',
                            style: TextStyle(
                              color: AppColors.cyan,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // REUSABLE INPUT FIELD WIDGET
  Widget _inputField({
    required TextEditingController controller,
    required IconData icon,
    required String hint,
    TextInputType type = TextInputType.text,
  }) {
    return Container(
      height: 56,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: AppColors.cardBg.withValues(alpha: 0.85),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: Colors.white12,
          width: 1.2,
        ),
      ),
      child: TextField(
        controller: controller,
        keyboardType: type,
        style: const TextStyle(color: Colors.white, fontSize: 15),
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hint,
          hintStyle: const TextStyle(
            color: AppColors.textSecondary,
            fontSize: 14,
          ),
          prefixIcon: Icon(
            icon,
            color: AppColors.cyan,
            size: 22,
          ),
          contentPadding: const EdgeInsets.symmetric(vertical: 16),
        ),
      ),
    );
  }

  // REUSABLE PASSWORD FIELD WIDGET
  Widget _passwordField({
    required TextEditingController controller,
    required String hint,
    required bool hide,
    required VoidCallback onToggle,
  }) {
    return Container(
      height: 56,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: AppColors.cardBg.withValues(alpha: 0.85),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: Colors.white12,
          width: 1.2,
        ),
      ),
      child: TextField(
        controller: controller,
        obscureText: hide,
        style: const TextStyle(color: Colors.white, fontSize: 15),
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hint,
          hintStyle: const TextStyle(
            color: AppColors.textSecondary,
            fontSize: 14,
          ),
          prefixIcon: const Icon(
            Icons.lock_outline_rounded,
            color: AppColors.cyan,
            size: 22,
          ),
          suffixIcon: IconButton(
            onPressed: onToggle,
            icon: Icon(
              hide
                  ? Icons.visibility_off_outlined
                  : Icons.visibility_outlined,
              color: AppColors.textSecondary,
              size: 20,
            ),
          ),
          contentPadding: const EdgeInsets.symmetric(vertical: 16),
        ),
      ),
    );
  }

  // REUSABLE GRADIENT BUTTON WIDGET
  Widget _gradientButton({
    required String text,
    required bool isLoading,
    required VoidCallback onPressed,
  }) {
    return Container(
      width: double.infinity,
      height: 54,
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
            color: AppColors.primary.withValues(alpha: 0.4),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        child: isLoading
            ? const SizedBox(
          height: 24,
          width: 24,
          child: CircularProgressIndicator(
            color: Colors.white,
            strokeWidth: 2.5,
          ),
        )
            : Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}