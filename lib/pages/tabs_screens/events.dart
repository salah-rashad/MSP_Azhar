import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:msp/models/event.dart';
import 'package:msp/pages/tabs_screens/items_widgets/event_item.dart';
import 'package:msp/services/api_services.dart';
import 'package:msp/ui/app_theme.dart';

String _url = "https://msp-app-dashboard.herokuapp.com/api/events";

class EventsScreen extends StatefulWidget {
  final AnimationController animationController;

  const EventsScreen({Key key, this.animationController}) : super(key: key);

  @override
  _EventsScreenState createState() => _EventsScreenState();
}

class _EventsScreenState extends State<EventsScreen>
    with TickerProviderStateMixin {
  final StreamController<double> _streamController = StreamController<double>();

  Future<List<Event>> events;

  Animation<double> topBarAnimation;
  Animation<double> animation;

  final ScrollController scrollController = ScrollController();
  double topBarOpacity = 0.0;

  @override
  void initState() {
    events = API?.getEvents(_url);

    topBarAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
            parent: widget.animationController,
            curve: Interval(0, 0.5, curve: Curves.fastOutSlowIn)));

    scrollController.addListener(() {
      if (scrollController.offset >= 24) {
        if (topBarOpacity != 1.0) {
          _streamController.sink.add(1.0);
        }
      } else if (scrollController.offset <= 24 &&
          scrollController.offset >= 0) {
        if (topBarOpacity != scrollController.offset / 24) {
          _streamController.sink.add(scrollController.offset / 24);
        }
      } else if (scrollController.offset <= 0) {
        if (topBarOpacity != 0.0) {
          _streamController.sink.add(0.0);
        }
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    _streamController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppTheme.background,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: <Widget>[
            getMainListViewUI(),
            getAppBarUI(),
            SizedBox(
              height: MediaQuery.of(context).padding.bottom,
            )
          ],
        ),
      ),
    );
  }

  Widget getMainListViewUI() {
    return FutureBuilder<List<Event>>(
      future: events,
      builder: (BuildContext context, snapshot) {
        List<Event> events = snapshot.data;

        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return new Center(
              child: SpinKitPulse(
                size: 100,
                duration: Duration(seconds: 2),
                color: AppTheme.tab1Secondary.withOpacity(0.5),
              ),
            );
          default:
            if (!snapshot.hasError && events.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Image.asset(
                      "assets/images/EmptyState.png",
                      height: 150,
                      width: 250,
                      fit: BoxFit.scaleDown,
                    ),
                    Text(
                      "No Events Yet".toUpperCase(),
                      style: TextStyle(
                          fontFamily: "Roboto",
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                          letterSpacing: 0.2,
                          color: AppTheme.nearlyBlack.withOpacity(0.8)),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Text(
                        "Stay connected, we may have \nsome events soon!",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: "Roboto",
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                            letterSpacing: 0.2,
                            color: AppTheme.nearlyBlack.withOpacity(0.6)),
                      ),
                    )
                  ],
                ),
              );
            }
            if (!snapshot.hasData)
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Image.asset("assets/images/NoInternetState.png",
                        height: 250, width: 250),
                    Text(
                      "No internet connection\nPlease check your internet\nconnection",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontFamily: "Roboto",
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                          letterSpacing: 0.2,
                          color: AppTheme.nearlyBlack.withOpacity(0.6)),
                    )
                  ],
                ),
              );
            else
              return FadeTransition(
                opacity: topBarAnimation,
                child: DraggableScrollableActuator(
                  child: ListView.builder(
                    controller: scrollController,
                    padding: EdgeInsets.only(
                      top: AppBar().preferredSize.height +
                          MediaQuery.of(context).padding.top +
                          24,
                      bottom: 92 + MediaQuery.of(context).padding.bottom,
                    ),
                    itemCount: events.length,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (BuildContext context, int index) {
                      animation = Tween<double>(begin: 0.0, end: 1.0).animate(
                          CurvedAnimation(
                              parent: widget.animationController,
                              curve: Interval((1 / events.length) * index, 1.0,
                                  curve: Curves.fastOutSlowIn)));

                      var event = events[index];
                      widget.animationController.forward();

                      return EventItem(
                          event, animation, widget.animationController);
                    },
                  ),
                ),
              );
        }
      },
    );
  }

  Widget getAppBarUI() {
    return StreamBuilder<double>(
      stream: _streamController.stream,
      initialData: topBarOpacity,
      builder: (context, snapshot) {
        return Column(
          children: <Widget>[
            AnimatedBuilder(
              animation: widget.animationController,
              builder: (BuildContext context, Widget child) {
                return FadeTransition(
                  opacity: topBarAnimation,
                  child: Transform(
                    transform: Matrix4.translationValues(
                        0.0, 30 * (1.0 - topBarAnimation.value), 0.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppTheme.white.withOpacity(snapshot.data),
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(32.0),
                        ),
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                              color: AppTheme.grey
                                  .withOpacity(0.4 * snapshot.data),
                              offset: const Offset(1.1, 1.1),
                              blurRadius: 10.0),
                        ],
                      ),
                      child: Column(
                        children: <Widget>[
                          SizedBox(
                            height: MediaQuery.of(context).padding.top,
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                left: 16,
                                right: 16,
                                top: 16 - 8.0 * snapshot.data,
                                bottom: 12 - 8.0 * snapshot.data),
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Events',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  fontFamily: AppTheme.fontName,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 22 + 6 - 6 * snapshot.data,
                                  letterSpacing: 1.2,
                                  color: AppTheme.darkerText,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
            )
          ],
        );
      },
    );
  }
}
