import 'package:get_it/get_it.dart';
import '../../features/auth/data/datasources/firebase_auth_datasource.dart';
import '../../features/auth/data/repositories/auth_repository_impl.dart';
import '../../features/auth/domain/auth_repository.dart';
import '../../features/auth/presentation/bloc/auth_bloc.dart';

final GetIt sl = GetIt.instance;

/// Call this function in main.dart BEFORE runApp().
/// Registers all repositories, blocs, and services.
///
/// Team members: when you implement a repository or bloc,
/// register it here so the rest of the app can find it.
Future<void> setupDependencies() async {
  // ── Auth ──
  // Datasource
  sl.registerLazySingleton<FirebaseAuthDatasource>(
    () => FirebaseAuthDatasource(),
  );

  // Repository
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(sl<FirebaseAuthDatasource>()),
  );

  // Bloc
  sl.registerFactory<AuthBloc>(
    () => AuthBloc(sl<AuthRepository>()),
  );

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
