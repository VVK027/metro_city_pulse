// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'map_data_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MapDataEntity _$MapDataEntityFromJson(Map<String, dynamic> json) =>
    MapDataEntity(
      id: json['id'] as String?,
      position: json['position'] == null
          ? null
          : PositionEntity.fromJson(json['position'] as Map<String, dynamic>),
      label: json['label'] as String?,
      type: json['type'] as String?,
      caseStatus: json['caseStatus'] as String?,
      reportedBy: json['reportedBy'] as String?,
      vehicleNo: json['vehicleNo'] as String?,
      reportedTime: json['reportedTime'] as String?,
      severity: json['severity'] as String?,
      confidenceScore: (json['confidence_score'] as num?)?.toInt(),
      location: json['location'] == null
          ? null
          : LocationEntity.fromJson(json['location'] as Map<String, dynamic>),
      isLive: json['isLive'] as bool?,
      imageUrl: json['imageUrl'] as String?,
      cameraUrl: json['camera_url'] as String?,
    );

Map<String, dynamic> _$MapDataEntityToJson(MapDataEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'position': instance.position,
      'label': instance.label,
      'type': instance.type,
      'caseStatus': instance.caseStatus,
      'reportedBy': instance.reportedBy,
      'vehicleNo': instance.vehicleNo,
      'reportedTime': instance.reportedTime,
      'severity': instance.severity,
      'confidence_score': instance.confidenceScore,
      'location': instance.location,
      'isLive': instance.isLive,
      'imageUrl': instance.imageUrl,
      'camera_url': instance.cameraUrl,
    };

PositionEntity _$PositionEntityFromJson(Map<String, dynamic> json) =>
    PositionEntity(
      lat: (json['lat'] as num?)?.toDouble(),
      lng: (json['lng'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$PositionEntityToJson(PositionEntity instance) =>
    <String, dynamic>{'lat': instance.lat, 'lng': instance.lng};

LocationEntity _$LocationEntityFromJson(Map<String, dynamic> json) =>
    LocationEntity(
      locationType: json['locationType'] as String?,
      locationName: json['locationName'] as String?,
      locationAddress: json['locationAddress'] as String?,
      currentCrowdCount: (json['currentCrowdCount'] as num?)?.toInt(),
      crowdLimit: (json['crowdLimit'] as num?)?.toInt(),
    );

Map<String, dynamic> _$LocationEntityToJson(LocationEntity instance) =>
    <String, dynamic>{
      'locationType': instance.locationType,
      'locationName': instance.locationName,
      'locationAddress': instance.locationAddress,
      'currentCrowdCount': instance.currentCrowdCount,
      'crowdLimit': instance.crowdLimit,
    };
