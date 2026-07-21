# ElimuPath - Rwandan School Finder

A Flutter mobile application that helps students and parents discover, compare, and apply to Rwandan secondary schools. Built with Clean Architecture, BLoC state management, and Firebase backend.

## Project Overview

ElimuPath enables users to:
- Browse and filter Rwandan schools by district, combinations, fees, and type
- Compare schools side-by-side
- Submit admission applications online
- Track application status in real-time
- Save favorite schools for later review
- School administrators can manage profiles, admissions, and announcements

## Tech Stack

- **Frontend**: Flutter (Dart)
- **State Management**: flutter_bloc (BLoC pattern)
- **Routing**: go_router
- **Dependency Injection**: get_it
- **Backend**: Firebase (Firestore, Authentication)
- **Local Storage**: shared_preferences

## Architecture

The project follows **Clean Architecture** with clear separation of concerns:

```
lib/
├── main.dart                  # Firebase init + DI + runApp
├── firebase_options.dart
├── core/
│   ├── di/injection.dart      # get_it registrations
│   ├── router/app_router.dart # go_router table + auth redirect
│   ├── theme/app_theme.dart   # light + dark ThemeData
│   ├── constants/             # colors, strings, combinations, validators
│   └── errors/failures.dart   # Failure classes for error handling
└── features/
    ├── auth/                  # Authentication feature
    │   ├── data/              # Models, Firebase datasource, repo impl
    │   ├── domain/            # Entities, repository interface
    │   └── presentation/     # Blocs, screens, widgets
    ├── schools/               # School discovery & management
    ├── applications/          # Admission applications
    ├── favorites/             # Saved schools
    └── announcements/         # School announcements
```

### Key Architecture Rule
**UI files never touch Firebase.** All Firebase interactions go through:
`Screen → Bloc → Repository interface → Firestore datasource`

## Setup Instructions

### Prerequisites
- Flutter SDK (3.11.5 or higher)
- Firebase project with Authentication and Firestore enabled
- Android Studio / Xcode for mobile development

### Installation

1. Clone the repository:
```bash
git clone <repository-url>
cd Elimupath
```

2. Install dependencies:
```bash
flutter pub get
```

3. Configure Firebase:
```bash
flutterfire configure
```
This will generate `firebase_options.dart` with your project configuration.

4. Run the app:
```bash
flutter run
```

### Firebase Setup

1. Enable Authentication providers:
   - Email/Password
   - Google Sign-In

2. Create Firestore collections (see ERD below):
   - `users`
   - `schools`
   - `applications`
   - `favorites`
   - `announcements`

3. Deploy Firestore security rules:
```bash
firebase deploy --only firestore:rules
```

4. Create composite indexes (see `FIRESTORE_INDEXES.md`)

## Database Architecture (ERD)

### Collections and Fields

| Collection | Fields (PK = doc ID) | Foreign Keys |
|------------|---------------------|--------------|
| **users** | fullName, email, role (student\|parent\|schoolAdmin), photoUrl, schoolId?, emailVerified, createdAt | schoolId → schools |
| **schools** | name, district, type (boarding/day), gender, combinations[], feesPerTerm, admissionStatus (open/closed), availableSlots, performanceIndex, facilities[], photos[], verified, adminId, contact, createdAt | adminId → users |
| **applications** | studentId, schoolId, combination, previousSchool, status (pending/accepted/rejected/withdrawn), submittedAt, updatedAt | studentId → users, schoolId → schools |
| **favorites** | userId, schoolId, addedAt | userId → users, schoolId → schools |
| **announcements** | schoolId, title, body, postedAt, postedBy | schoolId → schools, postedBy → users |

### Relationships
- users 1—N applications
- schools 1—N applications
- users N—N schools (through favorites)
- schools 1—N announcements
- users 1—1 schools (admin side)

## Firebase Security Rules

