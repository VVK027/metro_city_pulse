// To initialize all the async dependencies, like SharedPreference, Firebase
import 'package:metro_city_pulse/core/dependency_manager.dart';
import 'package:metro_city_pulse/core/utils/translation_util.dart';

Future<void> configureDependencies() async {
  await DependencyManager.get().init();
  // await Firebase.initializeApp(); // <- Init Firebase
  await Future.wait([
  // Preload all locales before app starts
   TranslationCache.preload(['en', 'es']),
  ]).then((value) {
    
  },).onError((error, stackTrace) {
    
  },).catchError((error){

  }, test: (error) => true);
}