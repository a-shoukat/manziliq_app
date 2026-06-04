import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_routes.dart';
import '../../core/constants/app_strings.dart';
import '../../models/user_model.dart';
import '../../providers/auth_provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    _scaleAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeOutBack,
      ),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.2, 1.0, curve: Curves.easeIn),
      ),
    );

    _animationController.forward();
    
    _bootstrap();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Future<void> _bootstrap() async {
    final auth = context.read<AuthProvider>();
    await auth.init();
    
    // Add a minimum delay so the beautiful animation can be fully seen
    await Future.delayed(const Duration(seconds: 2));
    
    if (!mounted) return;

    if (!auth.isLoggedIn) {
      context.go(AppRoutes.login);
      return;
    }
    if (!auth.isApproved) {
      context.go(AppRoutes.pendingApproval);
      return;
    }
    if (!auth.user!.emailVerified) {
      context.go(AppRoutes.otp, extra: {'email': auth.user!.email});
      return;
    }
    context.go(_homeForRole(auth.user!.role));
  }

  String _homeForRole(UserRole role) => switch (role) {
        UserRole.admin => AppRoutes.adminDashboard,
        UserRole.society => AppRoutes.societyDashboard,
        UserRole.dealer => AppRoutes.dealerDashboard,
        UserRole.customer => AppRoutes.customerDashboard,
      };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ScaleTransition(
              scale: _scaleAnimation,
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: Image.asset(
                  'assets/images/logo.png',
                  width: 250,
                  height: 250,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) {
                    // Fallback if image is not found or not placed yet
                    return const Icon(Icons.home_work, size: 100, color: AppColors.primary);
                  },
                ),
              ),
            ),
            const SizedBox(height: 32),
            FadeTransition(
              opacity: _fadeAnimation,
              child: Column(
                children: [
                  Text(
                    AppStrings.appName,
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          color: AppColors.primary,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.2,
                        ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    AppStrings.tagline,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.black54,
                          letterSpacing: 0.5,
                        ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 48),
                  const CircularProgressIndicator(color: AppColors.primary),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
