import 'package:metro_city_pulse/core/dependency_manager.dart';
import 'package:metro_city_pulse/data/repositories/auth_repository_impl.dart';
import 'package:metro_city_pulse/data/repositories/local/local_repository_impl.dart';
import 'package:metro_city_pulse/data/repositories/map_repository_impl.dart';
import 'package:metro_city_pulse/domain/repositories/auth_repository.dart';
import 'package:metro_city_pulse/domain/repositories/local/local_repository.dart';
import 'package:metro_city_pulse/domain/repositories/map_repository.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'repository_provider.g.dart';

@riverpod
LocalRepository localRepository(Ref ref) => LocalRepositoryImpl(DependencyManager.get().getDbManager(), DependencyManager.get().getSharedPref());

@riverpod
AuthRepository authRepository(Ref ref) => AuthRepositoryImpl();

@riverpod
MapRepository mapRepository(Ref ref) => MapRepositoryImp();

void refreshAllApiServiceProvider(dynamic ref) {
  ref.invalidate(authRepositoryProvider);
  ref.invalidate(mapRepositoryProvider);
}
