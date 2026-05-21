import 'package:metro_city_pulse/core/helpers/json_helper.dart';
import 'package:json_annotation/json_annotation.dart';

part 'map_data_entity.g.dart';

@JsonSerializable()
class MapDataEntity {
  String? id;
  PositionEntity? position;
  String? label;
  String? type;
  String? caseStatus;
  String? reportedBy;
  String? vehicleNo;
  String? reportedTime;
  String? severity;
  @JsonKey(name: 'confidence_score')
  int? confidenceScore;
  LocationEntity? location;
  bool? isLive;
  String? imageUrl;
  @JsonKey(name: 'camera_url')
  String? cameraUrl;

  MapDataEntity({
    this.id,
    this.position,
    this.label,
    this.type,
    this.caseStatus,
    this.reportedBy,
    this.vehicleNo,
    this.reportedTime,
    this.severity,
    this.confidenceScore,
    this.location,
    this.isLive,
    this.imageUrl,
    this.cameraUrl,
  });

  factory MapDataEntity.fromJson(Map<String, dynamic> json) =>
      _$MapDataEntityFromJson(json);

  Map<String, dynamic> toJson() => _$MapDataEntityToJson(this);
}

@JsonSerializable()
class PositionEntity implements JsonHelper {
  double? lat;
  double? lng;

  PositionEntity({this.lat, this.lng});

  factory PositionEntity.fromJson(Map<String, dynamic> json) =>
      _$PositionEntityFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$PositionEntityToJson(this);
}

@JsonSerializable()
class LocationEntity implements JsonHelper {
  String? locationType;
  String? locationName;
  String? locationAddress;
  int? currentCrowdCount;
  int? crowdLimit;

  LocationEntity({
    this.locationType,
    this.locationName,
    this.locationAddress,
    this.currentCrowdCount,
    this.crowdLimit,
  });

  factory LocationEntity.fromJson(Map<String, dynamic> json) =>
      _$LocationEntityFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$LocationEntityToJson(this);
}
