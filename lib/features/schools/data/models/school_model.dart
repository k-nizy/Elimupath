import 'package:equatable/equatable.dart';
import '../../domain/school_entity.dart';

class SchoolModel extends Equatable {
  final String id;
  final String name;
  final String district;
  final String type;
  final String gender;
  final List<String> combinations;
  final double feesPerTerm;
  final bool admissionStatus;
  final int availableSlots;
  final double performanceIndex;
  final List<String> facilities;
  final List<String> photos;
  final bool verified;
  final String adminId;
  final String contact;
  final DateTime createdAt;

  const SchoolModel({
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

  factory SchoolModel.fromJson(Map<String, dynamic> json, String id) {
    return SchoolModel(
      id: id,
      name: json['name'] as String,
      district: json['district'] as String,
      type: json['type'] as String,
      gender: json['gender'] as String,
      combinations: List<String>.from(json['combinations'] as List),
      feesPerTerm: (json['feesPerTerm'] as num).toDouble(),
      admissionStatus: json['admissionStatus'] as bool,
      availableSlots: json['availableSlots'] as int,
      performanceIndex: (json['performanceIndex'] as num).toDouble(),
      facilities: List<String>.from(json['facilities'] as List),
      photos: List<String>.from(json['photos'] as List),
      verified: json['verified'] as bool,
      adminId: json['adminId'] as String,
      contact: json['contact'] as String,
      createdAt: (json['createdAt'] as dynamic).toDate(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'district': district,
      'type': type,
      'gender': gender,
      'combinations': combinations,
      'feesPerTerm': feesPerTerm,
      'admissionStatus': admissionStatus,
      'availableSlots': availableSlots,
      'performanceIndex': performanceIndex,
      'facilities': facilities,
      'photos': photos,
      'verified': verified,
      'adminId': adminId,
      'contact': contact,
      'createdAt': createdAt,
    };
  }

  SchoolEntity toEntity() {
    return SchoolEntity(
      id: id,
      name: name,
      district: district,
      type: type,
      gender: gender,
      combinations: combinations,
      feesPerTerm: feesPerTerm,
      admissionStatus: admissionStatus,
      availableSlots: availableSlots,
      performanceIndex: performanceIndex,
      facilities: facilities,
      photos: photos,
      verified: verified,
      adminId: adminId,
      contact: contact,
      createdAt: createdAt,
    );
  }

  factory SchoolModel.fromEntity(SchoolEntity entity) {
    return SchoolModel(
      id: entity.id,
      name: entity.name,
      district: entity.district,
      type: entity.type,
      gender: entity.gender,
      combinations: entity.combinations,
      feesPerTerm: entity.feesPerTerm,
      admissionStatus: entity.admissionStatus,
      availableSlots: entity.availableSlots,
      performanceIndex: entity.performanceIndex,
      facilities: entity.facilities,
      photos: entity.photos,
      verified: entity.verified,
      adminId: entity.adminId,
      contact: entity.contact,
      createdAt: entity.createdAt,
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        district,
        type,
        gender,
        combinations,
        feesPerTerm,
        admissionStatus,
        availableSlots,
        performanceIndex,
        facilities,
        photos,
        verified,
        adminId,
        contact,
        createdAt,
      ];
}
