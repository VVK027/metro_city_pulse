
class DbManager {

  //TODO: Implementation of the Local database
  DbManager._privateConstructor();

  static final DbManager _instance = DbManager._privateConstructor();

  static Future<DbManager> getInstance({bool forTest = false}) async {
    await _instance._init(forTest: forTest);
    return _instance;
  }

  Future<void> _init({bool forTest = false}) async {
    if (forTest) {

    } else {

    }
  }

  Future<void> closeDb() async {
  }

  Future<void> clearData() async {

  }

  // static List<CollectionSchema<dynamic>> _getAllTableSchema() => [
  //
  // ];

}