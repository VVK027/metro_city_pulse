// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'map_data_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MapDataModel _$MapDataModelFromJson(Map<String, dynamic> json) => MapDataModel(
  id: json['id'] as String,
  position: PositionModel.fromJson(json['position'] as Map<String, dynamic>),
  label: json['label'] as String,
  type: json['type'] as String,
  caseStatus: json['caseStatus'] as String,
  reportedBy: json['reportedBy'] as String,
  vehicleNo: json['vehicleNo'] as String,
  reportedTime: json['reportedTime'] as String,
  severity: json['severity'] as String,
  location: LocationModel.fromJson(json['location'] as Map<String, dynamic>),
  isLive: json['isLive'] as bool,
  imageUrl: json['imageUrl'] as String,
  cameraUrl: json['camera_url'] as String,
);

Map<String, dynamic> _$MapDataModelToJson(MapDataModel instance) =>
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
      'location': instance.location,
      'isLive': instance.isLive,
      'imageUrl': instance.imageUrl,
      'camera_url': instance.cameraUrl,
    };

PositionModel _$PositionModelFromJson(Map<String, dynamic> json) =>
    PositionModel(
      lat: (json['lat'] as num).toDouble(),
      lng: (json['lng'] as num).toDouble(),
    );

Map<String, dynamic> _$PositionModelToJson(PositionModel instance) =>
    <String, dynamic>{'lat': instance.lat, 'lng': instance.lng};

LocationModel _$LocationModelFromJson(Map<String, dynamic> json) =>
    LocationModel(
      locationType: json['locationType'] as String,
      locationName: json['locationName'] as String,
      locationAddress: json['locationAddress'] as String,
      currentCrowdCount: (json['currentCrowdCount'] as num).toInt(),
      crowdLimit: (json['crowdLimit'] as num).toInt(),
    );

Map<String, dynamic> _$LocationModelToJson(LocationModel instance) =>
    <String, dynamic>{
      'locationType': instance.locationType,
      'locationName': instance.locationName,
      'locationAddress': instance.locationAddress,
      'currentCrowdCount': instance.currentCrowdCount,
      'crowdLimit': instance.crowdLimit,
    };
