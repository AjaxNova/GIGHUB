import 'dart:async';

import 'package:flutter/material.dart';

class AnimatedTextWidget extends StatefulWidget {
  final String text;
  final TextStyle textStyle;

  const AnimatedTextWidget({
    Key? key,
    required this.text,
    required this.textStyle,
  }) : super(key: key);

  @override
  _AnimatedTextWidgetState createState() => _AnimatedTextWidgetState();
}

class _AnimatedTextWidgetState extends State<AnimatedTextWidget> {
  bool _isVisible = true;

  @override
  void initState() {
    super.initState();

    Timer.periodic(const Duration(milliseconds: 1000), (timer) {
      if (mounted) {
        setState(() {
          _isVisible = !_isVisible;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: _isVisible ? 0.8 : 0.0, // Adjust the opacity values here
      duration: const Duration(milliseconds: 500),
      child: Text(
        widget.text,
        style: widget.textStyle,
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
