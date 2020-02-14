import 'package:flutter/material.dart';
import 'package:msp/models/committee.dart';
import 'package:msp/models/project.dart';
import 'package:msp/models/session.dart';
import 'package:msp/pages/home.dart';
import 'package:msp/pages/tabs_screens/items_widgets/items_detailed_screens/detailed_committee_screen.dart';
import 'package:msp/pages/tabs_screens/items_widgets/items_detailed_screens/detailed_event_screen.dart';
import 'package:msp/pages/tabs_screens/items_widgets/items_detailed_screens/detailed_project_screen.dart';
import 'package:msp/pages/tabs_screens/items_widgets/items_detailed_screens/detailed_session_screen.dart';
import 'package:msp/utils/constants.dart';
import 'package:page_transition/page_transition.dart';

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case homeRoute:
        return MaterialPageRoute(builder: (_) => Home());
      case detailedEventRoute:
        var data = settings.arguments as List;
        return MaterialPageRoute(
            builder: (_) => DetailedEventScreen(data[0], data[1]));
      case detailedSessionRoute:
        var data = settings.arguments as Session;
        return MaterialPageRoute(builder: (_) => DetailedSessionScreen(data));
      case detailedProjectRoute:
        var data = settings.arguments as Project;
        return MaterialPageRoute(builder: (_) => DetailedProjectScreen(data));
      case detailedCommitteeRoute:
        var data = settings.arguments as Committee;
        return PageTransition(
          child: DetailedCommitteeScreen(data),
          type: PageTransitionType.fade,
          duration: Duration(milliseconds: 600)
        );
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                      child: Text('No route defined for ${settings.name}')),
                ));
    }
  }
}
