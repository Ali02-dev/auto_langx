import 'package:flutter_test/flutter_test.dart';
import 'package:auto_langx/auto_langx.dart';

void main() {
  test('AutoLangx controller initialization', () {
    final controller = AutoLangxController.instance;
    expect(controller, isNotNull);
    expect(controller.isInitialized, isFalse);
  });

  test('AutoLangx controller init sets API key', () async {
    final controller = AutoLangxController.instance;
    await controller.init('test_api_key');
    expect(controller.isInitialized, isTrue);
    expect(controller.currentLanguage, equals('en'));
  });

  test('AutoLangx extension exists', () {
    final text = "Hello";
    final widget = text.autoTr();
    expect(widget, isNotNull);
  });
}
