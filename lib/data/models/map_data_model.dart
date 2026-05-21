import 'package:metro_city_pulse/core/helpers/json_helper.dart';
import 'package:metro_city_pulse/core/helpers/mapper.dart';
import 'package:metro_city_pulse/domain/entities/map_data_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'map_data_model.g.dart';

@JsonSerializable()
class MapDataModel implements Mapper<MapDataEntity> {
  String id;
  String type;
  String cameraName;
  String locationName;
  String locationAddress;
  String locationType;
  CoordinatesModel coordinates;
  String date;
  String time;
  String isoTimestamp;
  int confidenceScore;
  String status;
  String severity;
  bool isLive;
  String imageUrl;
  String cameraUrl;
  String? vehicleNo;

  MapDataModel({
    required this.id,
    required this.type,
    required this.cameraName,
    required this.locationName,
    required this.locationAddress,
    required this.locationType,
    required this.coordinates,
    required this.date,
    required this.time,
    required this.isoTimestamp,
    required this.confidenceScore,
    required this.status,
    required this.severity,
    required this.isLive,
    required this.imageUrl,
    required this.cameraUrl,
    this.vehicleNo,
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
class CoordinatesModel implements JsonHelper {
  double latitude;
  double longitude;

  CoordinatesModel({required this.latitude, required this.longitude});

  factory CoordinatesModel.fromJson(Map<String, dynamic> json) =>
      _$CoordinatesModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$CoordinatesModelToJson(this);
}
