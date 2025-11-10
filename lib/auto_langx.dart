/// AutoLangx - Automatic Translation Package for Flutter
///
/// Dynamically translate your Flutter app using Google Cloud Translation API
/// without creating any .arb or .json files.
///
/// Usage:
/// ```dart
/// // Initialize in main()
/// await AutoLangxController.instance.init("YOUR_GOOGLE_API_KEY");
///
/// // Use in widgets
/// Text("Welcome".autoTr())
///
/// // Change language
/// AutoLangxController.instance.changeLanguage('ur');
/// ```
library auto_langx;

export 'src/auto_langx_controller.dart';
export 'src/auto_langx_widget.dart';
