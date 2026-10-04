import 'package:flutter/material.dart';

class ResponsiceUtils {
  static double contentWidth(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    if (width >= 1000) {
      return 700;
    } else if (width >= 600) {
      return 550;
    } else {
      return width - 32;
    }
  }
}
