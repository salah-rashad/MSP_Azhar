import 'dart:core';

import 'package:auto_direction/auto_direction.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:msp/models/playlist.dart';
import 'package:msp/models/session.dart';
import 'package:msp/services/api_services.dart';
import 'package:msp/services/open_url.dart';
import 'package:msp/ui/app_theme.dart';
import 'package:msp/utils/constants.dart';

class SessionItem extends StatelessWidget {
  final Session session;
  final Animation animation;
  final AnimationController animationController;
  final GlobalKey<ScaffoldState> scaffoldKey;

  const SessionItem(
      this.session, this.animation, this.animationController, this.scaffoldKey);

  Widget _buildSessionCard(BuildContext context, Session session) {
    return AnimatedBuilder(
      animation: animationController,
      builder: (BuildContext context, Widget child) {
        return FadeTransition(
          opacity: animation,
          child: new Transform(
            transform: new Matrix4.translationValues(
                0.0, 30 * (1.0 - animation.value), 0.0),
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
                  future: API.fetchPlaylist(session, scaffoldKey),
                  builder: (context, snapshot) {
                    PlayList playlist = snapshot.data;

                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return SpinKitPulse(
                        size: 26,
                        duration: Duration(seconds: 2),
                        color: AppTheme.nearlyWhite.withOpacity(0.5),
                      );
                    } else if (playlist != null) {
                      return GestureDetector(
                        onTap: () => Navigator.pushNamed(
                            context, detailedSessionRoute,
                            arguments: session),
                        child: Container(
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
                                                playlist.items.length
                                                    .toString(),
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
                        ),
                      );
                    } else {
                      return Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 32.0, vertical: 16.0),
                        child: Center(
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
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
                                    SizedBox(height: 4.0),
                                    Text(
                                      "Failed to load in-app player for this playlist, open on YouTube instead?",
                                      style: TextStyle(
                                        color: AppTheme.tab4Secondary,
                                        fontSize: 12.0,
                                        shadows: [
                                          Shadow(
                                            color: AppTheme.nearlyBlack,
                                            offset: Offset(0.5, 0.5),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Material(
                                color: Colors.transparent,
                                child: IconButton(
                                  onPressed: () => openURL(session.courseLink),
                                  icon: Icon(
                                    FontAwesomeIcons.youtube,
                                    color: AppTheme.white,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    }
                  }),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildSessionCard(context, session);
  }
}
