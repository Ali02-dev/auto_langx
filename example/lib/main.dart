import 'package:flutter/material.dart';
import 'package:auto_langx/auto_langx.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await AutoLangxController.instance
      .init("AIzaSyB9tvs9tTAJ3MZyRwiHaih-gxKkCzIsWdo");

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AutoLangx Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _currentLanguage = 'en';

  @override
  void initState() {
    super.initState();
    _currentLanguage = AutoLangxController.instance.currentLanguage;
    AutoLangxController.instance.addListener(_onLanguageChanged);
  }

  @override
  void dispose() {
    AutoLangxController.instance.removeListener(_onLanguageChanged);
    super.dispose();
  }

  void _onLanguageChanged() {
    setState(() {
      _currentLanguage = AutoLangxController.instance.currentLanguage;
    });
  }

  Future<void> _changeLanguage(String languageCode) async {
    await AutoLangxController.instance.changeLanguage(languageCode);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: "AutoLangx Demo".autoTr(),
        elevation: 2,
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Language Selector
            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    "Select Language".autoTr(
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: () => _changeLanguage('en'),
                            icon: const Icon(Icons.language),
                            label: const Text('English'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: _currentLanguage == 'en'
                                  ? Colors.blue
                                  : Colors.grey[300],
                              foregroundColor: _currentLanguage == 'en'
                                  ? Colors.white
                                  : Colors.black,
                              padding: const EdgeInsets.symmetric(vertical: 12),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: () => _changeLanguage('ur'),
                            icon: const Icon(Icons.language),
                            label: const Text('اردو'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: _currentLanguage == 'ur'
                                  ? Colors.blue
                                  : Colors.grey[300],
                              foregroundColor: _currentLanguage == 'ur'
                                  ? Colors.white
                                  : Colors.black,
                              padding: const EdgeInsets.symmetric(vertical: 12),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: () => _changeLanguage('es'),
                            icon: const Icon(Icons.language),
                            label: const Text('Español'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: _currentLanguage == 'es'
                                  ? Colors.blue
                                  : Colors.grey[300],
                              foregroundColor: _currentLanguage == 'es'
                                  ? Colors.white
                                  : Colors.black,
                              padding: const EdgeInsets.symmetric(vertical: 12),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: () => _changeLanguage('fr'),
                            icon: const Icon(Icons.language),
                            label: const Text('Français'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: _currentLanguage == 'fr'
                                  ? Colors.blue
                                  : Colors.grey[300],
                              foregroundColor: _currentLanguage == 'fr'
                                  ? Colors.white
                                  : Colors.black,
                              padding: const EdgeInsets.symmetric(vertical: 12),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Demo Content
            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    "Welcome to AutoLangx".autoTr(
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                    const SizedBox(height: 12),
                    "This is an automatic translation demo".autoTr(
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 20),
                    "Features:".autoTr(
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    _buildFeatureItem("Dynamic real-time translation"),
                    _buildFeatureItem("No .arb or .json files needed"),
                    _buildFeatureItem("Automatic caching for offline use"),
                    _buildFeatureItem("Supports unlimited languages"),
                    _buildFeatureItem("Simple API with .autoTr() extension"),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Sample Content Card
            Card(
              elevation: 4,
              color: Colors.orange[50],
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    "Sample Content".autoTr(
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.orange,
                      ),
                    ),
                    const SizedBox(height: 12),
                    "Hello, how are you today?".autoTr(
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 8),
                    "The weather is beautiful".autoTr(
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 8),
                    "Thank you for using AutoLangx!".autoTr(
                      style: const TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureItem(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: text.autoTr(
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
