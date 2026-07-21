import '../../domain/school_repository.dart';
import '../../domain/school_entity.dart';

/// Firestore implementation of SchoolRepository.
/// TODO (Olga): Implement actual Firestore operations
class SchoolRepositoryImpl implements SchoolRepository {
  @override
  Stream<List<SchoolEntity>> getSchools({
    String? district,
    String? combination,
    double? maxFees,
    bool? boardingOnly,
    bool? admissionOpenOnly,
  }) {
    // TODO (Olga): Implement Firestore query with filters
    throw UnimplementedError('SchoolRepositoryImpl.getSchools not implemented');
  }

  @override
  Future<SchoolEntity?> getSchoolById(String id) {
    // TODO (Olga): Implement Firestore document fetch
    throw UnimplementedError('SchoolRepositoryImpl.getSchoolById not implemented');
  }

  @override
  Future<void> updateSchoolProfile(SchoolEntity school) {
    // TODO (Olga): Implement Firestore document update
    throw UnimplementedError('SchoolRepositoryImpl.updateSchoolProfile not implemented');
  }

  @override
  Future<void> toggleAdmissionStatus(String schoolId, bool isOpen) {
    // TODO (Olga): Implement Firestore field update
    throw UnimplementedError('SchoolRepositoryImpl.toggleAdmissionStatus not implemented');
  }
}
