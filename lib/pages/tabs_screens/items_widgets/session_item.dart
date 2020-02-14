import 'dart:convert';
import 'dart:core';

import 'package:auto_direction/auto_direction.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:msp/models/session.dart';
import 'package:msp/models/playlist.dart';
import 'package:msp/ui/app_theme.dart';
import 'package:msp/utils/constants.dart';
import 'package:http/http.dart' as http;

Session _session;

class SessionItem extends StatefulWidget {
  final Session session;
  final Animation animation;
  final AnimationController animationController;

  const SessionItem(this.session, this.animation, this.animationController);

  @override
  _SessionItemState createState() => _SessionItemState();
}

class _SessionItemState extends State<SessionItem> {
  Future<PlayList> playlist;

  @override
  void initState() {
    _session = widget.session;
    setState(() {
      playlist = fetchPlaylist().catchError((e) => print(e));
    });
    super.initState();
  }

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
              height: 100.0,
              margin: new EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: new BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: AppTheme.tab2Secondary,
                    blurRadius: 30.0,
                    // has the effect of softening the shadow
                    spreadRadius: 0.0,
                    // has the effect of extending the shadow
                    offset: Offset(
                      0.0, // horizontal, move right 5
                      7.0, // vertical, move down 5
                    ),
                  )
                ],
                borderRadius: BorderRadius.circular(30.0),
                gradient: new LinearGradient(
                  colors: [
                    AppTheme.tab2Primary,
                    AppTheme.tab2Secondary,
                  ],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
              ),
              child: FutureBuilder(
                  future: playlist,
                  builder: (context, snapshot) {
                    PlayList playlist = snapshot.data;

                    if (!snapshot.hasData) {
                      return SpinKitPulse(
                        size: 26,
                        duration: Duration(seconds: 2),
                        color: AppTheme.nearlyWhite.withOpacity(0.5),
                      );
                    } else
                      return Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 32.0, vertical: 16.0),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Row(
                            children: <Widget>[
                              Container(
                                height: 60,
                                width: 80,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(4),
                                  child: Image.network(
                                    playlist.items[0].imageDefault,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              SizedBox(width: 16),
                              Flexible(
                                child: AutoDirection(
                                  text: session.name,
                                  child: Text(
                                    session.name,
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      color: AppTheme.nearlyWhite,
                                      fontSize: 14,
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
                              playlist.items.isNotEmpty &&
                                      playlist.items.length != null
                                  ? Row(
                                      children: <Widget>[
                                        SizedBox(width: 16),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: <Widget>[
                                            Text(
                                              playlist.items.length.toString(),
                                              style: TextStyle(
                                                color: AppTheme.white
                                                    .withOpacity(0.8),
                                                fontSize: 22,
                                              ),
                                            ),
                                            Text(
                                              "Videos".toUpperCase(),
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
                      );
                  }),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, detailedSessionRoute,
          arguments: widget.session),
      child: _buildSessionCard(context, widget.session),
    );
  }
}

Future<PlayList> fetchPlaylist() async {
  // Getting playlist id from playlist link.
  String playlistID = _session.courseLink.split("list=")[1];
  // Unique API key of YouTube Data API.
  String API_KEY = "AIzaSyBKnPJ-IxA__CXleozkk2uM-NqKdL4LVjU";

  // Youtube playlist snippet response.
  final response = await http.get(
      'https://www.googleapis.com/youtube/v3/playlistItems?part=snippet&maxResults=50&playlistId=$playlistID&fields=items%2Fsnippet&key=$API_KEY');

  if (response.statusCode == 200) {
    // If the call to the server was successful, parse the JSON.
    return PlayList.fromJson(json.decode(response.body));
  } else {
    // If that call was not successful, throw an error.
    throw Exception('Failed to load playlist');
  }
}
