import 'package:flutter/foundation.dart';

import 'config_rep.dart';

abstract class BaseConfig<T> implements ConfigRep<T> {

  @protected
  Future<String?> getConfigStr(String key);

  @protected
  Future<T?> saveConfig(String key, String? value);

  Future<T?> getConfig(String key);

  Future<int> setConfig(T value);

  @override
  Future<String> getString(String key, String defValue) async {
    final configValue = await getConfigStr(key);
    return configValue ?? defValue;
  }

  @override
  Future<String?> getStringOrNull(String key) async {
    final configValue = await getConfigStr(key);
    return configValue;
  }

  @override
  Future<T?> setString(String key, String value) {
    return saveConfig(key, value);
  }

  @override
  Future<int> getInt(String key, int defValue) async {
    final configValue = await getConfigStr(key);
    if (configValue == null) return defValue;
    final int? value = int.tryParse(configValue);
    if (value != null)
      return value;
    else
      return defValue;
  }

  @override
  Future<T?> setInt(String key, int value) {
    final valueStr = value.toString();
    return saveConfig(key, valueStr);
  }

  @override
  Future<double> getDouble(String key, double defValue) async {
    final configValue = await getConfigStr(key);
    if (configValue == null) return defValue;
    final double? value = double.tryParse(configValue);
    if (value != null)
      return value;
    else
      return defValue;
  }

  @override
  Future<T?> setDouble(String key, double value) {
    final valueStr = value.toString();
    return saveConfig(key, valueStr);
  }

  @override
  Future<bool> getBool(String key, bool defValue) async {
    final configValue = await getConfigStr(key);
    if (configValue == null) return defValue;
    final bool value = configValue == 'true';
    if (value != null)
      return value;
    else
      return defValue;
  }

  @override
  Future<T?> setBool(String key, bool value) {
    final valueStr = value.toString();
    return saveConfig(key, valueStr);
  }
}
