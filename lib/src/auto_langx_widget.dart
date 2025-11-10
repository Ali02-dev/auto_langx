import 'package:flutter/material.dart';
import 'auto_langx_controller.dart'; // ⬅️ IMPORT ADDED

/// Extension on String to add .autoTr() method
extension AutoLangxExtension on String {
  /// Automatically translate this text based on current language
  /// Usage: Text("Hello".autoTr())
  Widget autoTr({
    TextStyle? style,
    TextAlign? textAlign,
    int? maxLines,
    TextOverflow? overflow,
    bool? softWrap,
    double? textScaleFactor,
    TextDirection? textDirection,
    Locale? locale,
    StrutStyle? strutStyle,
    TextWidthBasis? textWidthBasis,
    TextHeightBehavior? textHeightBehavior,
  }) {
    return AutoLangxText(
      this,
      style: style,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      softWrap: softWrap,
      textScaleFactor: textScaleFactor,
      textDirection: textDirection,
      locale: locale,
      strutStyle: strutStyle,
      textWidthBasis: textWidthBasis,
      textHeightBehavior: textHeightBehavior,
    );
  }
}

/// Widget that automatically translates text based on current language
/// Rebuilds when language changes
class AutoLangxText extends StatefulWidget {
  final String text;
  final TextStyle? style;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;
  final bool? softWrap;
  final double? textScaleFactor;
  final TextDirection? textDirection;
  final Locale? locale;
  final StrutStyle? strutStyle;
  final TextWidthBasis? textWidthBasis;
  final TextHeightBehavior? textHeightBehavior;

  const AutoLangxText(
    this.text, {
    Key? key,
    this.style,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.softWrap,
    this.textScaleFactor,
    this.textDirection,
    this.locale,
    this.strutStyle,
    this.textWidthBasis,
    this.textHeightBehavior,
  }) : super(key: key);

  @override
  State<AutoLangxText> createState() => _AutoLangxTextState();
}

class _AutoLangxTextState extends State<AutoLangxText> {
  String? _translatedText;
  // ignore: unused_field
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _translateText();

    // Listen to language changes
    AutoLangxController.instance.addListener(_onLanguageChanged);
  }

  @override
  void dispose() {
    AutoLangxController.instance.removeListener(_onLanguageChanged);
    super.dispose();
  }

  /// Called when language changes
  void _onLanguageChanged() {
    _translateText();
  }

  /// Translate the text
  Future<void> _translateText() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final translated =
          await AutoLangxController.instance.translate(widget.text);
      if (mounted) {
        setState(() {
          _translatedText = translated;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _translatedText = widget.text; // Fallback to original text
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // Show original text while loading first time
    final displayText = _translatedText ?? widget.text;

    return Text(
      displayText,
      style: widget.style,
      textAlign: widget.textAlign,
      maxLines: widget.maxLines,
      overflow: widget.overflow,
      softWrap: widget.softWrap,
      textScaleFactor: widget.textScaleFactor,
      textDirection: widget.textDirection,
      locale: widget.locale,
      strutStyle: widget.strutStyle,
      textWidthBasis: widget.textWidthBasis,
      textHeightBehavior: widget.textHeightBehavior,
    );
  }
}
