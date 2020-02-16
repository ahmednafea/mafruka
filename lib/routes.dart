import 'package:Mafruka/modules/core/screens/home_screen.dart';
import 'package:flutter/material.dart';

Map<String, WidgetBuilder> _routes;

Map<String, WidgetBuilder> routes() {
  if (_routes == null) {
    _routes = {"home_screen": (context) => HomeScreen()};
  }
  return _routes;
}
