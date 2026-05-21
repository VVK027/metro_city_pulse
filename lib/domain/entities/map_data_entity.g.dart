// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'map_data_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MapDataEntity _$MapDataEntityFromJson(Map<String, dynamic> json) =>
    MapDataEntity(
      id: json['id'] as String?,
      type: json['type'] as String?,
      cameraName: json['cameraName'] as String?,
      locationName: json['locationName'] as String?,
      locationAddress: json['locationAddress'] as String?,
      locationType: json['locationType'] as String?,
      coordinates: json['coordinates'] == null
          ? null
          : CoordinatesEntity.fromJson(
              json['coordinates'] as Map<String, dynamic>,
            ),
      date: json['date'] as String?,
      time: json['time'] as String?,
      isoTimestamp: json['isoTimestamp'] as String?,
      confidenceScore: (json['confidenceScore'] as num?)?.toInt(),
      status: json['status'] as String?,
      severity: json['severity'] as String?,
      isLive: json['isLive'] as bool?,
      imageUrl: json['imageUrl'] as String?,
      cameraUrl: json['cameraUrl'] as String?,
      vehicleNo: json['vehicleNo'] as String?,
    );

Map<String, dynamic> _$MapDataEntityToJson(MapDataEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'cameraName': instance.cameraName,
      'locationName': instance.locationName,
      'locationAddress': instance.locationAddress,
      'locationType': instance.locationType,
      'coordinates': instance.coordinates,
      'date': instance.date,
      'time': instance.time,
      'isoTimestamp': instance.isoTimestamp,
      'confidenceScore': instance.confidenceScore,
      'status': instance.status,
      'severity': instance.severity,
      'isLive': instance.isLive,
      'imageUrl': instance.imageUrl,
      'cameraUrl': instance.cameraUrl,
      'vehicleNo': instance.vehicleNo,
    };

CoordinatesEntity _$CoordinatesEntityFromJson(Map<String, dynamic> json) =>
    CoordinatesEntity(
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$CoordinatesEntityToJson(CoordinatesEntity instance) =>
    <String, dynamic>{
      'latitude': instance.latitude,
      'longitude': instance.longitude,
    };
