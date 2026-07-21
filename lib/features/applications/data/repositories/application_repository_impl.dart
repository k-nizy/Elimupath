import '../../domain/application_repository.dart';
import '../../domain/application_entity.dart';

/// Firestore implementation of ApplicationRepository.
/// TODO (Olga): Implement actual Firestore operations
class ApplicationRepositoryImpl implements ApplicationRepository {
  @override
  Stream<List<ApplicationEntity>> getApplicationsForStudent(String studentId) {
    // TODO (Olga): Implement Firestore query for student's applications
    throw UnimplementedError('ApplicationRepositoryImpl.getApplicationsForStudent not implemented');
  }

  @override
  Stream<List<ApplicationEntity>> getApplicationsForSchool(String schoolId) {
    // TODO (Olga): Implement Firestore query for school's applications
    throw UnimplementedError('ApplicationRepositoryImpl.getApplicationsForSchool not implemented');
  }

  @override
  Future<void> submitApplication(ApplicationEntity application) {
    // TODO (Olga): Implement Firestore document creation
    throw UnimplementedError('ApplicationRepositoryImpl.submitApplication not implemented');
  }

  @override
  Future<void> updateApplicationStatus(String applicationId, String newStatus) {
    // TODO (Olga): Implement Firestore document update
    throw UnimplementedError('ApplicationRepositoryImpl.updateApplicationStatus not implemented');
  }

  @override
  Future<void> withdrawApplication(String applicationId) {
    // TODO (Olga): Implement Firestore document deletion
    throw UnimplementedError('ApplicationRepositoryImpl.withdrawApplication not implemented');
  }
}
