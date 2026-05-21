import 'package:metro_city_pulse/core/helpers/json_helper.dart';
import 'package:metro_city_pulse/core/helpers/mapper.dart';
import 'package:metro_city_pulse/domain/entities/map_data_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'map_data_model.g.dart';

@JsonSerializable()
class MapDataModel implements Mapper<MapDataEntity> {
  String id;
  PositionModel position;
  String label;
  String type;
  String caseStatus;
  String reportedBy;
  String vehicleNo;
  String reportedTime;
  String severity;
  LocationModel location;
  bool isLive;
  String imageUrl;
  @JsonKey(name: 'camera_url')
  String cameraUrl;

  MapDataModel({
    required this.id,
    required this.position,
    required this.label,
    required this.type,
    required this.caseStatus,
    required this.reportedBy,
    required this.vehicleNo,
    required this.reportedTime,
    required this.severity,
    required this.location,
    required this.isLive,
    required this.imageUrl,
    required this.cameraUrl,
  });

  factory MapDataModel.fromJson(Map<String, dynamic> json) =>
      _$MapDataModelFromJson(json);

  Map<String, dynamic> toJson() => _$MapDataModelToJson(this);

  factory MapDataModel.fromEntity(MapDataEntity entity) =>
      MapDataModel.fromJson(entity.toJson());

  @override
  MapDataEntity toEntity() => MapDataEntity.fromJson(toJson());
}

@JsonSerializable()
class PositionModel implements JsonHelper {
  double lat;
  double lng;

  PositionModel({required this.lat, required this.lng});

  factory PositionModel.fromJson(Map<String, dynamic> json) =>
      _$PositionModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$PositionModelToJson(this);
}

@JsonSerializable()
class LocationModel implements JsonHelper {
  String locationType;
  String locationName;
  String locationAddress;
  int currentCrowdCount;
  int crowdLimit;

  LocationModel({
    required this.locationType,
    required this.locationName,
    required this.locationAddress,
    required this.currentCrowdCount,
    required this.crowdLimit,
  });

  factory LocationModel.fromJson(Map<String, dynamic> json) =>
      _$LocationModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$LocationModelToJson(this);
}
