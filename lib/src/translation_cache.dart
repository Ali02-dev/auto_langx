import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

/// Manages local caching of translations using SharedPreferences
class TranslationCache {
  static const String _cachePrefix = 'autolangx_';
  static const String _languageKey = 'autolangx_current_language';

  /// Save a translation to cache
  /// Key format: autolangx_{languageCode}_{originalText}
  Future<void> saveTranslation(
    String languageCode,
    String originalText,
    String translatedText,
  ) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final key = _buildCacheKey(languageCode, originalText);
      await prefs.setString(key, translatedText);
    } catch (e) {
      print('Error saving translation to cache: $e');
    }
  }

  /// Get a cached translation
  /// Returns null if not found in cache
  Future<String?> getTranslation(
    String languageCode,
    String originalText,
  ) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final key = _buildCacheKey(languageCode, originalText);
      return prefs.getString(key);
    } catch (e) {
      print('Error getting translation from cache: $e');
      return null;
    }
  }

  /// Save the current language code
  Future<void> saveCurrentLanguage(String languageCode) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_languageKey, languageCode);
    } catch (e) {
      print('Error saving current language: $e');
    }
  }

  /// Get the saved language code
  /// Returns null if no language was saved
  Future<String?> getCurrentLanguage() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getString(_languageKey);
    } catch (e) {
      print('Error getting current language: $e');
      return null;
    }
  }

  /// Clear all cached translations
  Future<void> clearCache() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final keys = prefs.getKeys();
      for (final key in keys) {
        if (key.startsWith(_cachePrefix)) {
          await prefs.remove(key);
        }
      }
    } catch (e) {
      print('Error clearing cache: $e');
    }
  }

  /// Build cache key from language code and original text
  String _buildCacheKey(String languageCode, String originalText) {
    // Create a simple hash-like key to avoid special characters
    final encoded = base64Encode(utf8.encode(originalText));
    return '$_cachePrefix${languageCode}_$encoded';
  }
}
