import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BaseSafeScaffold extends StatelessWidget {
  final SystemUiOverlayStyle systemUiOverlayStyle;
  final Widget background;
  final Widget body;

  const BaseSafeScaffold({
    super.key,
    required this.background,
    required this.body,
    required this.systemUiOverlayStyle,
  });

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: systemUiOverlayStyle, // or dark based on bg
      child: Stack(
        children: [
          background,
          SafeArea(
            child: Scaffold(
              backgroundColor: Colors.transparent,
              body: body,
            ),
          ),
        ],
      ),
    );
  }
}