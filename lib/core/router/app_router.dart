import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../features/auth/presentation/screens/splash_screen.dart';
import '../../features/auth/presentation/screens/onboarding_screen.dart';
import '../../features/auth/presentation/screens/login_screen.dart';
import '../../features/auth/presentation/screens/register_screen.dart';
import '../../features/auth/presentation/screens/forgot_password_screen.dart';
import '../../features/auth/presentation/screens/verify_email_screen.dart';

/// The central router for ElimuPath.
///
/// Auth redirect logic:
///   - Not logged in       → /login
///   - Logged in but not verified → /verify-email
///   - Logged in (student) → /home
///   - Logged in (admin)   → /admin
///
/// The [isLoggedIn], [userRole], and [emailVerified] values should come from
/// AuthBloc state once Frank wires it up.
class AppRouter {
  /// Build the GoRouter instance.
  /// Pass in auth state so the redirect can react to login changes.
  static GoRouter router({
    required bool isLoggedIn,
    required String? userRole,
    required bool emailVerified,
  }) {
    return GoRouter(
      initialLocation: '/login',
      redirect: (context, state) {
        final loggingIn = state.matchedLocation == '/login' ||
            state.matchedLocation == '/register' ||
            state.matchedLocation == '/forgot-password' ||
            state.matchedLocation == '/onboarding' ||
            state.matchedLocation == '/verify-email';

        // Not logged in → force to login (unless already there)
        if (!isLoggedIn) {
          return loggingIn ? null : '/login';
        }

        // Logged in but email not verified → force to verification screen
        if (!emailVerified && state.matchedLocation != '/verify-email') {
          return '/verify-email';
        }

        // Logged in but still on a login page → send to correct home
        if (loggingIn && emailVerified) {
          return userRole == 'schoolAdmin' ? '/admin' : '/home';
        }

        // Otherwise, stay on current route
        return null;
      },
      routes: [
        // ── Auth routes (Frank) ──
        GoRoute(
          path: '/splash',
          name: 'splash',
          builder: (context, state) => const SplashScreen(),
        ),
        GoRoute(
          path: '/onboarding',
          name: 'onboarding',
          builder: (context, state) => const OnboardingScreen(),
        ),
        GoRoute(
          path: '/login',
          name: 'login',
          builder: (context, state) => const LoginScreen(),
        ),
        GoRoute(
          path: '/register',
          name: 'register',
          builder: (context, state) => const RegisterScreen(),
        ),
        GoRoute(
          path: '/forgot-password',
          name: 'forgot-password',
          builder: (context, state) => const ForgotPasswordScreen(),
        ),
        GoRoute(
          path: '/verify-email',
          name: 'verify-email',
          builder: (context, state) => const VerifyEmailScreen(),
        ),

        // ── Student/Parent routes (Armstrong) ──
        GoRoute(
          path: '/home',
          name: 'home',
          builder: (context, state) => const _PlaceholderScreen(title: 'Home'),
        ),
        GoRoute(
          path: '/school/:id',
          name: 'school-detail',
          builder: (context, state) =>
              const _PlaceholderScreen(title: 'School Detail'),
        ),
        GoRoute(
          path: '/compare',
          name: 'compare',
          builder: (context, state) =>
              const _PlaceholderScreen(title: 'Compare'),
        ),
        GoRoute(
          path: '/favorites',
          name: 'favorites',
          builder: (context, state) =>
              const _PlaceholderScreen(title: 'Favorites'),
        ),
        GoRoute(
          path: '/applications',
          name: 'applications',
          builder: (context, state) =>
              const _PlaceholderScreen(title: 'My Applications'),
        ),
        GoRoute(
          path: '/settings',
          name: 'settings',
          builder: (context, state) =>
              const _PlaceholderScreen(title: 'Settings'),
        ),

        // ── Admin routes (Armstrong) ──
        GoRoute(
          path: '/admin',
          name: 'admin',
          builder: (context, state) => const _PlaceholderScreen(title: 'Admin Panel'),
        ),
      ],
    );
  }
}

/// Temporary placeholder screen for non-auth routes.
/// Armstrong will replace each of these with real screens.
class _PlaceholderScreen extends StatelessWidget {
  final String title;
  const _PlaceholderScreen({required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(
        child: Text(
          '$title\n(Coming Soon)',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
    );
  }
}
