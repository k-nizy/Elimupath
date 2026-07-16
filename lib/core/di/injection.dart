import 'package:get_it/get_it.dart';

final GetIt sl = GetIt.instance;

/// Call this function in main.dart BEFORE runApp().
/// Registers all repositories, blocs, and services.
///
/// Team members: when you implement a repository or bloc,
/// register it here so the rest of the app can find it.
Future<void> setupDependencies() async {
  // ── Auth ──
  // TODO (Frank): Register AuthRepository implementation
  // sl.registerLazySingleton<AuthRepository>(() => FirebaseAuthRepository());

  // ── Schools ──
  // TODO (Olga): Register SchoolRepository implementation
  // sl.registerLazySingleton<SchoolRepository>(() => FirestoreSchoolRepository());

  // ── Applications ──
  // TODO (Olga): Register ApplicationRepository implementation
  // sl.registerLazySingleton<ApplicationRepository>(() => FirestoreApplicationRepository());

  // ── Favorites ──
  // TODO (Olga): Register FavoriteRepository implementation
  // sl.registerLazySingleton<FavoriteRepository>(() => FirestoreFavoriteRepository());

  // ── Announcements ──
  // TODO (Olga): Register AnnouncementRepository implementation
  // sl.registerLazySingleton<AnnouncementRepository>(() => FirestoreAnnouncementRepository());

  // ── Blocs ──
  // TODO (Frank): Register AuthBloc
  // TODO (Olga): Register SchoolsBloc, ApplicationsBloc, FavoritesBloc, AnnouncementsBloc
  // TODO (Kenny): Register SettingsCubit
}
