import 'school_entity.dart';

abstract class SchoolRepository {
  Stream<List<SchoolEntity>> getSchools({
    String? district,
    String? combination,
    double? maxFees,
    bool? boardingOnly,
    bool? admissionOpenOnly,
  });
  Future<SchoolEntity?> getSchoolById(String id);
  Future<void> updateSchoolProfile(SchoolEntity school);
  Future<void> toggleAdmissionStatus(String schoolId, bool isOpen);
}
