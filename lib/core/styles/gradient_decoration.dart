import 'package:flutter/material.dart';

class GradientDecoration {
  static BoxDecoration gradientDecoration(BuildContext context) {
    return BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Theme.of(context).primaryColorLight,
          Theme.of(context).primaryColor
        ],
      ),
    );
  }

  static BoxDecoration gradientDecorationWithRadius(BuildContext context) {
    return BoxDecoration(
      borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(50), bottomRight: Radius.circular(50)),
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Theme.of(context).primaryColorLight,
          Theme.of(context).primaryColor
        ],
      ),
    );
  }
}
