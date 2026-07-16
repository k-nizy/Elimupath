import 'application_entity.dart';

abstract class ApplicationRepository {
  Stream<List<ApplicationEntity>> getApplicationsForStudent(String studentId);
  Stream<List<ApplicationEntity>> getApplicationsForSchool(String schoolId);
  Future<void> submitApplication(ApplicationEntity application);
  Future<void> updateApplicationStatus(String applicationId, String newStatus);
  Future<void> withdrawApplication(String applicationId);
}
