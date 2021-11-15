import 'package:flutter/material.dart';

///This class Provides a viewport that doesn't have
///overscroll glow effect.
///It will be relocated if needed elsewhere.
class MyBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}
