# AutoLangx

[![pub package](https://img.shields.io/pub/v/auto_langx.svg)](https://pub.dev/packages/auto_langx)
[![License](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE)

**AutoLangx** is a powerful Flutter package that automatically translates all text in your app dynamically using Google Cloud Translation API - just like having Google Translate built into your app!

No `.arb` files, no `.json` files, no complicated setup. Just add `.autoTr()` to any text and it becomes translatable instantly.

## ✨ Features

- 🌍 **Dynamic Real-time Translation** - Translate text at runtime using Google Cloud Translation API
- 🚀 **Zero Configuration** - No .arb, .json, or .env files needed
- 💾 **Smart Caching** - Automatic local caching with SharedPreferences to reduce API calls
- 📱 **Offline Support** - Works offline for previously cached translations
- 🔄 **Instant Language Switching** - Change app language with a single function call
- 🌐 **Unlimited Languages** - Support for all languages available in Google Translate
- ⚡ **Simple API** - Just use `.autoTr()` extension on any string
- 🎯 **No State Management Required** - Uses ChangeNotifier for reactivity

## 📦 Installation

Add this to your package's `pubspec.yaml` file:
```yaml
dependencies:
  auto_langx: ^1.0.0
```

Then run:
```bash
flutter pub get
```

## 🔑 Setup Google Cloud Translation API

1. Go to [Google Cloud Console](https://console.cloud.google.com/)
2. Create a new project or select existing one
3. Enable the **Cloud Translation API**
4. Go to **APIs & Services > Credentials**
5. Click **Create Credentials > API Key**
6. Copy your API key

## 🚀 Usage

### 1. Initialize AutoLangx

Initialize the package in your `main()` function:
```dart
import 'package:flutter/material.dart';
import 'package:auto_langx/auto_langx.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize with your Google API key
  await AutoLangxController.instance.init("YOUR_GOOGLE_API_KEY");
  
  runApp(MyApp());
}
```

### 2. Use .autoTr() Extension

Simply add `.autoTr()` to any string to make it translatable:
```dart
class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: "Welcome".autoTr(),
      ),
      body: Column(
        children: [
          "Hello, how are you?".autoTr(),
          "This text will be translated automatically".autoTr(
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
```

### 3. Change Language

Switch the entire app language with a single function call:
```dart
// Change to Urdu
await AutoLangxController.instance.changeLanguage('ur');

// Change to Spanish
await AutoLangxController.instance.changeLanguage('es');

// Change to French
await AutoLangxController.instance.changeLanguage('fr');

// Back to English
await AutoLangxController.instance.changeLanguage('en');
```

All `.autoTr()` widgets automatically update when language changes!

### 4. Language Selector Example
```dart
ElevatedButton(
  onPressed: () async {
    await AutoLangxController.instance.changeLanguage('ur');
  },
  child: Text('اردو'),
),
ElevatedButton(
  onPressed: () async {
    await AutoLangxController.instance.changeLanguage('en');
  },
  child: Text('English'),
),
```

### 5. Clear Cache (Optional)
```dart
// Clear all cached translations
await AutoLangxController.instance.clearCache();
```

## 🌍 Supported Languages

All languages supported by Google Cloud Translation API, including:

- English (en)
- Urdu (ur)
- Arabic (ar)
- Spanish (es)
- French (fr)
- German (de)
- Chinese (zh)
- Japanese (ja)
- Korean (ko)
- Hindi (hi)
- And 100+ more!

[See full list](https://cloud.google.com/translate/docs/languages)

## 💡 How It Works

1. **First Call**: Text is sent to Google Cloud Translation API
2. **Caching**: Translation is automatically cached locally using SharedPreferences
3. **Subsequent Calls**: Cached translation is used (works offline!)
4. **Language Change**: All widgets with `.autoTr()` automatically rebuild with new translations
5. **Persistence**: Last selected language is saved and restored on app restart

## 📝 License

MIT License - see the [LICENSE](LICENSE) file for details

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## 🐛 Issues

Found a bug? Please [open an issue](https://github.com/Ali02-dev/auto_langx/issues)

---

Made with ❤️ for the Flutter community