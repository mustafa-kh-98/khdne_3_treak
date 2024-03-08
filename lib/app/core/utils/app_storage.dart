import 'package:get_storage/get_storage.dart';

abstract class AppStorage {
  static final _getStorage = GetStorage();

  //region Keys

  static const DARK_MODE_KEY = 'DARK_MODE_KEY';
  static const LANGUAGE_KEY = "LANGUAGE_KEY";
  static const IS_LOGGED_IN = "IS_LOGGED_IN";
  static const IS_SHOW_INTRO = "IS_SHOW_INTRO";
  static const TOKEN_KEY = "TOKEN_KEY";
  static const USER = "USER";
  static const CARS_TYPE = "CARS_TYPE";

  //endregion

  static T? read<T>(String key) => _getStorage.read<T>(key);

  static Future write<T>(String key, T value) => _getStorage.write(key, value);

  static Future remove(String key) => GetStorage().remove(key);

  static Future removeAll() => GetStorage().erase();
  static Future cashList(List<dynamic>data,storageKey)async{
    List<Map<String, dynamic>> toCash = [];
    for (var element in data) {
      toCash.add(element.toJson());
    }
    write(storageKey, toCash);
  }
}
