import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geocoder/model.dart';
import 'package:intl/intl.dart';
import 'package:msp/main.dart';
import 'package:msp/models/event.dart';
import 'package:msp/ui/app_theme.dart';
import 'package:msp/utils/constants.dart';

import '../../home.dart';

class EventItem extends StatefulWidget {
  final Event event;
  final Animation animation;
  final AnimationController animationController;

  const EventItem(this.event, this.animation, this.animationController);

  @override
  _EventItemState createState() => _EventItemState();
}

class _EventItemState extends State<EventItem> {
  String location = "";

  @override
  void initState() {
    getLocation(widget.event.location).then((address) {
      setState(() {
        location = address.addressLine;
      });
    });
    super.initState();
  }

  Widget _buildEventCard(BuildContext context, Event event) {
    return AnimatedBuilder(
      animation: widget.animationController,
      builder: (BuildContext context, Widget child) {
        return FadeTransition(
          opacity: widget.animation,
          child: new Transform(
            transform: new Matrix4.translationValues(
                0.0, 30 * (1.0 - widget.animation.value), 0.0),
            child: Container(
              height: 150.0,
              margin: new EdgeInsets.symmetric(horizontal: 16, vertical: 16),
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
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Expanded(
                          child: Align(
                            alignment: Alignment.topCenter,
                            child: ClipOval(
                              child: getImageFromAPI(event.img, 60, 60),
                            ),
                          ),
                        ),
                        Text(
                          event.price.contains(new RegExp('[A-Z]'))
                              ? event.price
                              : event.price + " EGP",
                          style: TextStyle(color: HexColor('#0abde3')),
                        )
                      ],
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          SizedBox(height: 6),
                          Text(
                            event.title,
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
                          SizedBox(height: 8),
                          Text(
                            getDateTime(event.date, event.time),
                            style: TextStyle(
                              color: HexColor('#ffffff').withOpacity(0.7),
                              fontSize: 14,
                            ),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Expanded(
                            child: Align(
                              alignment: Alignment.bottomLeft,
                              child: Text(
                                location,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: HexColor('#ffffff').withOpacity(0.7),
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    event.topics.isNotEmpty
                        ? Row(
                            children: <Widget>[
                              SizedBox(width: 16),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    event.topics.length.toString(),
                                    style: TextStyle(
                                      color: AppTheme.white.withOpacity(0.8),
                                      fontSize: 22,
                                    ),
                                  ),
                                  Text(
                                    "Topics".toUpperCase(),
                                    style: TextStyle(
                                      color: AppTheme.nearlyWhite,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w300,
                                      height: 2,
                                    ),
                                  )
                                ],
                              ),
                            ],
                          )
                        : Container()
                  ],
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
          Navigator.pushNamed(context, fullEventRoute, arguments: [widget.event, location]),
      child: _buildEventCard(context, widget.event),
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
