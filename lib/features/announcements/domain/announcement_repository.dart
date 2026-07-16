import 'announcement_entity.dart';

abstract class AnnouncementRepository {
  Stream<List<AnnouncementEntity>> getSchoolAnnouncements(String schoolId);
  Future<void> postAnnouncement(AnnouncementEntity announcement);
  Future<void> deleteAnnouncement(String announcementId);
}
