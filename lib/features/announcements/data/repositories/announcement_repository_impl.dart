import '../../domain/announcement_repository.dart';
import '../../domain/announcement_entity.dart';

/// Firestore implementation of AnnouncementRepository.
/// TODO (Olga): Implement actual Firestore operations
class AnnouncementRepositoryImpl implements AnnouncementRepository {
  @override
  Stream<List<AnnouncementEntity>> getSchoolAnnouncements(String schoolId) {
    // TODO (Olga): Implement Firestore query for school's announcements
    throw UnimplementedError('AnnouncementRepositoryImpl.getSchoolAnnouncements not implemented');
  }

  @override
  Future<void> postAnnouncement(AnnouncementEntity announcement) {
    // TODO (Olga): Implement Firestore document creation
    throw UnimplementedError('AnnouncementRepositoryImpl.postAnnouncement not implemented');
  }

  @override
  Future<void> deleteAnnouncement(String announcementId) {
    // TODO (Olga): Implement Firestore document deletion
    throw UnimplementedError('AnnouncementRepositoryImpl.deleteAnnouncement not implemented');
  }
}
