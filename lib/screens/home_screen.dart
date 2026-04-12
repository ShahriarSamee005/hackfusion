import 'package:flutter/material.dart';
import '../services/app_theme.dart';
import '../services/auth_service.dart';
import '../widgets/widgets.dart';
import 'login_screen.dart';

class HomeScreen extends StatelessWidget {
  final String name;
  final String email;
  const HomeScreen({super.key, required this.name, required this.email});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: AppBackground(
        child: SafeArea(
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.check_circle_rounded,
                    color: AppColors.mint, size: 64),
                const SizedBox(height: 16),
                Text(
                  'Hello, ${name.isNotEmpty ? name.split(' ').first : 'there'}!',
                  style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w800,
                      color: AppColors.text),
                ),
                const SizedBox(height: 6),
                Text(email,
                    style: const TextStyle(
                        fontSize: 13, color: AppColors.textMuted)),
                const SizedBox(height: 40),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: PrimaryButton(
                    label: 'Logout',
                    icon: Icons.logout_rounded,
                    color: AppColors.error,
                    onTap: () async {
                      await AuthService.logout();
                      if (context.mounted) {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const LoginScreen()),
                          (_) => false,
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}