import 'package:metro_city_pulse/data/data_source/local/db_manager.dart';
import 'package:metro_city_pulse/data/data_source/remote/rest/rest_api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DependencyManager {

  late RestApiService _apiService;
  late DbManager _dbManager;
  late SharedPreferences _sharedPref;

  DependencyManager._privateConstructor();

  static final DependencyManager _instance = DependencyManager._privateConstructor();

  static DependencyManager get() => _instance;

 // Function? _handleUnAuthorizedError;

  Future<void> init() async {
    await _initSecureSharedPref();
    await _initDbManager();
    await _initApiService();
  }

  Future<void> resetApiService() async {
    await _initApiService();
  }

  Future<void> _initApiService() async {
    // final env = await _sharedPref.getEnv();
    // final dio = Dio(BaseOptions(
    //   baseUrl: env.restBaseUrl,
    //  // headers: headers,
    //   connectTimeout: const Duration(seconds: 30),
    // ));
    // _addInterceptors(dio);
    // _apiService = RestApiService(dio);
  }

  // void _addInterceptors(Dio dio) {
  //   dio.interceptors.add(
  //       InterceptorsWrapper(
  //         onRequest: (RequestOptions options, RequestInterceptorHandler handler) async {
  //           final accessToken = await _sharedPref.getString(keyAccessToken);
  //           if(accessToken != null) {
  //             options.headers["Homeboy-Auth"] = accessToken;
  //           }
  //           return handler.next(options);
  //         },
  //         onResponse: (Response response, ResponseInterceptorHandler handler) {
  //           if (response.statusCode == 401) {
  //             _handleUnAuthorizedError?.call();
  //           }
  //           return handler.next(response);
  //         },
  //         onError: (DioException err, ErrorInterceptorHandler handler) {
  //           if (err.response != null && err.response?.statusCode == 401) {
  //             _handleUnAuthorizedError?.call();
  //           }
  //           return handler.next(err);
  //         },
  //       ));
  //   if (kDebugMode) {
  //     // dio.interceptors.add(LogInterceptor(requestBody: true));
  //   }
  // }

  Future<void> _initSecureSharedPref() async {
    _sharedPref = await SharedPreferences.getInstance();
  }

  Future<void> _initDbManager() async {
    _dbManager = await DbManager.getInstance();
  }

  RestApiService getApiService() => _apiService;

  DbManager getDbManager() => _dbManager;

  SharedPreferences getSharedPref() => _sharedPref;


  // void setUnAuthorizationHandler(Function? callback) {
  //   _handleUnAuthorizedError = callback;
  // }
}