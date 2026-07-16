import 'package:equatable/equatable.dart';

class SchoolEntity extends Equatable {
  final String id;
  final String name;
  final String district;
  final String type; // boarding, day
  final String gender;
  final List<String> combinations;
  final double feesPerTerm;
  final bool admissionStatus; // open/closed
  final int availableSlots;
  final double performanceIndex;
  final List<String> facilities;
  final List<String> photos;
  final bool verified;
  final String adminId;
  final String contact;
  final DateTime createdAt;

  const SchoolEntity({
    required this.id,
    required this.name,
    required this.district,
    required this.type,
    required this.gender,
    required this.combinations,
    required this.feesPerTerm,
    required this.admissionStatus,
    required this.availableSlots,
    required this.performanceIndex,
    required this.facilities,
    required this.photos,
    required this.verified,
    required this.adminId,
    required this.contact,
    required this.createdAt,
  });

  @override
  List<Object?> get props => [
        id, name, district, type, gender, combinations, feesPerTerm,
        admissionStatus, availableSlots, performanceIndex, facilities,
        photos, verified, adminId, contact, createdAt,
      ];
}
