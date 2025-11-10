import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'translation_cache.dart';

/// Main controller for AutoLangx package
/// Manages translation state, API calls, and language switching
class AutoLangxController extends ChangeNotifier {
  static AutoLangxController? _instance;

  /// Get singleton instance
  static AutoLangxController get instance {
    _instance ??= AutoLangxController._();
    return _instance!;
  }

  AutoLangxController._();

  String? _apiKey;
  String _currentLanguage = 'en';
  final TranslationCache _cache = TranslationCache();
  bool _isInitialized = false;

  /// Current selected language code
  String get currentLanguage => _currentLanguage;

  /// Check if controller is initialized
  bool get isInitialized => _isInitialized;

  /// Initialize the controller with Google Cloud Translation API key
  /// Must be called before using any translation features
  Future<void> init(String apiKey) async {
    _apiKey = apiKey;
    _isInitialized = true;

    // Load last saved language
    final savedLanguage = await _cache.getCurrentLanguage();
    if (savedLanguage != null) {
      _currentLanguage = savedLanguage;
      notifyListeners();
    }
  }

  /// Change the app language
  /// All widgets with .autoTr() will automatically update
  Future<void> changeLanguage(String languageCode) async {
    if (_currentLanguage == languageCode) return;

    _currentLanguage = languageCode;
    await _cache.saveCurrentLanguage(languageCode);
    notifyListeners();
  }

  /// Translate text using Google Cloud Translation API
  /// Returns cached translation if available, otherwise calls API
  Future<String> translate(String text) async {
    if (!_isInitialized) {
      throw Exception('AutoLangx not initialized. Call init() first.');
    }

    if (_apiKey == null || _apiKey!.isEmpty) {
      throw Exception('API key is required');
    }

    // If current language is English, return original text
    if (_currentLanguage == 'en') {
      return text;
    }

    // Check cache first
    final cachedTranslation =
        await _cache.getTranslation(_currentLanguage, text);
    if (cachedTranslation != null) {
      return cachedTranslation;
    }

    // Call Google Translate API
    try {
      final url = Uri.parse(
        'https://translation.googleapis.com/language/translate/v2?key=$_apiKey',
      );

      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'q': text,
          'target': _currentLanguage,
          'format': 'text',
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final translatedText =
            data['data']['translations'][0]['translatedText'] as String;

        // Cache the translation
        await _cache.saveTranslation(_currentLanguage, text, translatedText);

        return translatedText;
      } else {
        print(
            'Translation API error: ${response.statusCode} - ${response.body}');
        return text; // Return original text on error
      }
    } catch (e) {
      print('Translation error: $e');
      return text; // Return original text on error
    }
  }

  /// Clear all cached translations
  Future<void> clearCache() async {
    await _cache.clearCache();
  }

  /// Reset controller to initial state
  @override
  void dispose() {
    _instance = null;
    super.dispose();
  }
}
