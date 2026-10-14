import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

// Firebase Imports
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

// Constants & Colors
import 'core/constants/app_colors.dart';

// State Management Providers
import 'providers/auth_provider.dart';
import 'providers/fandom_provider.dart';

// Screens
import 'screens/1_auth/login_page.dart';
import 'screens/1_auth/signup_page.dart';
import 'screens/1_auth/splash_screen.dart';
import 'screens/9_admin/admin_dashboard.dart';
import 'widgets/main_navigation_bar.dart';

void main() async {
  // Ensure Flutter engine bindings are initialized
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase with current platform options
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const FandomVerseApp());
}

class FandomVerseApp extends StatelessWidget {
  const FandomVerseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => FandomProvider()),
      ],
      child: MaterialApp(
        title: 'FandomVerse',
        debugShowCheckedModeBanner: false,

        // --- GLOBAL APP DARK THEME ---
        theme: ThemeData(
          brightness: Brightness.dark,
          scaffoldBackgroundColor: AppColors.background,
          primaryColor: AppColors.primary,
          colorScheme: const ColorScheme.dark(
            primary: AppColors.primary,
            secondary: AppColors.pink,
            surface: AppColors.cardBg,
          ),
          textTheme: GoogleFonts.poppinsTextTheme(
            ThemeData.dark().textTheme,
          ),
          useMaterial3: true,
        ),

        // --- NAVIGATION ROUTING CONFIGURATION ---
        initialRoute: '/splash',
        routes: {
          '/splash': (context) => const SplashScreen(),
          '/login': (context) => const LoginPage(),
          '/signup': (context) => const SignupPage(),
          '/home': (context) => const MainNavigationBar(),
          '/9_admin': (context) => const AdminDashboard(),
        },
      ),
    );
  }
}