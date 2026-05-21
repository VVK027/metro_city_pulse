import 'package:metro_city_pulse/domain/entities/alert_data.dart';

class AlertDataModel extends AlertData {
  AlertDataModel({
    required super.title,
    required super.timestamp,
    required super.id,
    required super.imageUrl,
    required super.camera,
    required super.location,
    required super.caseName,
  });

  factory AlertDataModel.fromJson(Map<String, dynamic> json) {
    return AlertDataModel(
      title: json['title'],
      timestamp: json['timestamp'],
      id: json['id'],
      imageUrl: json['imageUrl'],
      camera: json['camera'],
      location: json['location'],
      caseName: json['case'],
    );
  }
}
