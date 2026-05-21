import 'package:metro_city_pulse/domain/entities/map_data_entity.dart';

abstract class MapRepository {
  Future<List<MapDataEntity>> getMapDataList();
}