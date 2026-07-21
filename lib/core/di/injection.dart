import 'package:get_it/get_it.dart';
import '../../features/auth/data/datasources/firebase_auth_datasource.dart';
import '../../features/auth/data/repositories/auth_repository_impl.dart';
import '../../features/auth/domain/auth_repository.dart';
import '../../features/auth/presentation/bloc/auth_bloc.dart';
import '../../features/schools/data/repositories/school_repository_impl.dart';
import '../../features/schools/domain/school_repository.dart';
import '../../features/applications/data/repositories/application_repository_impl.dart';
import '../../features/applications/domain/application_repository.dart';
import '../../features/favorites/data/repositories/favorite_repository_impl.dart';
import '../../features/favorites/domain/favorite_repository.dart';
import '../../features/announcements/data/repositories/announcement_repository_impl.dart';
import '../../features/announcements/domain/announcement_repository.dart';

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
  sl.registerLazySingleton<SchoolRepository>(
    () => SchoolRepositoryImpl(),
  );

  // ── Applications ──
  sl.registerLazySingleton<ApplicationRepository>(
    () => ApplicationRepositoryImpl(),
  );

  // ── Favorites ──
  sl.registerLazySingleton<FavoriteRepository>(
    () => FavoriteRepositoryImpl(),
  );

  // ── Announcements ──
  sl.registerLazySingleton<AnnouncementRepository>(
    () => AnnouncementRepositoryImpl(),
  );

  // ── Blocs ──
  // TODO (Olga): Register SchoolsBloc, ApplicationsBloc, FavoritesBloc, AnnouncementsBloc
  // TODO (Kenny): Register SettingsCubit
}
