import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'core/di/injection.dart';
import 'core/theme/app_theme.dart';
import 'core/router/app_router.dart';
import 'features/auth/presentation/bloc/auth_bloc.dart';
import 'features/auth/presentation/bloc/auth_event.dart';
import 'features/auth/presentation/bloc/auth_state.dart';
// seed_data.dart was used once to populate Firestore — data is now live.

/// ElimuPath — Rwandan School Finder
///
/// Architecture: Clean Architecture + BLoC
/// State Management: flutter_bloc
/// Routing: go_router
/// DI: get_it
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await setupDependencies();

  runApp(const ElimuPathApp());
}

class ElimuPathApp extends StatelessWidget {
  const ElimuPathApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => sl<AuthBloc>()..add(const AuthStarted()),
        ),
        // TODO (Kenny): Add ThemeCubit / SettingsCubit here
      ],
      child: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          final isLoggedIn = state is Authenticated;
          final userRole = state is Authenticated ? state.user.role : null;
          final emailVerified = state is Authenticated ? state.user.emailVerified : false;

          final router = AppRouter.router(
            isLoggedIn: isLoggedIn,
            userRole: userRole,
            emailVerified: emailVerified,
          );

          return MaterialApp.router(
            title: 'ElimuPath',
            debugShowCheckedModeBanner: false,
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: ThemeMode.system,
            routerConfig: router,
          );
        },
      ),
    );
  }
}
