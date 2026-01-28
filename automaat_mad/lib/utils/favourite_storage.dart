import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class FavoriteStorage {
  static const _key = "favorite_cars";
  static const _storage = FlutterSecureStorage();

  /// Get list of favorite car IDs
  static Future<Set<String>> getFavorites() async {
    final data = await _storage.read(key: _key);
    if (data == null) return {};
    return Set<String>.from(jsonDecode(data));
  }

  /// Toggle favorite state
  static Future<void> toggleFavorite(String carId) async {
    final favorites = await getFavorites();

    if (favorites.contains(carId)) {
      favorites.remove(carId);
    } else {
      favorites.add(carId);
    }

    await _storage.write(
      key: _key,
      value: jsonEncode(favorites.toList()),
    );
  }

  /// Check if car is favorite
  static Future<bool> isFavorite(String carId) async {
    final favorites = await getFavorites();
    return favorites.contains(carId);
  }
}
