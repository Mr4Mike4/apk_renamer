abstract class ConfigRep<T>{
  Future<String> getString(String key, String defValue);

  Future<String?> getStringOrNull(String key);

  Future<T?> setString(String key, String value);

  Future<int> getInt(String key, int defValue);

  Future<T?> setInt(String key, int value);

  Future<double> getDouble(String key, double defValue);

  Future<T?> setDouble(String key, double value);

  Future<bool> getBool(String key, bool defValue);

  Future<T?> setBool(String key, bool value);
}
