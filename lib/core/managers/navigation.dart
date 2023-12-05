import 'package:flutter/material.dart';

navigateToNextScreen(context, widget) {
  Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ));
}
