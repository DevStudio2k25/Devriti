import 'package:flutter/material.dart';

class TypingTextAnimation extends StatefulWidget {
  final String text;
  final TextStyle? style;
  final Duration duration;
  final VoidCallback? onTextUpdate;

  const TypingTextAnimation({
    super.key,
    required this.text,
    this.style,
    this.duration = const Duration(milliseconds: 30),
    this.onTextUpdate,
  });

  @override
  State<TypingTextAnimation> createState() => _TypingTextAnimationState();
}

class _TypingTextAnimationState extends State<TypingTextAnimation> {
  String _displayedText = '';
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _startTyping();
  }

  void _startTyping() async {
    for (int i = 0; i < widget.text.length; i++) {
      if (!mounted) return;
      await Future.delayed(widget.duration);
      if (!mounted) return;
      setState(() {
        _currentIndex = i + 1;
        _displayedText = widget.text.substring(0, _currentIndex);
      });

      // Trigger scroll callback every few characters
      if (i % 10 == 0 && widget.onTextUpdate != null) {
        widget.onTextUpdate!();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Text(_displayedText, style: widget.style);
  }
}
