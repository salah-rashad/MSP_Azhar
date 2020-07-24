import 'dart:io';

import 'package:auto_direction/auto_direction.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:intl/intl.dart' as Intl;
import 'package:msp/models/committee.dart';
import 'package:msp/models/project.dart';
import 'package:msp/pages/home.dart';
import 'package:msp/pages/tabs_screens/items_widgets/staff_item.dart';
import 'package:msp/ui/app_theme.dart';
import 'package:url_launcher/url_launcher.dart';

//List<Widget> texts = <Widget>[];
Committee _committee;

class DetailedCommitteeScreen extends StatefulWidget {
  final Committee committee;

  const DetailedCommitteeScreen(this.committee);

  @override
  _DetailedCommitteeScreenState createState() =>
      _DetailedCommitteeScreenState();
}

class _DetailedCommitteeScreenState extends State<DetailedCommitteeScreen> {
  @override
  void initState() {
    _committee = widget.committee;

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      statusBarBrightness:
          Platform.isAndroid ? Brightness.light : Brightness.light,
      systemNavigationBarColor: Colors.white,
      systemNavigationBarDividerColor: Colors.grey,
      systemNavigationBarIconBrightness: Brightness.light,
    ));
    super.initState();
  }

  @override
  void dispose() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness:
          Platform.isAndroid ? Brightness.dark : Brightness.light,
      systemNavigationBarColor: Colors.white,
      systemNavigationBarDividerColor: Colors.grey,
      systemNavigationBarIconBrightness: Brightness.dark,
    ));
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: _committee.color,
      body: Column(
        children: <Widget>[
          Builder(
            builder: (context) {
              if (_committee.id == 6) {
                return Container();
              }
              return SizedBox(
                height: 30,
              );
            },
          ),
          Hero(
            tag: "/ImageTag/${_committee.id}",
            child: Container(
              width: size.width,
              decoration: BoxDecoration(
                  color: _committee.color,
                  borderRadius: BorderRadius.circular(0.0)),
              child: _committee.image.isNotEmpty
                  ? Image.asset(
                      _committee.image,
                      fit: BoxFit.contain,
                    )
                  : Container(
                      color: _committee.color,
                    ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 16.0),
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Hero(
                        tag: "/TitleTag/${_committee.id}",
                        child: Material(
                          color: Colors.transparent,
                          child: Text(
                            _committee.title + " ",
                            style: TextStyle(
                              color: AppTheme.nearlyWhite,
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              shadows: [
                                Shadow(
                                  color: AppTheme.nearlyBlack,
                                  offset: Offset(1, 1),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Expanded(
                                    child: Markdown(
                      data: _committee.description,
                      shrinkWrap: true,
                      padding: EdgeInsets.all(0.0),
                      styleSheet: MarkdownStyleSheet(
                        
                        p: TextStyle(color: AppTheme.white, fontSize: 16.0),
                        listBullet: TextStyle(
                            color: AppTheme.nearlyWhite, fontSize: 16.0),
                        
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

// Text(
//   _committee.description,
//   style: TextStyle(
//       fontFamily: "Roboto",
//       fontWeight: FontWeight.w400,
//       fontSize: 16,
//       letterSpacing: 0.2,
//       color: AppTheme.nearlyWhite.withOpacity(0.8)),
// ),
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
