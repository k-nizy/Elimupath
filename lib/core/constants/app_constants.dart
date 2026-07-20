/// All subject combinations offered in Rwandan A-Level schools.
class Combinations {
  static const List<String> all = [
    'MPC', // Math, Physics, Computer Science
    'MCB', // Math, Chemistry, Biology
    'PCB', // Physics, Chemistry, Biology
    'PCM', // Physics, Chemistry, Math
    'MPG', // Math, Physics, Geography
    'MCE', // Math, Computer Science, Economics
    'HEG', // History, Economics, Geography
    'HEL', // History, Economics, Literature
    'HGL', // History, Geography, Literature
    'MEG', // Math, Economics, Geography
    'MFK', // Math, French, Kinyarwanda
    'LEG', // Literature, Economics, Geography
  ];
}

/// Rwandan districts for school filtering.
class Districts {
  static const List<String> all = [
    'Gasabo', 'Kicukiro', 'Nyarugenge', // Kigali
    'Bugesera', 'Gatsibo', 'Kayonza', 'Kirehe',
    'Ngoma', 'Nyagatare', 'Rwamagana', // Eastern
    'Gicumbi', 'Gakenke', 'Musanze', 'Rulindo', 'Burera', // Northern
    'Huye', 'Gisagara', 'Kamonyi', 'Muhanga',
    'Nyamagabe', 'Nyanza', 'Nyaruguru', 'Ruhango', // Southern
    'Karongi', 'Ngororero', 'Nyabihu', 'Nyamasheke',
    'Rubavu', 'Rusizi', 'Rutsiro', // Western
  ];
}

/// Application status values.
class AppStatus {
  static const String pending = 'pending';
  static const String accepted = 'accepted';
  static const String rejected = 'rejected';
  static const String withdrawn = 'withdrawn';
}

/// User role values.
class UserRoles {
  static const String student = 'student';
  static const String parent = 'parent';
  static const String schoolAdmin = 'schoolAdmin';
}

/// Input validators for authentication forms.
/// These are pure functions that can be unit tested.
class Validators {
  /// Email validation using regex.
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value)) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  /// Password validation - minimum 8 characters.
  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    if (value.length < 8) {
      return 'Password must be at least 8 characters';
    }
    return null;
  }

  /// Full name validation.
  static String? validateFullName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Full name is required';
    }
    if (value.length < 2) {
      return 'Name must be at least 2 characters';
    }
    return null;
  }

  /// Required field validation.
  static String? validateRequired(String? value, String fieldName) {
    if (value == null || value.isEmpty) {
      return '$fieldName is required';
    }
    return null;
  }
}
