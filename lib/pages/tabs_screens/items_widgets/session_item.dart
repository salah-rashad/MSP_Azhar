import 'package:auto_direction/auto_direction.dart';
import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geocoder/model.dart';
import 'package:intl/intl.dart';
import 'package:msp/main.dart';
import 'package:msp/models/event.dart';
import 'package:msp/models/session.dart';
import 'package:msp/ui/app_theme.dart';
import 'package:msp/utils/constants.dart';

import '../../home.dart';

class SessionItem extends StatefulWidget {
  final Session session;
  final Animation animation;
  final AnimationController animationController;
  
  const SessionItem(this.session, this.animation, this.animationController);
  
  @override
  _SessionItemState createState() => _SessionItemState();
}

class _SessionItemState extends State<SessionItem> {
  
  Widget _buildSessionCard(BuildContext context, Session session) {
    return AnimatedBuilder(
      animation: widget.animationController,
      builder: (BuildContext context, Widget child) {
        return FadeTransition(
          opacity: widget.animation,
          child: new Transform(
            transform: new Matrix4.translationValues(
              0.0, 30 * (1.0 - widget.animation.value), 0.0),
            child: Container(
              height: 80.0,
              margin: new EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: new BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: FitnessAppTheme.nearlyBlue,
                    blurRadius: 30.0,
                    // has the effect of softening the shadow
                    spreadRadius: -10.0,
                    // has the effect of extending the shadow
                    offset: Offset(
                      5.0, // horizontal, move right 5
                      5.0, // vertical, move down 5
                    ),
                  )
                ],
                borderRadius: BorderRadius.circular(30.0),
                gradient: new LinearGradient(
                  colors: [
                    FitnessAppTheme.nearlyDarkBlue,
                    FitnessAppTheme.nearlyBlue
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 32.0, vertical: 22.0),
                child: AutoDirection(
                  text: session.name,
                  child: Text(
                    session.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: AppTheme.nearlyWhite,
                      fontSize: 18,
                      shadows: [
                        Shadow(
                          color: AppTheme.nearlyBlack,
                          offset: Offset(0.8, 0.8),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
  
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () =>
        Navigator.pushNamed(context, fullSessionRoute, arguments: widget.session),
      child: _buildSessionCard(context, widget.session),
    );
  }
  
  
}

getDateTime(String date, String time) {
  return DateFormat("dd/MM/yyyy - hh:mm a").format(
    DateTime.parse("$date $time"),
  );
}

Future<Address> getLocation(String link) async {
  final cut1 = link.split("/@");
  final cut2 = cut1[1].split("/data");
  final cut3 = cut2[0].split(",");
  
  double a = double.parse(cut3[0]);
  double b = double.parse(cut3[1]);
  final coordinates = new Coordinates(a, b);
  var addresses =
  await Geocoder.local.findAddressesFromCoordinates(coordinates);
  return addresses.first;
}
