import 'package:flutter/material.dart';
// TODO (Frank): Re-add 'package:flutter_bloc/flutter_bloc.dart' when wiring MultiBlocProvider
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'core/di/injection.dart';
import 'core/theme/app_theme.dart';
import 'core/router/app_router.dart';
// seed_data.dart was used once to populate Firestore — data is now live.

/// ElimuPath — Rwandan School Finder
///
/// Architecture: Clean Architecture + BLoC
/// State Management: flutter_bloc
/// Routing: go_router
/// DI: get_it
///
/// Firebase initialization is commented out until firebase_options.dart
/// is generated via `flutterfire configure`. Uncomment the lines below
/// once Firebase is connected.
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
    // TODO (Frank): Wrap with MultiBlocProvider and provide AuthBloc
    // TODO (Kenny): Provide ThemeCubit / SettingsCubit here

    // Temporary: hardcoded auth state.
    // Once AuthBloc is wired, this will read from bloc state.
    final router = AppRouter.router(
      isLoggedIn: false,
      userRole: null,
    );

    return MaterialApp.router(
      title: 'ElimuPath',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      routerConfig: router,
    );
  }
}