The security rules (`firestore.rules`) enforce:
- **users**: Read/write only if `request.auth.uid == userId`
- **schools**: Read if signed in; write only if `resource.data.adminId == request.auth.uid`
- **applications**: Create if student == auth.uid; read/update if owner OR school admin
- **favorites**: Read/write only own documents
- **announcements**: Read if signed in; write only by school admin

See `firestore.rules` for complete implementation.

## Implemented Features (Foundation)

### Part A - Architecture & Foundation (Kevin)
- ✅ Clean Architecture folder structure
- ✅ Domain entities for all features (User, School, Application, Favorite, Announcement)
- ✅ Repository interfaces for all features
- ✅ Data models with Firestore serialization
- ✅ Repository implementation stubs (marked for Olga to complete)
- ✅ Dependency injection container (get_it)
- ✅ Router with auth redirect logic
- ✅ Firestore composite indexes documentation
- ✅ Seed data for 15 Rwandan schools

### Part B - Authentication & Security (Frank)
- ✅ AuthBloc with BLoC pattern
- ✅ Auth states: AuthInitial, AuthLoading, Authenticated, Unauthenticated, AuthError, EmailVerificationSent, PasswordResetSent
- ✅ Auth events: AuthStarted, SignInWithEmail, SignInWithGoogle, Register, SignOut, PasswordReset
- ✅ Firebase Auth datasource with error mapping
- ✅ Email/password authentication
- ✅ Google Sign-In authentication
- ✅ Email verification enforcement (blocks home screen until verified)
- ✅ Password reset functionality
- ✅ Input validation (email regex, password ≥8 chars, required fields)
- ✅ Onboarding screen with SharedPreferences persistence
- ✅ Splash screen with onboarding flag check
- ✅ Auth screens: Login, Register, Forgot Password, Verify Email
- ✅ Firestore security rules
- ✅ Persistent auth state via `authStateChanges()`

## Pending Implementation

### Part C - UI Screens (Armstrong)
- [ ] Home/Discovery screen with search and filters
- [ ] School Detail screen with tabs
- [ ] Compare screen
- [ ] Favorites list
- [ ] My Applications screen
- [ ] Admin panel
- [ ] Settings UI
- [ ] Bottom navigation

### Part D - CRUD Operations (Olga)
- [ ] Implement Firestore datasources for schools, applications, favorites, announcements
- [ ] Implement repository methods with real Firestore operations
- [ ] Create BLoCs for each feature
- [ ] Wire BLoCs to screens
- [ ] Implement real-time data streams
- [ ] Error handling with snackbars

### Part E - Testing & Polish (Kenny)
- [ ] Settings feature with SharedPreferences (theme, language, notifications)
- [ ] Widget tests
- [ ] Unit tests (validators, BLoCs)
- [ ] Test coverage ≥ 70%
- [ ] `dart format` and `flutter analyze` (currently 0 issues)
- [ ] README with screenshots
- [ ] Demo video (10-15 min)

## Team Contributions

- **Kevin**: Architecture, ERD, Firebase foundation, repository interfaces
- **Frank**: Authentication, security rules, auth screens
- **Armstrong**: UI screens (pending)
- **Olga**: CRUD operations, BLoCs (pending)
- **Kenny**: Testing, settings, polish (pending)

## Code Quality

- ✅ `flutter analyze` shows 0 issues
- ✅ Clean Architecture with separation of concerns
- ✅ BLoC state management
- ✅ Type-safe with null safety
- ✅ Clear naming conventions
- ✅ TODO markers for pending work

## Known Limitations

- Repository implementations are stubs (throw UnimplementedError)
- Non-auth routes use placeholder screens
- No widget or unit tests yet
- Settings feature not implemented
- No composite indexes created in Firebase Console yet

## Future Work

- Complete Firestore CRUD operations
- Implement all BLoCs for state management
- Build all UI screens matching Figma prototype
- Add comprehensive testing
- Implement settings with theme persistence
- Create demo video
- Deploy to production

## License

This project is part of a mobile development course assignment.

## Contact

For questions about this project, please contact the development team.

