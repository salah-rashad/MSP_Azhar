import 'dart:async';

import 'package:auto_direction/auto_direction.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as Intl;
import 'package:msp/models/event.dart';
import 'package:msp/pages/home.dart';
import 'package:msp/pages/tabs_screens/items_widgets/topic_item.dart';
import 'package:msp/ui/app_theme.dart';
import 'package:url_launcher/url_launcher.dart';

//List<Widget> texts = <Widget>[];

class FullEventScreen extends StatelessWidget {
  final Event event;
  final String location;

  const FullEventScreen(this.event, this.location);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: AppTheme.nearlyBlack),
          brightness: Brightness.light,
          title: Text(event.title, style: FitnessAppTheme.title),
          backgroundColor: FitnessAppTheme.nearlyWhite,
        ),
        floatingActionButton: FloatingActionButton.extended(
          backgroundColor: FitnessAppTheme.nearlyDarkBlue,
          onPressed: () => launchURL(event.formLink),
          label: Text("Enroll Now".toUpperCase()),
        ),
        body: ListView(
          padding: EdgeInsets.only(bottom: 60),
          children: <Widget>[
            Container(child: getImageFromAPI(event.img, 200, size.width)),
            SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
//                  StreamBuilder(
//                    stream: _streamController.stream,
//                    builder: (context, snapshot) {
//                      if (snapshot == null || !snapshot.hasData) {
//                        return Column(
//                          children: texts,
//                        );
//                      } else {
//                        return Column(
//                          children: snapshot.data,
//                        );
//                      }
//                    },
//                  )
                  Row(
                    children: <Widget>[
                      Container(
                        width: 130,
                        child: Text(
                          "Date & Time:".toUpperCase(),
                          style: FitnessAppTheme.title,
                        ),
                      ),
                      Flexible(
                        child: Text(
                          getDateTime(event.date, event.time),
                          style: FitnessAppTheme.subtitle,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        width: 130,
                        child: Text(
                          "Location:".toUpperCase(),
                          style: FitnessAppTheme.title,
                        ),
                      ),
                      Flexible(
                        child: InkWell(
                          onTap: () => launchURL(event.location),
                          child: Text(
                            location,
                            style: TextStyle(
                                color: FitnessAppTheme.nearlyBlue2,
                                decoration: TextDecoration.underline,
                                decorationThickness: 0.3),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Row(
                    children: <Widget>[
                      Container(
                        width: 130,
                        child: Text(
                          "Fees:".toUpperCase(),
                          style: FitnessAppTheme.title,
                        ),
                      ),
                      Flexible(
                        child: Text(
                          event.price.contains(new RegExp('[A-Z]'))
                              ? event.price
                              : event.price + " EGP",
                          style: FitnessAppTheme.subtitle,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  event.topics.isEmpty
                      ? Container()
                      : ExpandablePanel(
                          initialExpanded: false,
                          header: Container(
                            height: 50,
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Topics:".toUpperCase(),
                                style: FitnessAppTheme.title,
                              ),
                            ),
                          ),
                          expanded: Container(
                            height: 200,
                            child: ListView.builder(
                                itemCount: event.topics.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return TopicItem(event.topics[index], index);
                                }),
                          ),
                          tapHeaderToExpand: true,
                          tapBodyToCollapse: true,
                          hasIcon: true,
                        ),
                  SizedBox(height: 8),
                  ExpandablePanel(
                    initialExpanded: true,
                    header: Container(
                      height: 50,
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Description:".toUpperCase(),
                          style: FitnessAppTheme.title,
                        ),
                      ),
                    ),
                    expanded: AutoDirection(
                      text: event.description,
                      child: Text(
                        event.description,
                        style: FitnessAppTheme.subtitle,
                      ),
                    ),
                    tapHeaderToExpand: true,
                    tapBodyToCollapse: true,
                    hasIcon: true,
                  ),
                ],
              ),
            )
          ],
        ));
  }
}

getDateTime(String date, String time) {
  return Intl.DateFormat("dd/MM/yyyy - hh:mm a").format(
    DateTime.parse("$date $time"),
  );
}

launchURL(String url) async {
  String mUrl = url;
  if (await canLaunch(mUrl)) {
    await launch(mUrl);
  } else {
    throw 'Could not launch $mUrl';
  }
}
