import 'package:flutter/material.dart';
import 'package:msp/models/event.dart';
import 'package:msp/models/session.dart';
import 'package:msp/pages/home.dart';
import 'package:msp/pages/items_full_screens/full_event_screen.dart';
import 'package:msp/pages/items_full_screens/full_session_screen.dart';
import 'package:msp/utils/constants.dart';

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case homeRoute:
        return MaterialPageRoute(builder: (_) => Home());
      case fullEventRoute:
        var data = settings.arguments as List;
        return MaterialPageRoute(builder: (_) => FullEventScreen(data[0], data[1]));
      case fullSessionRoute:
        var data = settings.arguments as Session;
        return MaterialPageRoute(builder: (_) => FullSessionScreen(data));
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}')),
          ));
    }
  }
}